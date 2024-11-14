import connection from "../config/db.js";

const LoanBookDetail = {
  getAll: (callback) => {
    connection.query("SELECT * FROM PhieuMuonChiTiet", callback);
  },

  getById: (PhieuMuonID, callback) => {
    connection.query(
      "SELECT * FROM PhieuMuonChiTiet WHERE PhieuMuonID = ?",
      [PhieuMuonID],
      callback
    );
  },

  getBookExist: (ISBN, id, callback) => {
    connection.query(
      "SELECT * FROM PhieuMuonChiTiet WHERE ISBN = ? AND PhieuMuonID = ?",
      [ISBN, id],
      callback
    );
  },

  update: (PhieuMuonID, ISBN, NgayTra, DaTra, Note, ODL_ISBN, callback) => {
    connection.query(
      "UPDATE PhieuMuonChiTiet SET ISBN = ?, NgayTra = ?, DaTra = ?, Note = ? WHERE PhieuMuonID = ? AND ISBN = ?",
      [ISBN, NgayTra, DaTra, Note, PhieuMuonID, ODL_ISBN],
      callback
    );
  },
};

export default LoanBookDetail;
