import { createCustomError, makeResponse, makeErrorResponse } from "./utils.js";
import {
  getRecipientDenomination,
  getConfidentialTimeline,
  getNotificationAddresses,
} from "./datavaultService.js";
import { getNotification } from "./dynamoDataAccess.js";

const IunNotFoundError = createCustomError("IunNotFoundError", 404);
const DeanonymizeError = createCustomError("DeanonymizeError", 500);

const deanonymizeNotification = async (iun) => {
  const notification = await getNotification(iun);
  if (!notification) {
    throw new IunNotFoundError(`No [iun] (${iun}) found.`);
  }

  try {
    const recipientsId = notification.recipients.map((item) => item.recipientId);
    let taxIds = await getRecipientDenomination(recipientsId);
    let notificationAddresses = await getNotificationAddresses(notification.iun);

    const confidentialDetails = {};
    confidentialDetails.recipients = taxIds.map((item, i) => {
      if (notificationAddresses[i]) {
        return {
          ...item,
          ...notificationAddresses[i],
        };
      } else {
        return item;
      }
    });
    confidentialDetails.timeline = await getConfidentialTimeline(
      notification.iun
    );

    return confidentialDetails;
  } catch (e) {
    throw new DeanonymizeError(e.message);
  }
};

export const handleEvent = async (event) => {
  const { iun } = event;
  try {
    const result = await deanonymizeNotification(iun);
    console.log('ciaoaaa');
    return makeResponse(200, result);
  } catch (e) {
    return makeErrorResponse(e); 
  }
};
