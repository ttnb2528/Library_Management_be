import connection from "../config/db.js"; // Kết nối đến MySQL
import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import Author from "../model/Author.model.js";

// 1. Thêm tác giả mới
export const addAuthor = async (req, res) => {
  const { TenTacGia, Website, Note } = req.body;

  try {
    // Kiểm tra nếu tác giả đã tồn tại
    // if (await Author.checkAuthorExists("name", name)) {
    //   return res.json(
    //     jsonGenerate(StatusCode.BAD_REQUEST, "Tác giả này đã tồn tại")
    //   );
    // }

    // Thêm tác giả mới
    Author.create(TenTacGia, Website, Note, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      const status = result[1][0].status;
      const message = result[1][0].message;

      if (status === 1) {
        return res.json(jsonGenerate(StatusCode.BAD_REQUEST, message));
      }

      return res.json(jsonGenerate(StatusCode.CREATED, message));
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 2. Lấy danh sách tác giả
export const getAuthors = async (req, res) => {
  try {
    Author.getAll((err, authors) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(StatusCode.OK, "Lấy danh sách tác giả thành công", authors)
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 3. Lấy thông tin tác giả theo id
export const getAuthorById = async (req, res) => {
  const { id } = req.params;

  try {
    Author.getById(id, (err, author) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!author || author.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy tác giả")
        );
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy thông tin tác giả thành công",
          author[0]
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 4. Cập nhật thông tin tác giả
export const updateAuthor = async (req, res) => {
  const { id } = req.params;
  const { TenTacGia, Website, Note } = req.body;

  try {
    // Kiểm tra nếu tác giả tồn tại
    if ((await Author.checkAuthorExists("name", TenTacGia))) {
      return res.json(
        jsonGenerate(StatusCode.BAD_REQUEST, "Tác giả đã tồn tại")
      );
    }

    // Cập nhật thông tin tác giả

    Author.update(id, TenTacGia, Website, Note, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(StatusCode.OK, "Cập nhật thông tin tác giả thành công")
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 5. Xóa tác giả
export const deleteAuthor = async (req, res) => {
  const { id } = req.params;

  try {
    // Kiểm tra nếu tác giả tồn tại
    if (!(await Author.checkAuthorExists("author_id", id))) {
      return res.json(
        jsonGenerate(StatusCode.BAD_REQUEST, "Tác giả không tồn tại")
      );
    }

    // Xóa tác giả

    Author.delete(id, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(jsonGenerate(StatusCode.OK, "Xóa tác giả thành công"));
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};
