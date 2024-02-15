import {
  getRecipientDenomination,
  getConfidentialTimeline,
  getNotificationAddresses,
} from './datavaultService.js';
import { getNotification, getTimeline } from './dynamoDataAccess.js';
import { addUIActions } from './utils.js';

export class IunNotFoundError extends Error {}
export class DeanonymizeError extends Error {}

/**
 * Deanonymizes the notification by fetching and adding tax IDs and addresses to
 * each recipient. This involves asynchronous calls to `pn-datavault` service.
 *
 * @param {Object} notification The notification object to deanonymize.
 */
const deanonymizeNotification = async (notification) => {
  const recipientsId = notification.recipients.map( item => item.recipientId );
  let taxIds = await getRecipientDenomination(recipientsId);
  let notificationAddresses = await getNotificationAddresses(notification.iun);

  notification.confidentialDetails = {};
  notification.confidentialDetails.recipients = taxIds.map((item, i) => {
    if (notificationAddresses[i]) {
      return {
        ...item,
        ...notificationAddresses[i]
      };
    } else {
      return item;
    }
  });

  notification.confidentialDetails.timeline = await getConfidentialTimeline(notification.iun);
};

/**
 * Processes an event by retrieving the notification using the IUN and appending
 * its timeline. If the `deanonymize` flag in the event is set to true, the
 * method also performs deanonymization on both the notification and its
 * timeline. Moreover, it prepares notification timeline actions to be used in
 * the UI.
 *
 * @param {string} iun - The IUN of the notification.
 * @param {boolean} deanonymize - A boolean flag indicating whether to
 * deanonymize the notification and its timeline.
 * @returns {Promise<Object>} A promise that resolves to an object containing
 * the notification object, enriched with its sorted timeline and, if
 * applicable, deanonymized. The notification object includes additional UI
 * actions for each timeline event.
 * @throws {IunNotFoundError} Throws an error if no notification is found for
 * the given IUN.
 * @throws {DeanonymizeError} Throws an error if there is a problem during the
 * deanonymization process.
 */
export const packNotification = async (iun, deanonymize) => {
  const notification = await getNotification(iun);

  if (!notification) {
    throw new IunNotFoundError(`No [iun] (${iun}) found.`);
  }

  notification.timeline = await getTimeline(iun);
  // Sort timeline
  notification.timeline.sort((a, b) => {
    return new Date(a.timestamp) - new Date(b.timestamp);
  });

  if (deanonymize) {
    try {
      await deanonymizeNotification(notification);
    } catch (error) {
      throw new DeanonymizeError(`Error during deanonymization: ${error.message}`);
    }
  }

  addUIActions(notification);

  return notification;
};