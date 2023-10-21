const CODES = {
    ERROR: {key: 'error', code: 500},
    MISSING_PARAMS: {key: 'missing-params', code: 422},
    EXISTS_ALREADY: {key: 'exists-already', code: 409},
    NOT_FOUND: {key: 'not-found', code: 404},
    SUCCESS: {key: 'success', code: 200},
};

module.exports = CODES;