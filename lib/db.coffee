server = process.env.DBSERVER || "localhost"
module.exports = "http://#{server}:5984/default/_design/applications/_view"
