// const mongoose = require("mongoose");
// require("dotenv").config();

// exports.connect = () => {
//   mongoose
//     .connect(process.env.MONGODB_URL, {
//       dbName: process.env.DB_NAME,
//       useNewUrlParser: true,
//       useUnifiedTopology: true,
//     })
//     .then(() => console.log("db connected"))
//     .catch((err) => {
//       console.log("db connection failed");
//       console.error(err);
//       process.exit(1);
//     });
// };
const mongoose = require("mongoose");
require("dotenv").config();

exports.connect = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URL, {
      dbName: process.env.DB_NAME,
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("DB connected");
  } catch (error) {
    console.error("DB connection failed:", error.message);
    process.exit(1);
  }
};

