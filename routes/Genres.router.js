import express from "express";
import {
  addGenre,
  getGenres,
  getGenreById,
  updateGenre,
  deleteGenre,
} from "../controller/Genres.controller.js";

const router = express.Router();

router.post("/add", addGenre);
router.get("/get", getGenres);
router.get("/get/:id", getGenreById);
router.put("/update/:id", updateGenre);
router.delete("/delete/:id", deleteGenre);

export default router;
