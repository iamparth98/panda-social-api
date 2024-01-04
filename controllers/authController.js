import { db } from "../connectDb.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

export const register = (req, res) => {
  //check if user exists
  const q = "SELECT * FROM users WHERE username = ?";
  db.query(q, [req.body.username], (err, data) => {
    if (err) return res.json(err);
    if (data.length) return res.json("user already exists");

    //Create new user

    //hash password
    const salt = bcrypt.genSaltSync(10);
    const hashedPassword = bcrypt.hashSync(req.body.password, salt);

    //store user details
    const q = "INSERT INTO users (username, email , name, password) VALUES (?)";
    const values = [
      req.body.username,
      req.body.email,
      req.body.name,
      hashedPassword,
    ];
    db.query(q, [values], (err, data) => {
      if (err) res.send(err);
      if (data) res.send("data successfully added");
    });
  });
};

export const login = (req, res) => {
  //find user
  const q = "SELECT * FROM users where username = ?";
  db.query(q, [req.body.username], (err, data) => {
    if (err) return res.send(err);
    if (data.length === 0) return res.json("No User Found");

    //compare password
    const comparePassword = bcrypt.compareSync(
      req.body.password,
      data[0].password
    );
    if (!comparePassword) return res.send("Wrong username or password");

    //set jwt cookie
    const token = jwt.sign({ id: data[0].id }, "secretKey");
    const { password, ...others } = data[0];
    res
      .cookie("accessToken", token, {
        httpOnly: true,
      })
      .status(200)
      .json(others);
  });
};

export const logout = (req, res) => {
  res
    .clearCookie("accessToken", {
      secure: true,
      samesite: "none",
    })
    .status(200)
    .send("User logged out");
};
