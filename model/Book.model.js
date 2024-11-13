import connection from "../config/db.js";

const Book = {
  create: (
    TenSach,
    SoTrang,
    Soluong,
    MoTa,
    ChuDeID,
    NXB_ID,
    TacGiaID,
    NamXB,
    callback
  ) => {
    const query = `
            CALL create_sach(?, ?, ?, ?, ?, ?, ?, ?, @status, @message);
            SELECT @status AS status, @message AS message;
        `;
    connection.query(
      query,
      [TenSach, SoTrang, Soluong, MoTa, ChuDeID, NXB_ID, TacGiaID, NamXB],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM SACH", callback);
  },

  getById: (ISBN, callback) => {
    connection.query("SELECT * FROM SACH WHERE ISBN = ?", [ISBN], callback);
  },

  update: (
    ISBN,
    TenSach,
    SoTrang,
    Soluong,
    MoTa,
    ChuDeID,
    NXB_ID,
    TacGiaID,
    NamXB,
    callback
  ) => {
    connection.query(
      "UPDATE SACH SET TenSach = ?, SoTrang = ?, Soluong = ?, MoTa = ?, ChuDeID = ?, NXB_ID = ?, TacGiaID = ?, NamXB = ? WHERE ISBN = ?",
      [TenSach, SoTrang, Soluong, MoTa, ChuDeID, NXB_ID, TacGiaID, NamXB, ISBN],
      callback
    );
  },

  delete: (ISBN, callback) => {
    connection.query("DELETE FROM SACH WHERE ISBN = ?", [ISBN], callback);
  },

  checkBookExists: async (value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_book_exists(?) AS isExists", [value]);
    return rows[0].isExists;
  },
};

export default Book;
