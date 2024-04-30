class GptError {
  final String errorCode;
  final String cause;
  final String solution;

  GptError(this.errorCode, this.cause, this.solution);
}

class GptErrorData {
  static final Map<int, GptError> errors = {
    401: GptError(
      '401',
      'Invalid Authentication',
      'Cause: Invalid Authentication or The requesting API key is not correct or The requesting API key is not correct.'
          'Solution: Ensure the correct API key and requesting organization are being used or Ensure the API key used is correct, clear your browser cache, or generate a new one.',
    ),
    402: GptError(
      '402',
      'You must be a member of an organization to use the API',
      'Cause: Your account is not part of an organization.'
          'Solution: Contact us to get added to a new organization or ask your organization manager to invite you to an organization.',
    ),
    429: GptError(
      '429',
      'Rate limit reached for requests or You exceeded your current quota, please check your plan and billing details',
      'Cause: You are sending requests too quickly or You have run out of credits or hit your maximum monthly spend.'
          'Solution: Pace your requests. Read the Rate limit guide. Maybe you should buy more credits or learn how to increase your limits.',
    ),
    500: GptError(
      '500',
      'The server had an error while processing your request',
      'Cause: Issue on our servers.'
          'Solution: Retry your request after a brief wait and contact us if the issue persists. Check the status page.',
    ),
    503: GptError(
      '503',
      'The engine is currently overloaded, please try again later',
      'Cause: Our servers are experiencing high traffic.'
          'Solution: Please retry your requests after a brief wait.',
    ),
  };

  static GptError getError(int code) {
    return errors[code] ??
        GptError('$code','Unknown Error', 'Cause: Unknown\nSolution: Unknown');
  }
}
