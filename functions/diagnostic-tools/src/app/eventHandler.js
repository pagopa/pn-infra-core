import { headObject, getObject } from './dataProxy.js';
import { getPaperErrors } from './dynamoDataAccess.js';
import { getEvents } from './timeline.js';
import { checkKeys, makeResponse } from './utils.js';
import {
  packNotification,
  IunNotFoundError,
  DeanonymizeError,
} from './notification.js';

/**
 * Handles various events based on the action specified in the event object.
 * This function acts as a router to delegate the event to the appropriate
 * handler based on the action type.
 *
 * @param {Object} event - The event object containing details about the action
 * to be performed and other necessary data.
 * @returns {Promise<Object>} A promise that resolves to an object containing
 * the HTTP status code and the response body. The response body can vary
 * depending on the action performed.
 */
export const handleEvent = async (event) => {
  try {
    // Ensure the event contains an 'action' key of type string.
    checkKeys(event, [['action', 'string']]);
  } catch (e) {
    return makeResponse(400, `Invalid request: ${e.message}`);
  }

  switch (event.action) {
    case 'HEAD_OBJECT':
    case 'GET_OBJECT':
      try {
        const { fileKey } = checkKeys(event, [['fileKey', 'string']]);
        const res =
          event.action === 'HEAD_OBJECT'
            ? await headObject(fileKey)
            : await getObject(fileKey);
        return makeResponse(res.statusCode, res.body);
      } catch (e) {
        return makeResponse(400, `Invalid request: ${e.message}`);
      }
    case 'GET_NOTIFICATION':
      try {
        const { iun } = checkKeys(event, [['iun', 'string']]);
        const { deanonymize = false } = event;
        try {
          const res = await packNotification(iun, deanonymize);
          return makeResponse(200, res);
        } catch (e) {
          // Handle specific errors related to notifications.
          if (e instanceof IunNotFoundError) {
            return makeResponse(404, {
              message: e.message,
            });
          } else if (e instanceof DeanonymizeError) {
            return makeResponse(500, {
              message: e.message,
            });
          }
        }
        return makeResponse(200, res);
      } catch (e) {
        return makeResponse(400, `Invalid request: ${e.message}`);
      }
    case 'GET_PAPER_ERRORS':
      try {
        const { timelineElementId } = checkKeys(event, [
          ['timelineElementId', 'string'],
        ]);
        const res = await getPaperErrors(timelineElementId)
        return makeResponse(200, res);
      } catch (e) {
        return makeResponse(400, `Invalid request: ${e.message}`);
      }
    case 'GET_TIMELINE_ELEMENT_EVENTS':
      try {
        const { timelineElementId } = checkKeys(event, [
          ['timelineElementId', 'string'],
        ]);
        const res = await getEvents(timelineElementId);
        return makeResponse(res.statusCode, res.body);
      } catch (e) {
        return makeResponse(400, `Invalid request: ${e.message}`);
      }
  }
  return makeResponse(501, `Invalid action!`);
};