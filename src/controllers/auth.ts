import { Prisma } from "@prisma/client";
import prisma from "../connectdb.js";
import bcrypt from "bcrypt";

export const authRegister = async (req: any, res: any) => {
  //check db for existing user
  //   try {
  //     const checkExistingUser = await prisma.users.findMany({
  //       where: {
  //         username: req.body.username,
  //       },
  //     });
  //     if (checkExistingUser.length)
  //       return res.status(409).json("user already exists");
  //   } catch (err) {
  //     console.log(err);
  //     return res.status(500).json(err);
  //   }

  //hash password
  const salt = bcrypt.genSaltSync(10);
  const hashedPassword = bcrypt.hashSync(req.body.password, salt);

  //create new user
  try {
    prisma.users.createMany({
      data: {
        username: req.body.username,
        password: hashedPassword,
        email: req.body.email,
        name: req.body.name,
      },
    });
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError) {
      if ((err.code = "P2002")) console.log("cient alredy exists");
    }
    throw err;
  }
};

// export const authLogin = (req, res) => {};

// export const authLogout = (req, res) => {};
