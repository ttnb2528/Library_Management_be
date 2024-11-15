// import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import connection from "../config/db.js"; // Kết nối đến MySQL
import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import Auth from "../model/Auth.model.js";

// Đăng ký người dùng mới
export const registerUser = async (req, res) => {
  const { User_Name, Email, Pass_wd, Role, SDT } = req.body;

  const HoTen = User_Name;
  try {
    // Kiểm tra nếu email đã tồn tại qua model Auth
    // if (await Auth.checkEmailExists(email)) {
    //   return res.json(
    //     jsonGenerate(StatusCode.BAD_REQUEST, "Email đã tồn tại!")
    //   );
    // }

    // Kiểm tra nếu username đã tồn tại qua model Auth
    // if (await Auth.checkUsernameExists(username)) {
    //   return res.json(
    //     jsonGenerate(StatusCode.BAD_REQUEST, "Tên đăng nhập đã tồn tại!")
    //   );
    // }

    // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
    // const salt = await bcrypt.genSalt(Number(process.env.SALT));
    // const hashedPassword = await bcrypt.hash(password, salt);

    // Tạo user qua model Auth
    Auth.create(User_Name, Email, Pass_wd, Role, HoTen, SDT, (err, result) => {
      if (err) {
        // console.error(err);
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
        // return res.send(err.sqlMessage);
      }

      const status = result[1][0].status;
      const message = result[1][0].message;

      if (status === 1) {
        return res.json(jsonGenerate(StatusCode.BAD_REQUEST, message));
      }

      // return res.json(jsonGenerate(StatusCode.CREATED, "Đăng ký thành công!"));
      return res.json(jsonGenerate(StatusCode.OK, message));
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống!"));
  }
};

// Đăng nhập người dùng
export const loginUser = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.json(
      jsonGenerate(StatusCode.SERVER_ERROR, "Thiếu thông tin đăng nhập!")
    );
  }

  try {
    // Kiểm tra nếu email tồn tại trong cơ sở dữ liệu
    const [rows] = await connection
      .promise()
      .query("SELECT * FROM TaiKhoan WHERE Email = ?", [email]);
    if (rows.length === 0) {
      return res.json(
        jsonGenerate(StatusCode.BAD_REQUEST, "Email không đúng!")
      );
    }

    const user = rows[0];

    // So sánh mật khẩu không mã hóa
    if (password !== user.Pass_wd) {
      return res.json(
        jsonGenerate(StatusCode.BAD_REQUEST, "Mật khẩu không đúng!")
      );
    }

    // Tạo JWT token
    const token = jwt.sign(
      { userId: user.user_id },
      process.env.JWT_TOKEN_SECRET
    );
    delete user.Pass_wd;
    return res.json(
      jsonGenerate(StatusCode.OK, "Đăng nhập thành công!", {
        user_id: user?.user_id,
        username: user?.User_Name,
        email: user?.Email,
        role: user?.Role,
        token: token,
      })
    );
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống!"));
  }
};

// Đăng xuất người dùng
export const logoutUser = async (req, res) => {
  return res.json(jsonGenerate(StatusCode.OK, "Đăng xuất thành công!"));
};

// Lấy danh sách người dùng
export const getAllUser = async (req, res) => {
  try {
    Auth.getAll((err, users) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy danh sách người dùng thành công",
          users
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// Lấy thông tin người dùng theo id
export const getUserById = async (req, res) => {
  const { id } = req.params;

  try {
    Auth.getById(id, (err, user) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!user || user.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy người dùng")
        );
      }

      return res.json(
        jsonGenerate(StatusCode.OK, "Lấy thông tin người dùng thành công", user)
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// Cập nhật thông tin người dùng
export const updateUser = async (req, res) => {
  const { id } = req.params;
  const { User_Name, Pass_wd, Email, Role } = req.body;

  try {
    // Kiểm tra nếu người dùng có tồn tại không
    Auth.getById(id, (err, user) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!user || user.length === 0) {
        // Nếu người dùng không tồn tại, trả về phản hồi và thoát
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy người dùng")
        );
      }

      // Nếu người dùng tồn tại, tiến hành cập nhật thông tin
      Auth.update(id, User_Name, Pass_wd, Email, Role, (err, result) => {
        if (err) {
          return res.json(
            jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
          );
        }

        // Phản hồi khi cập nhật thành công
        return res.json(jsonGenerate(StatusCode.OK, "Cập nhật thành công!"));
      });
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// Xóa người dùng
export const deleteUser = async (req, res) => {
  const { id } = req.params;

  try {
    Auth.getById(id, (err, user) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!user || user.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy người dùng")
        );
      }

      Auth.delete(id, (err, result) => {
        if (err) {
          return res.json(
            jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
          );
        }

        const status = result[1][0].status;
        const message = result[1][0].message;

        if (status === 1) {
          return res.json(jsonGenerate(StatusCode.BAD_REQUEST, message));
        }

        return res.json(jsonGenerate(StatusCode.OK, message));
      });
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};
