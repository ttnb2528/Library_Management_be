import express from "express";
import {
  addLoanBook,
  getLoanBooks,
  getLoanBookById,
  updateLoanBook,
  deleteLoanBook,
} from "../controller/LoanBook.controller.js";

const router = express.Router();

router.post("/add", addLoanBook);
router.get("/get", getLoanBooks);
router.get("/get/:id", getLoanBookById);
router.put("/update/:id", updateLoanBook);
router.delete("/delete/:id", deleteLoanBook);

export default router;
