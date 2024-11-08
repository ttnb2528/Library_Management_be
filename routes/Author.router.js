import express from "express";
import {
  addAuthor,
  getAuthors,
  getAuthorById,
  updateAuthor,
  deleteAuthor,
} from "../controller/Author.controller.js";

const router = express.Router();

router.post("/add", addAuthor);
router.get("/get", getAuthors);
router.get("/get/:id", getAuthorById);
router.put("/update/:id", updateAuthor);
router.delete("/delete/:id", deleteAuthor);
export default router;
