import axios from 'axios';
import { getPnDataVaultBaseUrl } from './config.js';

const datavaultRecipientsPath = '/datavault-private/v1/recipients/internal';
const datavaultNotificationPath = '/datavault-private/v1/notifications';
/**
 * Fetches the denominations of recipients based on their internal IDs.
 *
 * @param {Array<string>} internalIds An array of internal IDs for which to
 * fetch the denominations.
 * @return {Promise<Object>} A response object containing the denominations of
 * the specified recipients.
 * @throws {Error} If the HTTP request fails for any reason.
 */
export const getRecipientDenomination = async (internalIds) => {
  const pnDataVaultBaseUrl = getPnDataVaultBaseUrl() ?? "";

  const url = `${pnDataVaultBaseUrl}${datavaultRecipientsPath}`;

  try {
    const response = await axios.get(url, {
      params: { internalId: internalIds },
      paramsSerializer: {
        indexes: null, // Serialize params without []: ?internalId=rec1&internalId=rec2...
      },
    });
    return response.data;
  } catch (error) {
    throw error;
  }
};

/**
 * Retrieves the addresses associated with a specific notification, identified
 * by its IUN.
 *
 * @param {string} iun The IUN of the notification for which to fetch addresses.
 * @return {Promise<Object>} A response object containing the addresses related
 * to the given notification.
 * @throws {Error} If the HTTP request fails for any reason.
 */
export const getNotificationAddresses = async (iun) => {
  const pnDataVaultBaseUrl = getPnDataVaultBaseUrl();

  const url = `${pnDataVaultBaseUrl}${datavaultNotificationPath}/${iun}/addresses`;

  try {
    const response = await axios.get(url);
    return response.data;
  } catch (error) {
    throw error;
  }
};

/**
 * Obtains the addresses associated with a recipient, identified by their
 * internal ID.
 *
 * @param {string} internalId The internal ID of the recipient for whom to fetch
 * addresses.
 * @return {Promise<Object>} A response object containing the addresses of the
 * specified recipient.
 * @throws {Error} If the HTTP request fails for any reason.
 */
export const getRecipientAddresses = async (internalId) => {
  const pnDataVaultBaseUrl = getPnDataVaultBaseUrl();

  const url = `${pnDataVaultBaseUrl}${datavaultRecipientsPath}/${internalId}/addresses`;

  try {
    const response = await axios.get(url);
    return response.data;
  } catch (error) {
    throw error;
  }
};

/**
 * Fetches a confidential info of timeline for a notification, using its IUN.
 *
 * @param {string} iun The IUN of the notification for which to fetch the
 * timeline.
 * @return {Promise<Object>} A response object containing the confidential info
 * of timeline events.
 * @throws {Error} If the HTTP request fails for any reason.
 */
export const getConfidentialTimeline = async (iun) => {
  const pnDataVaultBaseUrl = getPnDataVaultBaseUrl();

  const url = `${pnDataVaultBaseUrl}${datavaultNotificationPath}/${iun}/timeline`;

  try {
    const response = await axios.get(url);
    return response.data;
  } catch (error) {
    throw error;
  }
};
