import express from "express";
import {
  addBook,
  getBooks,
  getBookById,
  updateBook,
  deleteBook,
} from "../controller/book.controller.js";

const router = express.Router();

router.post("/add", addBook);
router.get("/get", getBooks);
router.get("/get/:id", getBookById);
router.put("/update/:id", updateBook);
router.delete("/delete/:id", deleteBook);

export default router;
