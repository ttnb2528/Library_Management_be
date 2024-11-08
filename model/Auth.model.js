import connection from "../config/db.js";

const Auth = {
  create: (username, email, password, callback) => {
    connection.query(
      "INSERT INTO Users (username, email, password) VALUES (?, ?, ?)",
      [username, email, password],
      callback
    );
  },

  checkEmailExists: async (email) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_user_exists('email', ?) AS isExists", [email]);
    return rows[0].isExists;
  },

  checkUsernameExists: async (username) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_user_exists('username', ?) AS isExists", [username]);
    return rows[0].isExists;
  },
};

export default Auth;
