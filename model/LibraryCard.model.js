import connection from "../config/db.js";

const LibraryCard = {
  create: (start_date, end_date, callback) => {
    connection.query(
      "INSERT INTO LibraryCards ( start_date, end_date) VALUES (?, ?)",
      [start_date, end_date],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM LibraryCards", callback);
  },

  getById: (card_number, callback) => {
    connection.query(
      "SELECT * FROM LibraryCards WHERE card_number = ?",
      [card_number],
      callback
    );
  },

  update: (card_number, start_date, end_date, callback) => {
    connection.query(
      "UPDATE LibraryCards SET start_date = ?, end_date = ? WHERE card_number = ?",
      [start_date, end_date, card_number],
      callback
    );
  },

  delete: (card_number, callback) => {
    connection.query(
      "DELETE FROM LibraryCards WHERE card_number = ?",
      [card_number],
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
