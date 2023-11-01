const db = require('../util/db');
const helper = require('../util/helper');
const CODES = require('../util/codes');

/**fetch top 10 content for user*/
async function getTop(country, type, limit){
    if(!helper.isDefined(country) || !helper.isDefined(type)|| !helper.isDefined(limit)) return {data: CODES.MISSING_PARAMS.key, code: CODES.MISSING_PARAMS.code};
    const content = await db.query(
        `CALL TopContentInCountry(:country, :type, :limit)`, 
        {country: country, type: type, limit: limit}

    );

    return {data: content, code: CODES.SUCCESS.code};
}

/**fetch newest content for user*/
async function getLatest(type, limit){
    if(!helper.isDefined(type)|| !helper.isDefined(limit)) return {data: CODES.MISSING_PARAMS.key, code: CODES.MISSING_PARAMS.code};
    const content = await db.query(
        `CALL GetContentByType(:type, :limit);`, 
        {type: type, limit: limit}
    );

    return {data: content, code: CODES.SUCCESS.code};
}


/**retuns rating of content for user*/
//Wenn 0 zurückgeben wird: gibt es noch keine Bewertung!
async function getRating(id){
    if(!helper.isDefined(id)) return {data: CODES.MISSING_PARAMS.key, code: CODES.MISSING_PARAMS.code};
    const rating = await db.query(
        `CALL CalculateContentRating(:id);`, 
        {id: id}

    );

    return {data: rating, code: CODES.SUCCESS.code};
}

async function addNewContent(title, description, type, duration, releaseDate, language) {
    try {
        const result = await db.query(
            `INSERT INTO content (title, description, type, duration, release_date, language)
             VALUES (?, ?, ?, ?, ?, ?)`,
            [title, description, type, duration, releaseDate, language]
        );

        return { data: result, code: CODES.SUCCESS.code };
    } catch (error) {
        return { data: error.message, code: CODES.ERROR.code };
    }
}

module.exports = {
    getTop, 
    getLatest,
    getRating,
    addNewContent
}