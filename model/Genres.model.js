import connection from "../config/db.js";

const Genres = {
  create: (TenChuDe, callback) => {
    const query = `
        CALL create_chude(?, @status, @message);
        SELECT @status AS status, @message AS message;
    `;
    connection.query(query, [TenChuDe], callback);
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM chude", callback);
  },

  getById: (ChuDeID, callback) => {
    connection.query(
      "SELECT * FROM chude WHERE ChuDeID = ?",
      [ChuDeID],
      callback
    );
  },

  update: (ChuDeID, TenChuDe, callback) => {
    connection.query(
      "UPDATE chude SET TenChuDe = ? WHERE ChuDeID = ?",
      [TenChuDe, ChuDeID],
      callback
    );
  },

  delete: (ChuDeID, callback) => {
    connection.query(
      "DELETE FROM chude WHERE ChuDeID = ?",
      [ChuDeID],
      callback
    );
  },

  checkGenreExists: async (value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_genres_exists(?) AS isExists", [value]);
    return rows[0].isExists;
  },
};

export default Genres;
