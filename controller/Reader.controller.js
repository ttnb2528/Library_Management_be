import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import Reader from "../model/Reader.model.js";

// 1. Thêm độc giả mới và thêm thẻ thư viện
export const addReaderWithLibraryCard = async (req, res) => {
  let { name, address, phone, start_date, end_date, note } = req.body;

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
    // Kiểm tra nếu độc giả đã tồn tại
    // if (await Reader.checkReaderExists("name", name)) {
    //   return res.json(
    //     jsonGenerate(StatusCode.BAD_REQUEST, "Độc giả này đã tồn tại")
    //   );
    // }

    // Thêm độc giả mới
    Reader.createReaderWithCard(
      name,
      address,
      phone,
      start_date,
      end_date,
      note,
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
        // console.log(result);
      }
    );
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 2. Lấy danh sách độc giả
export const getReaders = async (req, res) => {
  try {
    Reader.getAll((err, readers) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(StatusCode.OK, "Lấy danh sách độc giả thành công", readers)
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 3. Lấy thông tin độc giả theo id
export const getReaderById = async (req, res) => {
  const { id } = req.params;

  try {
    Reader.getById(id, (err, reader) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!reader || reader.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy độc giả")
        );
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy thông tin độc giả thành công",
          reader[0]
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 4. Cập nhật thông tin độc giả
export const updateReader = async (req, res) => {
  const { id } = req.params;
  const { name, address, phone } = req.body;

  try {
    // Kiểm tra nếu độc giả tồn tại
    if (!(await Reader.checkReaderExists("reader_id", id))) {
      return res.json(
        jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy độc giả")
      );
    }
    Reader.update(id, name, address, phone, (err, result) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(
          StatusCode.CREATED,
          "Cập nhật thông tin độc giả thành công"
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 5. Xóa độc giả
export const deleteReader = async (req, res) => {
  const { id } = req.params;

  try {
    Reader.getById(id, async (err, reader) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!reader || reader.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy độc giả")
        );
      }

      Reader.delete(id, (err, result) => {
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
