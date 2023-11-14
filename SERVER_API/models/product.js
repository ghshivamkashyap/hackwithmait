const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
  name: String,
  price: Number,
  expiry: Date,
  pid: Number,
  isavailable: {
    type: Boolean,
    default: true,
  },
});

module.exports = mongoose.model("Product", productSchema);
