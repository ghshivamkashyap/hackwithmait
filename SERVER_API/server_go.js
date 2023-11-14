const db = require("./db/db.js");
db.connectDB();
const express = require("express");
const dotenv = require("dotenv");

const cors = require("cors");
const bodyParser = require("body-parser");
const proute = require("./router/product.js");

dotenv.config();

const app = express();
app.use(express.json());
const corsOptions = {
  origin: "*",
  credentials: true,
  optionSuccessStatus: 200,
};
app.use(cors(corsOptions));

app.use(bodyParser.urlencoded({ extended: false }));

app.use(bodyParser.json());
app.use(express.static("public"));
app.set("view engine", "ejs");
app.use("/files", express.static("uploads"));

app.get("/", async (req, resq, next) => {
  resq.send("Hello From Express default route");
});

//  Routes
app.use("/api", proute);

const PORT = 5111;
app.listen(PORT, () => {
  console.log(`Server is Runing on Port ${PORT}`);
});
