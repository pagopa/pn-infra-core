import { STSClient, AssumeRoleCommand } from "@aws-sdk/client-sts";
import { getDiagnosticAssumeRoleArn, getDataProxyRegion } from "./config.js";

/**
 * Gets temporary security credentials by assuming DiagnosticAssumeRole IAM
 * role.
 *
 * @return {Promise<Object>} Temporary security credentials: Access Key ID,
 * Secret Access Key and Session Token
 */
export const getAssumeRoleCredentials = async () => {
  const stsClient = new STSClient({ region: getDataProxyRegion() });
  const assumeRoleCommand = new AssumeRoleCommand({
    RoleArn: getDiagnosticAssumeRoleArn(),
    RoleSessionName: "DiagnosticLambdaSession",
  });

  const { Credentials } = await stsClient.send(assumeRoleCommand);
  return {
    accessKeyId: Credentials.AccessKeyId,
    secretAccessKey: Credentials.SecretAccessKey,
    sessionToken: Credentials.SessionToken,
  };
};
