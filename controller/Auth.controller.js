// import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import connection from "../config/db.js"; // Kết nối đến MySQL
import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import Auth from "../model/Auth.model.js";

// Đăng ký người dùng mới
export const registerUser = async (req, res) => {
  const { username, email, password } = req.body;

  try {
    // Kiểm tra nếu email đã tồn tại qua model Auth
    if (await Auth.checkEmailExists(email)) {
      return res.json(
        jsonGenerate(StatusCode.BAD_REQUEST, "Email đã tồn tại!")
      );
    }

    // Kiểm tra nếu username đã tồn tại qua model Auth
    if (await Auth.checkUsernameExists(username)) {
      return res.json(
        jsonGenerate(StatusCode.BAD_REQUEST, "Tên đăng nhập đã tồn tại!")
      );
    }

    // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
    // const salt = await bcrypt.genSalt(Number(process.env.SALT));
    // const hashedPassword = await bcrypt.hash(password, salt);

    // Tạo user qua model Auth
    Auth.create(username, email, password, (err, result) => {
      if (err) {
        // console.error(err);
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
        // return res.send(err.sqlMessage);
      }

      return res.json(jsonGenerate(StatusCode.CREATED, "Đăng ký thành công!"));
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
      .query("SELECT * FROM Users WHERE email = ?", [email]);
    if (rows.length === 0) {
      return res.json(
        jsonGenerate(StatusCode.BAD_REQUEST, "Email không đúng!")
      );
    }

    const user = rows[0];

    // So sánh mật khẩu không mã hóa
    if (password !== user.password) {
      return res.json(
        jsonGenerate(StatusCode.BAD_REQUEST, "Mật khẩu không đúng!")
      );
    }

    // Tạo JWT token
    const token = jwt.sign(
      { userId: user.user_id },
      process.env.JWT_TOKEN_SECRET
    );
    delete user.password;
    return res.json(
      jsonGenerate(StatusCode.OK, "Đăng nhập thành công!", {
        user_id: user?.user_id,
        username: user?.username,
        email: user?.email,
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
