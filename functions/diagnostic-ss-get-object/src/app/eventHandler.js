import { headObject } from "./dataProxy.js";
import { makeResponse, makeErrorResponse } from "./utils.js";

/**
 * Handles an incoming event, attempting to generate a  presigned url of a
 * specified safestorage object.
 *
 * @param {Object} event - The event triggering the function
 * @param {string} event.objectKey - The key of the safestorage object
 *
 * @returns {Promise<Object>} A promise that resolves to a response object.
 */
export const handleEvent = async (event) => {
  const { objectKey } = event;
  try {
    const res = await headObject(objectKey);
    return makeResponse(res.statusCode, res.body);
  } catch (e) {
    return makeErrorResponse(e);
  }
};