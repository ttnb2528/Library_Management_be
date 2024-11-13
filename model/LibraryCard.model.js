import connection from "../config/db.js";

const LibraryCard = {
  create: (start_date, end_date, callback) => {
    connection.query(
      "INSERT INTO TheThuVien ( start_date, end_date) VALUES (?, ?)",
      [start_date, end_date],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM TheThuVien", callback);
  },

  getById: (SoThe, callback) => {
    console.log(SoThe);
    
    connection.query(
      "SELECT * FROM TheThuVien WHERE SoThe = ?",
      [SoThe],
      callback
    );
  },

  update: (SoThe, start_date, end_date, callback) => {
    connection.query(
      "UPDATE TheThuVien SET start_date = ?, end_date = ? WHERE SoThe = ?",
      [start_date, end_date, SoThe],
      callback
    );
  },

  delete: (SoThe, callback) => {
    connection.query(
      "DELETE FROM TheThuVien WHERE SoThe = ?",
      [SoThe],
      callback
    );
  },

  checkCardExists: async (value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_card_exists(?) AS isExists", [value]);
    return rows[0].isExists;
  },
};

export default LibraryCard;
