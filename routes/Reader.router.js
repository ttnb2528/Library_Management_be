import express from "express";
import {
  addReaderWithLibraryCard,
  deleteReader,
  getReaderById,
  getReaders,
  updateReader,
} from "../controller/Reader.controller.js";

const router = express.Router();

// 1. Thêm độc giả mới và thêm thẻ thư viện
router.post("/addReaderWithCard", addReaderWithLibraryCard);

router.get("/get", getReaders);
router.get("/get/:id", getReaderById);
router.put("/update/:id", updateReader);
router.delete("/delete/:id", deleteReader);

export default router;
