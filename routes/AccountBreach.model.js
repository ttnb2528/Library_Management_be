import express from "express";
import {
  createAccountBreach,
  getAllAccountBreach,
  getAccountBreachById,
  updateAccountBreach,
  deleteAccountBreach,
} from "../controller/AccountBreach.controller.js";

const router = express.Router();

router.post("/add", createAccountBreach);
router.get("/get", getAllAccountBreach);
router.get("/get/:id", getAccountBreachById);
router.put("/update/:id", updateAccountBreach);
router.delete("/delete/:id", deleteAccountBreach);

export default router;
