import express from "express";
import {
  addPublisher,
  getPublishers,
  getPublisherById,
  updatePublisher,
  deletePublisher,
} from "../controller/Publisher.controller.js";

const router = express.Router();

router.post("/add", addPublisher);
router.get("/get", getPublishers);
router.get("/get/:id", getPublisherById);
router.put("/update/:id", updatePublisher);
router.delete("/delete/:id", deletePublisher);

export default router;
