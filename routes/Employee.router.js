import express from "express";
import {
  getEmployees,
  getEmployeeById,
  updateEmployee,
} from "../controller/Employee.controller.js";

const router = express.Router();

router.get("/get", getEmployees);
router.get("/get/:id", getEmployeeById);
router.put("/update/:id", updateEmployee);

export default router;
