import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import LoanBookDetail from "../model/LoanBookDetail.model.js";

// 1. Lấy danh sách chi tiết phiếu mượn
export const getLoanBookDetails = async (req, res) => {
  try {
    LoanBookDetail.getAll((err, loanBookDetails) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy danh sách chi tiết phiếu mượn thành công",
          loanBookDetails
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 2. Lấy chi tiết phiếu mượn theo ID
export const getLoanBookDetailById = async (req, res) => {
  const { id } = req.params;

  try {
    LoanBookDetail.getById(id, (err, loanBookDetail) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!loanBookDetail || loanBookDetail.length === 0) {
        return res.json(
          jsonGenerate(
            StatusCode.NOTFOUND,
            "Không tìm thấy chi tiết phiếu mượn"
          )
        );
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy chi tiết phiếu mượn thành công",
          loanBookDetail
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 3. Cập nhật chi tiết phiếu mượn
export const updateLoanBookDetail = async (req, res) => {
  const { id, ISBN_OLD } = req.params;

  const { ISBN, NgayTra, DaTra, Note } = req.body;

  if (!NgayTra && DaTra === true) {
    NgayTra = new Date();
  }

  try {
    LoanBookDetail.getById(id, (err, loanBookDetail) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!loanBookDetail || loanBookDetail.length === 0) {
        return res.json(
          jsonGenerate(
            StatusCode.NOTFOUND,
            "Không tìm thấy chi tiết phiếu mượn"
          )
        );
      }

      LoanBookDetail.getBookExist(ISBN, id, (err, bookExist) => {
        if (err) {
          return res.json(
            jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
          );
        }

        if (bookExist.length > 0) {
          return res.json(
            jsonGenerate(
              StatusCode.BADREQUEST,
              "Sách đã tồn tại trong phiếu mượn"
            )
          );
        }

        LoanBookDetail.update(
          id,
          ISBN,
          NgayTra,
          DaTra,
          Note,
          ISBN_OLD,
          (err, result) => {
            if (err) {
              return res.json(
                jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
              );
            }

            return res.json(
              jsonGenerate(
                StatusCode.OK,
                "Cập nhật chi tiết phiếu mượn thành công"
              )
            );
          }
        );
      });
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};
