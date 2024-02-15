
import { InvokeCommand, LambdaClient, LogType } from '@aws-sdk/client-lambda';
import { getAssumeRoleCredentials } from './sts.js';
import { getDataProxyRegion, getDataProxyName } from './config.js';

const dataProxyFunctionName = getDataProxyName();

/**
 * Invoke a Lambda function with a specified function name and payload.
 *
 * @param {string} funcName - Lambda function name.
 * @param {string} payload - Payload.
 * @return {Promise<Object>} The Lambda response.
 */
const invoke = async (funcName, payload) => {
  const credentials = await getAssumeRoleCredentials();
  const client = new LambdaClient({
    region: getDataProxyRegion(),
    credentials,
  });

  const command = new InvokeCommand({
    FunctionName: funcName,
    Payload: JSON.stringify(payload)
  });

  const { Payload } = await client.send(command);
  const parsedPayload = JSON.parse(Buffer.from(Payload).toString());
  parsedPayload.body = JSON.parse(parsedPayload.body);
  return parsedPayload;
};

/**
 * Retrieves an object from `pn-safestorage` or initiates a restore if the object is
 * in Glacier. Generates a signed URL for accessing the object if it is
 * immediately available.
 *
 * @param {string} fileKey - The S3 object key, prefixed with "safestorage://".
 * @return {Promise<Object>} An object containing the state of the object
 * retrieval or restore process.
 */
export const getObject = async (fileKey) => {
  return await invoke(dataProxyFunctionName, {
    action: 'GET_OBJECT',
    fileKey
  });
};

/**
 * Checks the metadata from `pn-safestorage` of an S3 object including storage class
 * and restoration status. It also retrieves object tags and retention
 * information if available.
 *
 * @param {string} fileKey - The S3 object key, prefixed with "safestorage://".
 * @return {Promise<Object>} An object containing metadata about the S3 object.
 */
export const headObject = async (fileKey) => {
  return await invoke(dataProxyFunctionName, {
    action: 'HEAD_OBJECT',
    fileKey
  });
};

/**
 * Retrieves events from `pn-EcRichiesteMetadati` based on a requestId by invoking
 * a diagnostic-data-proxy Lambda function. If `checkRetry` is enabled, it
 * attempts to fetch additional events by appending a .PCRETRY_0, .PCRETRY_1
 * etc.
 *
 * @param {string} requestId - The requestId of pn-EcRichiesteMetadati element's
 * without .PCRETRY_i
 * @param {boolean} [checkRetry=false] - Optional. Specifies whether to add
 * .PCRETRY_i
 * @return {Promise<Object>} An array of events
 */
export const getEcRichiesteMetadati = async (requestId, checkRetry = false) => {
  return await invoke(dataProxyFunctionName, {
    action: 'GET_EC_RICHIESTE_METADATI',
    checkRetry,
    requestId
  });
};