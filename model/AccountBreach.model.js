import connection from "../config/db.js";

const AccountBreach = {
  create: (NgayKhoa, NgayMoKhoa, LyDo, SoThe, callback) => {
    console.log(NgayKhoa);
    console.log(NgayMoKhoa);
    
    
    const query = `
        CALL create_vipham(?, ?, ?, ?, @status, @message);
        SELECT @status AS status, @message AS message;
    `;
    connection.query(query, [NgayKhoa, NgayMoKhoa, LyDo, SoThe], callback);
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM TaiKhoanViPham", callback);
  },

  getById: (id, callback) => {
    connection.query(
      "SELECT * FROM TaiKhoanViPham WHERE ID = ?",
      [id],
      callback
    );
  },

  update: (id, NgayKhoa, NgayMoKhoa, LyDo, callback) => {
    connection.query(
      "UPDATE TaiKhoanViPham SET NgayKhoa = ?, NgayMoKhoa = ?, LyDo = ? WHERE ID = ?",
      [NgayKhoa, NgayMoKhoa, LyDo, id],
      callback
    );
  },

  delete: (id, callback) => {
    connection.query("DELETE FROM TaiKhoanViPham WHERE ID = ?", [id], callback);
  },
};

export default AccountBreach;
