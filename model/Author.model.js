import connection from "../config/db.js";

const Author = {
  create: (TenTacGia, Website, Note, callback) => {
    const query = `
        CALL create_tacgia(?, ?, ?,  @status, @message);
        SELECT @status AS status, @message AS message;
    `;
    connection.query(query, [TenTacGia, Website, Note], callback);
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM TacGia", callback);
  },

  getById: (TacGiaID, callback) => {
    connection.query(
      "SELECT * FROM TacGia WHERE TacGiaID = ?",
      [TacGiaID],
      callback
    );
  },

  update: (TacGiaID, TenTacGia, Website, Note, callback) => {
    connection.query(
      "UPDATE TacGia SET TenTacGia = ?, Website = ?, Note = ? WHERE TacGiaID = ?",
      [TenTacGia, Website, Note, TacGiaID],
      callback
    );
  },

  delete: (TacGiaID, callback) => {
    connection.query(
      "DELETE FROM TacGia WHERE TacGiaID = ?",
      [TacGiaID],
      callback
    );
  },

  checkAuthorExists: async (field, value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_author_exists(?, ?) AS isExists", [field, value]);
    return rows[0].isExists;
  },
};

export default Author;
