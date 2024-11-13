import express from "express";
const app = express();
import cors from "cors";

app.use(cors());
app.use(express.json());
const router = express.Router();

import AuthRouter from "./Auth.router.js";
import AuthorRouter from "./Author.router.js";
import GenresRouter from "./Genres.router.js";
import PublisherRouter from "./Publisher.router.js";
import EmployeeRouter from "./Employee.router.js";
import LibraryCardRouter from "./LibraryCard.router.js";
import ReaderRouter from "./Reader.router.js";
import BookRouter from "./Book.router.js";

app.use("/auth", AuthRouter);
app.use("/author", AuthorRouter);
app.use("/genres", GenresRouter);
app.use("/publisher", PublisherRouter);
app.use("/employee", EmployeeRouter);
app.use("/libraryCard", LibraryCardRouter);
app.use("/reader", ReaderRouter);
app.use("/book", BookRouter);

export default app;
