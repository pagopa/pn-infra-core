
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
 * Checks the metadata from `pn-safestorage` of an S3 object including storage class
 * and restoration status. It also retrieves object tags and retention
 * information if available.
 *
 * @param {string} fileKey - The S3 object key.
 * @return {Promise<Object>} An object containing metadata about the S3 object.
 */
export const headObject = async (fileKey) => {
  if(!fileKey.startsWith('safestorage://')){
    fileKey = 'safestorage://' + fileKey;
  }
  return await invoke(dataProxyFunctionName, {
    action: 'HEAD_OBJECT',
    fileKey
  });
};