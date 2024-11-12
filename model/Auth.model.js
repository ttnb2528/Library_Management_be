import connection from "../config/db.js";

const Auth = {
  create: (User_Name, Pass_wd, Email, Role, callback) => {
    const query = `
        CALL create_account(?, ?, ?, ?, @status, @message);
        SELECT @status AS status, @message AS message;
    `;
    connection.query(query, [User_Name, Pass_wd, Email, Role], callback);
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
