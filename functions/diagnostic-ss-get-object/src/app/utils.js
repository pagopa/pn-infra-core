/**
 * Creates a response object suitable for returning from a web service endpoint.
 *
 * @param {number} statusCode - The HTTP status code for the response.
 * @param {Object} body - The content of the response body. If provided, this
 * will be JSON stringified.
 * @returns {Object} An object representing the HTTP response, with a
 * 'statusCode' and a 'body' property.
 */
export const makeResponse = (statusCode, body) => {
  return {
    statusCode,
    body: JSON.stringify(body),
  };
};

/**
 * Creates an error response object suitable for returning from a web service
 * endpoint.
 *
 * @param {Error} error - The error containing 'statusCode' property.
 * @returns {Object} An object representing the HTTP response, with a
 * 'statusCode' and a 'errorMessage' property.
 */
export const makeErrorResponse = (error) => {
  return {
    statusCode: error.statusCode | 500,
    errorMessage: error.toString(),
  };
};

/**
 * Creates a custom error type with a specified name.
 *
 * @param {string} name - The name of the custom error.
 * @param {number} statusCode - The status code of the HTTP result.
 * @returns {Error} A new custom Error class.
 */
export const createCustomError = (name, statusCode) => {
  return class extends Error {
    constructor(message) {
      super(message);
      this.name = name;
      this.statusCode = statusCode;
      if (typeof Error.captureStackTrace === "function") {
        Error.captureStackTrace(this, this.constructor);
      } else {
        this.stack = new Error(message).stack;
      }
    }
  };
};