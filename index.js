import express from "express";
import userRoutes from "./routes/users.js";
import authRoutes from "./routes/auth.js";
import cors from "cors";
import cookieParser from "cookie-parser";

const app = express();

app.use(express.json());
app.use(cors());
app.use(cookieParser());

app.use("/api/users", userRoutes);
app.use("/api/auth", authRoutes);

app.get("/api", (req, res) => {
  res.send("API for panda-social");
});

app.listen(8800, () => {
  console.log("app is listening at port 8800");
});
