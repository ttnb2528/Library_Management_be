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
  createReaderWithCard: (
    TenDocGia,
    DiaChi,
    SDT,
    start_date,
    end_date,
    note,
    callback
  ) => {
    const query = `
        CALL create_reader_with_card(?, ?, ?, ?, ?, ?, @status, @message);
        SELECT @status AS status, @message AS message;
    `;
    connection.query(
      query,
      [TenDocGia, DiaChi, SDT, start_date, end_date, note],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM DocGia", callback);
  },

  getById: (DocGiaID, callback) => {
    connection.query(
      "SELECT * FROM DocGia WHERE DocGiaID = ?",
      [DocGiaID],
      callback
    );
  },

  update: (DocGiaID, TenDocGia, DiaChi, SDT, callback) => {
    connection.query(
      "UPDATE DocGia SET TenDocGia = ?, DiaChi = ?, SDT = ? WHERE DocGiaID = ?",
      [TenDocGia, DiaChi, SDT, DocGiaID],
      callback
    );
  },

  delete: (DocGiaID, callback) => {
    const query = `call delete_reader_with_card(?, @status, @message);
    SELECT @status AS status, @message AS message;`;
    connection.query(query, [DocGiaID], callback);
  },

  checkReaderExists: async (field, value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_reader_exists(?, ?) AS isExists", [field, value]);
    return rows[0].isExists;
  },
};

export default Reader;
