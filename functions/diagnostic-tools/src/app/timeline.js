import { getEcRichiesteMetadati } from './dataProxy.js';

/**
 * Gets events from `pn-EcRichiesteMetadati` using `timelineElementId`. The function
 * supports different timelineElementId: `SEND_DIGITAL` and
 * `PREPARE_ANALOG_DOMICILE`.
 *
 * @param {string} event.timelineElementId - The timelineElementId used to
 * determine the requestId of pn-EcRichiesteMetadati.
 * @return {Promise<Object>} A promise that resolves to an array of events
 */
export const getEvents = async (timelineElementId) => {
  let requestId;
  let retry = false;
  if (timelineElementId.startsWith('SEND_DIGITAL.')) {
    requestId = 'pn-delivery-002~' + timelineElementId;
  } else if (timelineElementId.startsWith('PREPARE_ANALOG_DOMICILE.')) {
    requestId = 'pn-cons-000~' + timelineElementId;
    retry = true;
  } else {
    requestId = timelineElementId;
  }
  return await getEcRichiesteMetadati(requestId, retry);
};


/**
 * Recursively searches an object and its nested structures for URIs that begin
 * with "safestorage://". This function is designed to navigate through arrays
 * and objects, identifying any string values that match the specified URI
 * scheme. These URIs are collected and returned in an array, providing a means
 * to extract all safestorage links from complex data structures.
 *
 * @param {Object|Array} obj The object or array to search through for
 * safestorage URIs.
 * @return {Array} An array of strings, each representing a safestorage URI
 * found within the object.
 */
export const extractSafestorageURIs = (obj) => {
  let uris = [];

  const search = (value) => {
    if (Array.isArray(value)) {
      // If the value is an array, search each element
      value.forEach((item) => search(item));
    } else if (typeof value === 'object' && value !== null) {
      // If the value is an object, search each property
      for (let key in value) {
        if (value.hasOwnProperty(key)) {
          search(value[key]);
        }
      }
    } else if (
      typeof value === 'string' &&
      value.startsWith('safestorage://')
    ) {
      // If the value is a string that starts with "safestorage://", add it to
      // the array
      uris.push(value);
    }
  };

  search(obj);
  return uris;
};
