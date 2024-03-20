/**
 * Retrieves the value of an environment variable.
 *
 * @param {string} env - The name of the environment variable to retrieve.
 * @return {string} The value of the specified environment variable.
 */
const getEnvironmentVariable = (env) => {
  return process.env[env];
};

/**
 * Get pn-data-vault base url.
 *
 * @return {string} pn-data-vault base url.
 */
export const getPnDataVaultBaseUrl = () =>
  getEnvironmentVariable("PN_DATA_VAULT_BASEURL");

/**
 * Get the AWS region for DynamoDB from environment variables.
 *
 * @return {string} The AWS region for DynamoDB.
 */
export const getDynamoAWSRegion = () =>
  getEnvironmentVariable("DYNAMO_AWS_REGION");