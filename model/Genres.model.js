import connection from "../config/db.js";

const Genres = {
  create: (genre_name, callback) => {
    connection.query(
      "INSERT INTO Genres (genre_name) VALUES (?)",
      [genre_name],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM Genres", callback);
  },

  getById: (genre_id, callback) => {
    connection.query(
      "SELECT * FROM Genres WHERE genre_id = ?",
      [genre_id],
      callback
    );
  },

  update: (genre_id, genre_name, callback) => {
    connection.query(
      "UPDATE Genres SET genre_name = ? WHERE genre_id = ?",
      [genre_name, genre_id],
      callback
    );
  },

  delete: (genre_id, callback) => {
    connection.query(
      "DELETE FROM Genres WHERE genre_id = ?",
      [genre_id],
      callback
    );
  },

  checkGenreExists: async (value) => {
    const [rows] = await connection
      .promise()
      .query("SELECT check_genres_exists(?) AS isExists", [value]);
    return rows[0].isExists;
  },
};

export default Genres;
