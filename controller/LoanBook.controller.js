import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import LoanBook from "../model/LoanBook.model.js";

// 1. Thêm phiếu mượn mới
export const addLoanBook = async (req, res) => {
  const { NhanVienID, SoThe, NgayMuon, ISBN } = req.body;

  try {
    // Thêm phiếu mượn mới
    LoanBook.create(NhanVienID, SoThe, NgayMuon, ISBN, (err, result) => {
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

// 2. Lấy danh sách phiếu mượn
export const getLoanBooks = async (req, res) => {
  try {
    LoanBook.getAll((err, loanBooks) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy danh sách phiếu mượn thành công",
          loanBooks
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 3. Lấy thông tin phiếu mượn theo ID
export const getLoanBookById = async (req, res) => {
  const { id } = req.params;

  try {
    LoanBook.getById(id, (err, loanBook) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (loanBook.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy phiếu mượn")
        );
      }

      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy thông tin phiếu mượn thành công",
          loanBook[0]
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 4. Cập nhật thông tin phiếu mượn
export const updateLoanBook = async (req, res) => {
  const { id } = req.params;
  const { NhanVienID, SoThe, NgayMuon } = req.body;

  try {
    LoanBook.update(id, NhanVienID, SoThe, NgayMuon, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (result.affectedRows === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy phiếu mượn")
        );
      }

      return res.json(
        jsonGenerate(StatusCode.OK, "Cập nhật thông tin phiếu mượn thành công")
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 5. Xóa phiếu mượn
export const deleteLoanBook = async (req, res) => {
  const { id } = req.params;

  try {
    LoanBook.delete(id, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (result.affectedRows === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy phiếu mượn")
        );
      }

      return res.json(jsonGenerate(StatusCode.OK, "Xóa phiếu mượn thành công"));
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};
