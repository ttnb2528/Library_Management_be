import express from "express";
const app = express();
import cors from "cors";

app.use(cors());
app.use(express.json());
const router = express.Router();

import AuthRouter from "./Auth.router.js";
import AuthorRouter from "./Author.router.js";

app.use("/auth", AuthRouter);
app.use("/author", AuthorRouter);

export default app;
