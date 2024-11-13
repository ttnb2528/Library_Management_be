import express from "express";
import {
  // addLibraryCard,
  getLibraryCards,
  getLibraryCardById,
  updateLibraryCard,
  // deleteLibraryCard,
} from "../controller/LibraryCard.controller.js";

const router = express.Router();

// router.post("/add", addLibraryCard);
router.get("/get", getLibraryCards);
router.get("/get/:id", getLibraryCardById);
router.put("/update/:id", updateLibraryCard);
// router.delete("/delete/:id", deleteLibraryCard);

export default router;
