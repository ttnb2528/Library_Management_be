import express from "express";
import { getThongKeMuonSach } from "../controller/ThongKe.controller.js";

const router = express.Router();

router.post("/thongkemuonsach", getThongKeMuonSach);

export default router;

