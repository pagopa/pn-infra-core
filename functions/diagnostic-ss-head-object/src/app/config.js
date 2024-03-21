import 'dotenv/config'

/**
 * Retrieves the value of an environment variable.
 *
 * @param {string} env - The name of the environment variable to retrieve.
 * @return {string} The value of the specified environment variable.
 * @throws {Error} When the environment variable is not defined.
 */
const getEnvironmentVariable = (env) => {
  const value = process.env[env];
  if (!value) {
    throw new Error(`Environment variable ${env} is not defined.`);
  }
  return value;
};

/**
 * Gets the DiagnosticAssumeRole from environment variables.
 *
 * @return {string} The DiagnosticAssumeRole arn.
 */
export const getDiagnosticAssumeRoleArn = () =>
  getEnvironmentVariable('DIAGNOSTIC_ASSUME_ROLE_ARN');

/**
 * Get the AWS region for `diagnostic-data-proxy` Lambda.
 *
 * @return {string} The AWS region for diagnostic-data-proxy.
 */
export const getDataProxyRegion = () =>
  getEnvironmentVariable('DATA_PROXY_REGION');

/**
 * Get the AWS function name for `diagnostic-data-proxy` Lambda.
 *
 * @return {string} The function name for diagnostic-data-proxy.
 */
export const getDataProxyName = () =>
  getEnvironmentVariable('DATA_PROXY_NAME');