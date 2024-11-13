import connection from "../config/db.js";

const Employee = {
  getAll: (callback) => {
    connection.query("SELECT * FROM NhanVien", callback);
  },

  getById: (NhanVienID, callback) => {
    connection.query(
      "SELECT * FROM NhanVien WHERE NhanVienID = ?",
      [NhanVienID],
      callback
    );
  },

  update: (NhanVienID, HoTen, NgaySinh, SDT, callback) => {
    connection.query(
      "UPDATE Employees SET HoTen = ?, NgaySinh = ?, SDT = ? WHERE NhanVienID = ?",
      [HoTen, NgaySinh, SDT, NhanVienID],
      callback
    );
  },

  checkEmployeeExists: async (value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_employee_exists(?) AS isExists", [value]);
    return rows[0].isExists;
  },
};

export default Employee;
