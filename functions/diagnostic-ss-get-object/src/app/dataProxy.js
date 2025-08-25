
import { InvokeCommand, LambdaClient, LogType } from '@aws-sdk/client-lambda';
import { getAssumeRoleCredentials } from './sts.js';
import { getDataProxyRegion, getDataProxyName } from './config.js';

const dataProxyFunctionName = getDataProxyName();
const dataProxyRegion = getDataProxyRegion();

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
    region: dataProxyRegion,
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
 * Retrieves an object from `pn-safestorage`. Generates a signed URL for
 * accessing the object if it is immediately available.
 *
 * @param {string} fileKey - The safestorage S3 object key
 * @return {Promise<Object>} An object containing the state of the object
 * retrieval or restore process.
 */
export const getObject = async (fileKey) => {
  return await invoke(dataProxyFunctionName, {
    action: 'GET_OBJECT',
    fileKey
  });
};