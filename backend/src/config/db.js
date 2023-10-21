require('dotenv').config();

const CONFIG = {
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    rowsAsArray: false,
    namedPlaceholders: true,
    waitForConnections: true,
    connectionLimit: 20,
    queueLimit: 0,
    dateStrings: 'date',
};

module.exports = CONFIG;