import express from "express";
import {
  addReader,
  addReaderWithLibraryCard,
  assignLibraryCard,
  deleteReader,
  getReaderById,
  getReaders,
  updateReader,
} from "../controller/Reader.controller.js";

const router = express.Router();

// 1. Thêm độc giả mới và thêm thẻ thư viện
router.post("/addReaderWithCard", addReaderWithLibraryCard);

// 2. Thêm độc giả rồi thêm thẻ thư viện
router.post("/add", addReader);
router.post("/assignLibraryCard/:readerId", assignLibraryCard);

router.get("/get", getReaders);
router.get("/get/:id", getReaderById);
router.put("/update/:id", updateReader);
router.delete("/delete/:id", deleteReader);

export default router;
