import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import {
  DynamoDBDocumentClient,
  GetCommand,
} from '@aws-sdk/lib-dynamodb';
import { getDynamoAWSRegion } from './config.js';

const client = new DynamoDBClient({ region: getDynamoAWSRegion() ?? 'eu-south-1' });
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