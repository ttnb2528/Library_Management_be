import express from "express";
import {
  loginUser,
  registerUser,
  getAllUser,
  getUserById,
  updateUser,
  deleteUser,
} from "../controller/Auth.controller.js";

const router = express.Router();

router.post("/register", registerUser);
router.post("/login", loginUser);

router.get("/get", getAllUser);
router.get("/get/:id", getUserById);
router.put("/update/:id", updateUser);
router.delete("/delete/:id", deleteUser);

export default router;
