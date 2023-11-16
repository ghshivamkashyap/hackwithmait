const mongoose = require("mongoose");

// schema defination
const billSchema = new mongoose.Schema(
  {
    products: [{ type: String, required: true }],
    totalPrice: Number,
    mrp: Number,
  },
  { timestamps: true }
);

module.exports = mongoose.model("Bill", billSchema);
