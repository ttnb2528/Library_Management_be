import connection from "../config/db.js";

const Employee = {
  create: (full_name, birth_date, phone_number, callback) => {
    connection.query(
      "INSERT INTO Employees (full_name, birth_date, phone_number) VALUES (?, ?, ?)",
      [full_name, birth_date, phone_number],
      callback
    );
  },

  getAll: (callback) => {
    connection.query("SELECT * FROM Employees", callback);
  },

  getById: (employee_id, callback) => {
    connection.query(
      "SELECT * FROM Employees WHERE employee_id = ?",
      [employee_id],
      callback
    );
  },

  update: (employee_id, full_name, birth_date, phone_number, callback) => {
    connection.query(
      "UPDATE Employees SET full_name = ?, birth_date = ?, phone_number = ? WHERE employee_id = ?",
      [full_name, birth_date, phone_number, employee_id],
      callback
    );
  },

  delete: (employee_id, callback) => {
    connection.query(
      "DELETE FROM Employees WHERE employee_id = ?",
      [employee_id],
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