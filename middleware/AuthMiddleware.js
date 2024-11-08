import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import jwt from "jsonwebtoken";

const AuthMiddleware = (req, res, next) => {
  const JWT_TOKEN_SECRET = process.env.JWT_TOKEN_SECRET;

  if (req.headers["auth"] === undefined) {
    return res.json(jsonGenerate(StatusCode.NON_AUTH_INFO, "Access denied!"));
  }

  const token = req.headers["auth"];

  try {
    const decoded = jwt.verify(token, JWT_TOKEN_SECRET);
    console.log(decoded);

    req.userId = decoded.userId;

    return next();
  } catch (error) {
    return res.json(jsonGenerate(StatusCode.SERVER_ERROR, "Invalid token!"));
  }
};

export default AuthMiddleware;
