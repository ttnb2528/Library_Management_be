import connection from "../config/db.js";

const LoanBook = {
  create: (NhanVienID, SoThe, NgayMuon, ISBN, callback) => {
    const query = `
            CALL create_loan_with_details(?, ?, ?, ?, @status, @message);
            SELECT @status AS status, @message AS message;
        `;
    connection.query(query, [NhanVienID, SoThe, NgayMuon, ISBN], callback);
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM PhieuMuon", callback);
  },

  getById: (PhieuMuonID, callback) => {
    connection.query(
      "SELECT * FROM PhieuMuon WHERE PhieuMuonID = ?",
      [PhieuMuonID],
      callback
    );
  },

  update: (PhieuMuonID, NhanVienID, SoThe, NgayMuon, callback) => {
    connection.query(
      "UPDATE PhieuMuon SET NhanVienID = ?, SoThe = ?, NgayMuon = ? WHERE PhieuMuonID = ?",
      [NhanVienID, SoThe, NgayMuon, PhieuMuonID],
      callback
    );
  },

  delete: (PhieuMuonID, callback) => {
    const query = `call delete_loan_and_detail(?, @status, @message);
        SELECT @status AS status, @message AS message;`;
    connection.query(query, [PhieuMuonID], callback);
  },
};

export default LoanBook;
