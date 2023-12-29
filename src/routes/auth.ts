import { Router } from "express";
import { authRegister } from "../controllers/auth.js";

const router = Router();

router.post("register", authRegister);
// router.post("login", authLogin);
// router.post("logout", authLogout);

export default router;
