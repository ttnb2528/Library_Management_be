import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import Employee from "../model/Employee.model.js";

// 1. Thêm nhân viên mới


// 2. Lấy danh sách nhân viên
export const getEmployees = async (req, res) => {
  try {
    Employee.getAll((err, employees) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy danh sách nhân viên thành công",
          employees
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 3. Lấy thông tin nhân viên theo id
export const getEmployeeById = async (req, res) => {
  const { id } = req.params;

  try {
    Employee.getById(id, (err, employee) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!employee || employee.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy nhân viên")
        );
      }

      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy thông tin nhân viên thành công",
          employee
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 4. Cập nhật thông tin nhân viên
export const updateEmployee = async (req, res) => {
  const { id } = req.params;
  const { full_name, birth_date, phone_number } = req.body;

  try {
    Employee.update(id, full_name, birth_date, phone_number, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      return res.json(
        jsonGenerate(StatusCode.OK, "Cập nhật thông tin nhân viên thành công")
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

