import connection from "../config/db.js";

const Author = {
  create: (name, website, notes, callback) => {
    connection.query(
      "INSERT INTO Authors (name, website, notes) VALUES (?, ?, ?)",
      [name, website, notes],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM Authors", callback);
  },

  getById: (author_id, callback) => {
    connection.query(
      "SELECT * FROM Authors WHERE author_id = ?",
      [author_id],
      callback
    );
  },

  update: (author_id, name, website, notes, callback) => {
    connection.query(
      "UPDATE Authors SET name = ?, website = ?, notes = ? WHERE author_id = ?",
      [name, website, notes, author_id],
      callback
    );
  },

  delete: (author_id, callback) => {
    connection.query(
      "DELETE FROM Authors WHERE author_id = ?",
      [author_id],
      callback
    );
  },

  checkAuthorExists: async (field, value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_author_exists(?, ?) AS isExists", [
        field,
        value,
      ]);
    return rows[0].isExists;
  },
};

export default Author;
