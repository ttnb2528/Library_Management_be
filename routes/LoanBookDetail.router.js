import express from "express";
import {
  getLoanBookDetails,
  getLoanBookDetailById,
  updateLoanBookDetail,
} from "../controller/LoanBookDetail.controller.js";

const router = express.Router();

router.get("/get", getLoanBookDetails);
router.get("/get/:id", getLoanBookDetailById);
router.put("/update/:id&:ISBN_OLD", updateLoanBookDetail);

export default router;
