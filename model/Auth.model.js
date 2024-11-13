import connection from "../config/db.js";

const Auth = {
  create: (User_Name, Pass_wd, Email, Role, HoTen, SDT, callback) => {
    const query = `
        CALL create_account(?, ?, ?, ?, ?, ?, @status, @message);
        SELECT @status AS status, @message AS message;
    `;
    connection.query(
      query,
      [User_Name, Pass_wd, Email, Role, HoTen, SDT],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM TaiKhoan WHERE Role= 'NhanVien'", callback);
  },

  getById: (ID_TaiKhoan, callback) => {
    connection.query(
      "SELECT * FROM TaiKhoan WHERE ID_TaiKhoan = ? AND Role= 'NhanVien'",
      [ID_TaiKhoan],
      callback
    );
  },

  update: (ID_TaiKhoan, User_Name, Pass_wd, Email, Role, callback) => {
    // connection.query(
    //   "UPDATE TaiKhoan SET User_Name = ?, Pass_wd = ?, Email = ?, Role = ? WHERE ID_TaiKhoan = ?",
    //   [User_Name, Pass_wd, Email, Role, ID_TaiKhoan],
    //   callback
    // );

    let query = "UPDATE TaiKhoan SET User_Name = ?, Email = ?, Role = ?";
    const values = [User_Name, Email, Role];

    if (Pass_wd) {
      // Nếu có mật khẩu, thêm vào câu lệnh SQL và mảng giá trị
      query += ", Pass_wd = ?";
      values.push(Pass_wd);
    }

    query += " WHERE ID_TaiKhoan = ?";
    values.push(ID_TaiKhoan);

    // Thực hiện câu truy vấn
    connection.query(query, values, callback);
  },

  delete: (ID_TaiKhoan, callback) => {
    const query = `call delete_employee_with_account(?, @status, @message);
    SELECT @status AS status, @message AS message;`;
    connection.query(query, [ID_TaiKhoan], callback);
  },

  // checkEmailExists: async (email) => {
  //   const [rows] = await connection
  //     .promise()
  //     .query("SELECT check_user_exists('email', ?) AS isExists", [email]);
  //   return rows[0].isExists;
  // },

  // checkUsernameExists: async (username) => {
  //   const [rows] = await connection
  //     .promise()
  //     .query("SELECT check_user_exists('username', ?) AS isExists", [username]);
  //   return rows[0].isExists;
  // },
};

export default Auth;
