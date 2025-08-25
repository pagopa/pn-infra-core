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