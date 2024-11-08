import connection from "../config/db.js";

const Publisher = {
  create: (publisher_name, address, email, representative_info, callback) => {
    connection.query(
      "INSERT INTO Publishers (publisher_name, address, email, representative_info) VALUES (?, ?, ?, ?)",
      [publisher_name, address, email, representative_info],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM Publishers", callback);
  },

  getById: (publisher_id, callback) => {
    connection.query(
      "SELECT * FROM Publishers WHERE publisher_id = ?",
      [publisher_id],
      callback
    );
  },

  update: (
    publisher_id,
    publisher_name,
    address,
    email,
    representative_info,
    callback
  ) => {
    connection.query(
      "UPDATE Publishers SET publisher_name = ?, address = ?, email = ?, representative_info = ? WHERE publisher_id = ?",
      [publisher_name, address, email, representative_info, publisher_id],
      callback
    );
  },

  delete: (publisher_id, callback) => {
    connection.query(
      "DELETE FROM Publishers WHERE publisher_id = ?",
      [publisher_id],
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
