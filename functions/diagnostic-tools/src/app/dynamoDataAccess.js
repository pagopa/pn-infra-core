import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import {
  DynamoDBDocumentClient,
  GetCommand,
  QueryCommand,
} from '@aws-sdk/lib-dynamodb';
import { getDynamoAWSRegion } from './config.js';

const client = new DynamoDBClient({ region: getDynamoAWSRegion() });
const dynamo = DynamoDBDocumentClient.from(client);

/**
 * Retrieves a notification from the DynamoDB table 'pn-Notifications' based on
 * the given IUN.
 *
 * @param {string} iun - The IUN for the notification to be retrieved.
 * @return {Promise<Object>} A promise that resolves to the notification object
 * if found, or undefined if not found.
 */
export const getNotification = async (iun) => {
  const command = new GetCommand({
    TableName: 'pn-Notifications',
    Key: {
      iun: iun,
    },
  });
  return (await dynamo.send(command)).Item;
};

/**
 * Retrieves the timeline associated with a given IUN from the 'pn-Timelines'
 * DynamoDB table.
 *
 * @param {string} iun - The unique identifier for which the timeline is to be
 * retrieved.
 * @return {Promise<Array>} A promise that resolves to an array of timeline
 * items related to the provided IUN.
 */
export const getTimeline = async (iun) => {
  const command = new QueryCommand({
    TableName: 'pn-Timelines',
    KeyConditionExpression: 'iun = :iun',
    ExpressionAttributeValues: { ':iun': iun },
  });
  return (await dynamo.send(command)).Items;
};

/**
 * Retrieves the 'pn-PaperRequestError' table for errors associated with a
 * specific requestId.
 *
 * @param {string} requestId - The requestId.
 * @return {Promise<Array>} A promise that resolves to an array of items
 * associated with the requestId.
 */
export const getPaperErrors = async (requestId) => {
  const command = new QueryCommand({
    TableName: 'pn-PaperRequestError',
    KeyConditionExpression: 'requestId = :requestId',
    ExpressionAttributeValues: { ':requestId': requestId },
  });
  return (await dynamo.send(command)).Items;
};
