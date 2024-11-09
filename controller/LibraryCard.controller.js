import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import LibraryCard from "../model/LibraryCard.model.js";

// 1. Thêm thẻ thư viện mới
export const addLibraryCard = async (req, res) => {
  let { start_date, end_date } = req.body;

  // Nếu start_date không có thì mặc định lấy ngày hiện tại
  if (!start_date) {
    start_date = new Date();
  } else {
    start_date = new Date(start_date);
  }

  // Nếu end_date không có, mặc định là 1 năm sau ngày start_date
  if (!end_date) {
    end_date = new Date(start_date);
    end_date.setFullYear(end_date.getFullYear() + 1);
  } else {
    end_date = new Date(end_date);
  }

  // Kiểm tra nếu end_date phải lớn hơn start_date
  if (end_date <= start_date) {
    return res.json(
      jsonGenerate(
        StatusCode.BAD_REQUEST,
        "Ngày kết thúc phải lớn hơn ngày bắt đầu"
      )
    );
  }

  try {
    LibraryCard.create(start_date, end_date, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(StatusCode.CREATED, "Thẻ thư viện đã được thêm thành công")
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 2. Lấy danh sách thẻ thư viện
export const getLibraryCards = async (req, res) => {
  try {
    LibraryCard.getAll((err, libraryCards) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy danh sách thẻ thư viện thành công",
          libraryCards
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 3. Lấy thông tin thẻ thư viện theo mã thẻ
export const getLibraryCardById = async (req, res) => {
  const { card_number } = req.params;

  try {
    LibraryCard.getById(card_number, (err, libraryCard) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!libraryCard || libraryCard.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy thẻ thư viện")
        );
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy thông tin thẻ thư viện thành công",
          libraryCard[0]
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 4. Cập nhật thông tin thẻ thư viện
export const updateLibraryCard = async (req, res) => {
  const { card_number } = req.params;
  let { start_date, end_date } = req.body;

  // Nếu start_date không có thì mặc định lấy ngày hiện tại
  if (!start_date) {
    start_date = new Date();
  } else {
    start_date = new Date(start_date);
  }

  // Nếu end_date không có, mặc định là 1 năm sau ngày start_date
  if (!end_date) {
    end_date = new Date(start_date);
    end_date.setFullYear(end_date.getFullYear() + 1);
  } else {
    end_date = new Date(end_date);
  }

  // Kiểm tra nếu end_date phải lớn hơn start_date
  if (end_date <= start_date) {
    return res.json(
      jsonGenerate(
        StatusCode.BAD_REQUEST,
        "Ngày kết thúc phải lớn hơn ngày bắt đầu"
      )
    );
  }

  try {
    if (!(await LibraryCard.checkCardExists(card_number))) {
      return res.json(
        jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy thẻ thư viện")
      );
    }

    LibraryCard.update(card_number, start_date, end_date, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Cập nhật thông tin thẻ thư viện thành công"
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 5. Xóa thẻ thư viện
export const deleteLibraryCard = async (req, res) => {
  const { card_number } = req.params;

  try {
    if (!(await LibraryCard.checkCardExists(card_number))) {
      return res.json(
        jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy thẻ thư viện")
      );
    }

    LibraryCard.delete(card_number, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(StatusCode.OK, "Xóa thẻ thư viện thành công")
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};
