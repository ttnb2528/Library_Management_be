import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import Publisher from "../model/Publisher.model.js";

// 1. Thêm nhà xuất bản mới
export const addPublisher = async (req, res) => {
  const { TenNXB, DiaChi, Email, Info_ngDaiDien } = req.body;

  try {
    // Kiểm tra nếu nhà xuất bản đã tồn tại
    // if (
    //   await Publisher.checkPublisherExists(publisher_name)
    // ) {
    //   return res.json(
    //     jsonGenerate(StatusCode.BAD_REQUEST, "Nhà xuất bản này đã tồn tại")
    //   );
    // }

    // Thêm nhà xuất bản mới
    Publisher.create(TenNXB, DiaChi, Email, Info_ngDaiDien, (err, result) => {
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

// 2. Lấy danh sách nhà xuất bản
export const getPublishers = async (req, res) => {
  try {
    Publisher.getAll((err, publishers) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy danh sách nhà xuất bản thành công",
          publishers
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 3. Lấy thông tin nhà xuất bản theo id
export const getPublisherById = async (req, res) => {
  const { id } = req.params;

  try {
    Publisher.getById(id, (err, publisher) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!publisher || publisher.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy nhà xuất bản")
        );
      }
      return res.json(
        jsonGenerate(
          StatusCode.OK,
          "Lấy thông tin nhà xuất bản thành công",
          publisher
        )
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 4. Cập nhật thông tin nhà xuất bản
export const updatePublisher = async (req, res) => {
  const { id } = req.params;
  const { TenNXB, DiaChi, Email, Info_ngDaiDien } = req.body;

  try {
    // Kiểm tra nhà xuất bản có tồn tại không
    Publisher.getById(id, async (err, publisher) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!publisher || publisher.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy nhà xuất bản")
        );
      }

      // Cập nhật thông tin nhà xuất bản
      Publisher.update(
        id,
        TenNXB,
        DiaChi,
        Email,
        Info_ngDaiDien,
        (err, result) => {
          if (err) {
            return res.json(
              jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
            );
          }
          return res.json(
            jsonGenerate(
              StatusCode.OK,
              "Cập nhật thông tin nhà xuất bản thành công"
            )
          );
        }
      );
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};

// 5. Xóa nhà xuất bản
export const deletePublisher = async (req, res) => {
  const { id } = req.params;

  try {
    // Kiểm tra nhà xuất bản có tồn tại không
    Publisher.getById(id, async (err, publisher) => {
      if (err) {
        return res.json(jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage));
      }

      if (!publisher || publisher.length === 0) {
        return res.json(
          jsonGenerate(StatusCode.NOTFOUND, "Không tìm thấy nhà xuất bản")
        );
      }

      // Xóa nhà xuất bản
      Publisher.delete(id, (err, result) => {
        if (err) {
          return res.json(
            jsonGenerate(StatusCode.SERVER_ERROR, err.sqlMessage)
          );
        }
        return res.json(
          jsonGenerate(StatusCode.OK, "Xóa nhà xuất bản thành công")
        );
      });
    });
  } catch (error) {
    console.error(error);
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Lỗi hệ thống"));
  }
};
