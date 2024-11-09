import express from "express";
import {
  addLibraryCard,
  getLibraryCards,
  getLibraryCardById,
  updateLibraryCard,
  deleteLibraryCard,
} from "../controller/LibraryCard.controller.js";

const router = express.Router();

router.post("/add", addLibraryCard);
router.get("/get", getLibraryCards);
router.get("/get/:card_number", getLibraryCardById);
router.put("/update/:card_number", updateLibraryCard);
router.delete("/delete/:card_number", deleteLibraryCard);

export default router;
