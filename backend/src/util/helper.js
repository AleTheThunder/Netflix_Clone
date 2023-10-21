const isDefined = (val) => {
    if(val == undefined || val == "undefined" || val == null || val == "null") return false;
    else return true;
};

module.exports = {
    isDefined
};