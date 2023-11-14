const mongoose = require("mongoose");
require("dotenv").config();

mongoose.set("strictQuery", true);
const connectDB = () => {
  mongoose
    .connect(process.env.MONGO_URI, {
      dbName: process.env.DB_NAME,
    })

    .then(() => {
      console.log("mongodb connected");
    })
    .catch((err) => console.log(err.message));

  mongoose.connection.on("connected", () => {
    console.log("Mongoose Connected to db");
  });
};
module.exports = { connectDB };
