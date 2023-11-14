const mongoose = require("mongoose");

const BillSchema = mongoose.Schema(
  {
    products: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
      },
    ],
    totalPrice: Number,
  },
  { timestamps: true }
);

module.exports = mongoose.model("Bill", BillSchema);
