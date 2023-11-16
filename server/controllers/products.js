const Bill = require("../models/Bill");
const Products = require("../models/Products");

// get product using pid id
exports.getProductById = async (req, res) => {
  try {
    const pid = req.params.pid;
    console.log(pid);

    const product = await Products.findOne({ pid: pid });

    if (product) {
      return res.status(200).json({
        iserror: false,
        message: "success",
        product: product,
      });
    } else {
      return res.status(404).json({
        iserror: true,
        message: "Product not found",
        product: null,
      });
    }
  } catch (error) {
    console.error("Error fetching product:", error);
    return res.status(500).json({
      iserror: true,
      message: "Internal Server Error",
      product: null,
    });
  }
};

// add new product
exports.addProduct = async (req, res) => {
  try {
    const data = req.body;
    console.log(data);

    await Products.create({
      pid: data.pid,
      name: data.name, // Fix the typo here
      mrp: data.mrp,
      currprice: data.currprice,
    });

    return res.status(200).json({
      iserror: false,
      message: "Success, product added successfully",
    });
  } catch (error) {
    console.error("Error adding product:", error);
    return res.status(500).json({
      iserror: true,
      message: "Internal Server Error",
      product: null,
    });
  }
};

// genrate bill from array of products

exports.genrateBiill = async (req, res) => {
  try {
    // ['122', '56', '56']
    const items = req.body.items;
    
    var total = 0;
    var mrp = 0;
    let productArr = [];
    console.log(items);
    for (var i = 0; i < items.length; i++) {
      const item = await Products.findOne({ pid: items[i] });
      console.log(item.currprice, item.mrp); // Add this line to log values
      productArr.push(item.pid);
      total = total + item.currprice;
      mrp = mrp + item.mrp;
      console.log(item);
    }

    const bill = new Bill({
      products: productArr,
      totalPrice: total,
      mrp: mrp,
    });

    await bill.save();

    if (bill) {
      return res.status(200).json({
        iserror: false,
        message: "success",
        bill: bill,
      });
    }
  } catch (error) {
    console.log(error);
    return res.status(400).json({
      iserror: true,
      message: "internal server error",
    });
  }
};
