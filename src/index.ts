import express from "express";
import authRouter from "./routes/auth.js";

const app = express();
const port = 8800;

app.use("api/auth", authRouter);

app.listen(port, () => {
  console.log("app is working");
});
