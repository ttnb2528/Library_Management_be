import express from "express";
import {
  addEmployee,
  getEmployees,
  getEmployeeById,
  updateEmployee,
  deleteEmployee,
} from "../controller/Employee.controller.js";

const router = express.Router();

router.post("/add", addEmployee);
router.get("/get", getEmployees);
router.get("/get/:id", getEmployeeById);
router.put("/update/:id", updateEmployee);
router.delete("/delete/:id", deleteEmployee);

export default router;
