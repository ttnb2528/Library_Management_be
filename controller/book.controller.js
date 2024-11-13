import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import Book from "../model/Book.model.js";

// 1. Thêm sách mới
export const addBook = async (req, res) => {
  const { TenSach, SoTrang, Soluong, MoTa, ChuDeID, NXB_ID, TacGiaID, NamXB } =
    req.body;

  console.log(NamXB);

  try {
    // Thêm sách mới
    Book.create(
      TenSach,
      SoTrang,
      Soluong,
      MoTa,
      ChuDeID,
      NXB_ID,
      TacGiaID,
      NamXB,
      (err, result) => {
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

        return res.json(jsonGenerate(StatusCode.CREATED, message));
      }
    );
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 2. Lấy danh sách sách
export const getBooks = async (req, res) => {
  try {
    Book.getAll((err, books) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(StatusCode.OK, "Lấy danh sách sách thành công", books)
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 3. Lấy thông tin sách theo id
export const getBookById = async (req, res) => {
  const { id } = req.params;

  try {
    Book.getById(id, (err, book) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!book || book.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy sách")
        );
      }
      return res.json(
        jsonGenerate(StatusCode.OK, "Lấy thông tin sách thành công", book)
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 4. Cập nhật thông tin sách
export const updateBook = async (req, res) => {
  const { id } = req.params;
  const { TenSach, SoTrang, Soluong, MoTa, ChuDeID, NXB_ID, TacGiaID, NamXB } =
    req.body;

  try {
    Book.getById(id, async (err, book) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!book || book.length == 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy sách")
        );
      }

      // Cập nhật thông tin sách
      Book.update(
        id,
        TenSach,
        SoTrang,
        Soluong,
        MoTa,
        ChuDeID,
        NXB_ID,
        TacGiaID,
        NamXB,
        (err, result) => {
          if (err) {
            return res.json(
              jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
            );
          }

          if (result.affectedRows === 0) {
            return res.json(
              jsonGenerate(
                StatusCode.BAD_REQUEST,
                "Cập nhật sách không thành công"
              )
            );
          }

          return res.json(
            jsonGenerate(StatusCode.OK, "Cập nhật sách thành công")
          );
        }
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 5. Xóa sách
export const deleteBook = async (req, res) => {
  const { id } = req.params;

  try {
    Book.getById(id, (err, book) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!book || book.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy sách")
        );
      }

      Book.delete(id, (err, result) => {
        if (err) {
          return res.json(
            jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
          );
        }

        if (result.affectedRows === 0) {
          return res.json(
            jsonGenerate(StatusCode.BAD_REQUEST, "Xóa sách không thành công")
          );
        }

        return res.json(jsonGenerate(StatusCode.OK, "Xóa sách thành công"));
      });
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};
