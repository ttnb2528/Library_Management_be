import connection from "../config/db.js";

const Publisher = {
  create: (TenNXB, DiaChi, Email, Info_ngDaiDien, callback) => {
    const query = `
        CALL create_nxb(?, ?, ?, ?, @status, @message);
        SELECT @status AS status, @message AS message;
    `;
    connection.query(query, [TenNXB, DiaChi, Email, Info_ngDaiDien], callback);
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM NXB", callback);
  },

  getById: (publisher_id, callback) => {
    connection.query(
      "SELECT * FROM NXB WHERE NXB_ID = ?",
      [publisher_id],
      callback
    );
  },

  update: (NXB_ID, TenNXB, DiaChi, Email, Info_ngDaiDien, callback) => {
    connection.query(
      "UPDATE NXB SET TenNXB = ?, DiaChi = ?, Email = ?, Info_ngDaiDien = ? WHERE NXB_ID = ?",
      [TenNXB, DiaChi, Email, Info_ngDaiDien, NXB_ID],
      callback
    );
  },

  delete: (NXB_ID, callback) => {
    connection.query(
      "DELETE FROM NXB WHERE NXB_ID = ?",
      [NXB_ID],
      callback
    );
  },

  checkPublisherExists: async (value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_publisher_exists(?) AS isExists", [value]);
    return rows[0].isExists;
  },
};

export default Publisher;
