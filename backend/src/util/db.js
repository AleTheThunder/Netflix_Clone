const dbConfig = require('../config/db');
const mysql = require('mysql2/promise');
var pool = undefined;

/** initialize mysql connection pool */
async function initConnectionPool(){
    pool = mysql.createPool({
        host: dbConfig.host,
        user: dbConfig.user,
        password: dbConfig.password,
        database: dbConfig.database,
        rowsAsArray: dbConfig.rowsAsArray,
        namedPlaceholders:dbConfig.namedPlaceholders,
        waitForConnections: dbConfig.waitForConnections,
        connectionLimit: dbConfig.connectionLimit,
        queueLimit: dbConfig.queueLimit,
        dateStrings: dbConfig.dateStrings,
    });

    return pool;
}

/**
 * executes a query and returns the result
 * @param {String} sql sql statement
 * @param {Object} params query parameters
 * @returns query results
 */
function query(sql, params) {
    return new Promise(async (resolve, reject) => {
        const [results, ] = await pool.execute(sql, params);
        resolve(results);
    });
}

// export methods
module.exports = {
    query,
    initConnectionPool
}