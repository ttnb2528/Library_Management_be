import connection from "../config/db.js";

const Reader = {
  create: (name, address, callback) => {
    connection.query(
      "INSERT INTO Readers (name, address) VALUES (?, ?)",
      [name, address],
      callback
    );
  },

  //   vừa thêm độc giả mới vừa thêm thẻ thư viện
  createReaderWithCard: (name, address, start_date, end_date, callback) => {
    connection.query(
      "CALL create_reader_with_card(?, ?, ?, ?)",
      [name, address, start_date, end_date],
      callback
    );
  },

  //   gán thẻ thư viện cho độc giả đã tồn tại
  assignLibraryCard: (readerId, start_date, end_date, callback) => {
    connection.query(
      "CALL AssignLibraryCardToReader(?, ?, ?)",
      [readerId, start_date, end_date],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM Readers", callback);
  },

  getById: (reader_id, callback) => {
    connection.query(
      "SELECT * FROM Readers WHERE reader_id = ?",
      [reader_id],
      callback
    );
  },

  update: (reader_id, name, address, callback) => {
    connection.query(
      "UPDATE Readers SET name = ?, address = ? WHERE reader_id = ?",
      [name, address, reader_id],
      callback
    );
  },

  delete: (reader_id, callback) => {
    connection.query(
      "DELETE FROM Readers WHERE reader_id = ?",
      [reader_id],
      callback
    );
  },

  checkReaderExists: async (field, value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_reader_exists(?, ?) AS isExists", [field, value]);
    return rows[0].isExists;
  },
};

export default Reader;
