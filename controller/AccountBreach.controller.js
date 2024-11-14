import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import AccountBreach from "../model/AccountBreach.model.js";

// Tạo tài khoản vi phạm
export const createAccountBreach = async (req, res) => {
  let { NgayKhoa, NgayMoKhoa, LyDo, SoThe } = req.body;

  if (!NgayKhoa) {
    NgayKhoa = new Date();
  } else {
    NgayKhoa = new Date(NgayKhoa);
  }

  // Nếu NgayMoKhoa không có, mặc định là 1 năm sau ngày NgayKhoa
  if (!NgayMoKhoa) {
    NgayMoKhoa = new Date(NgayKhoa);
    NgayMoKhoa.setFullYear(NgayMoKhoa.getFullYear() + 1);
  } else {
    NgayMoKhoa = new Date(NgayMoKhoa);
  }

  // Kiểm tra nếu NgayMoKhoa phải lớn hơn NgayKhoa
  if (NgayMoKhoa <= NgayKhoa) {
    return res.json(
      jsonGenerate(
        StatusCode.BAD_REQUEST,
        "Ngày kết thúc phải lớn hơn ngày bắt đầu"
      )
    );
  }

  try {
    AccountBreach.create(NgayKhoa, NgayMoKhoa, LyDo, SoThe, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      //   console.log(result);

      const status = result[1][0].status;
      const message = result[1][0].message;

      if (status === 1) {
        return res.json(jsonGenerate(StatusCode.BAD_REQUEST, message));
      }

      return res.json(jsonGenerate(StatusCode.CREATED, message));
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống!"));
  }
};

// Lấy tất cả tài khoản vi phạm
export const getAllAccountBreach = async (req, res) => {
  try {
    AccountBreach.getAll((err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      return res.json(
        jsonGenerate(StatusCode.OK, "Lấy tài khoản vi phạm thành công", result)
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống!"));
  }
};

// Lấy thông tin tài khoản vi phạm theo id
export const getAccountBreachById = async (req, res) => {
  const { id } = req.params;

  try {
    AccountBreach.getById(id, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!result || result.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy tài khoản vi phạm")
        );
      }

      return res.json(jsonGenerate(StatusCode.OK, result));
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống!"));
  }
};

// Cập nhật thông tin tài khoản vi phạm
export const updateAccountBreach = async (req, res) => {
  const { id } = req.params;
  let { NgayKhoa, NgayMoKhoa, LyDo } = req.body;

  if (!NgayKhoa) {
    NgayKhoa = new Date();
  } else {
    NgayKhoa = new Date(NgayKhoa);
  }

  // Nếu NgayMoKhoa không có, mặc định là 1 năm sau ngày NgayKhoa
  if (!NgayMoKhoa) {
    NgayMoKhoa = new Date(NgayKhoa);
    NgayMoKhoa.setFullYear(NgayMoKhoa.getFullYear() + 1);
  } else {
    NgayMoKhoa = new Date(NgayMoKhoa);
  }

  // Kiểm tra nếu NgayMoKhoa phải lớn hơn NgayKhoa
  if (NgayMoKhoa <= NgayKhoa) {
    return res.json(
      jsonGenerate(
        StatusCode.BAD_REQUEST,
        "Ngày kết thúc phải lớn hơn ngày bắt đầu"
      )
    );
  }

  try {
    AccountBreach.getById(id, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!result || result.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy tài khoản vi phạm")
        );
      }

      AccountBreach.update(id, NgayKhoa, NgayMoKhoa, LyDo, (err, result) => {
        if (err) {
          return res.json(
            jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
          );
        }

        return res.json(
          jsonGenerate(
            StatusCode.OK,
            "Cập nhật thông tin tài khoản vi phạm thành công!"
          )
        );
      });
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống!"));
  }
};

// Xóa tài khoản vi phạm
export const deleteAccountBreach = async (req, res) => {
  const { id } = req.params;

  try {
    AccountBreach.delete(id, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      return res.json(
        jsonGenerate(StatusCode.OK, "Xóa tài khoản vi phạm thành công!")
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống!"));
  }
};
