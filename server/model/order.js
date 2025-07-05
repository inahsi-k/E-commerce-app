//hierarchy user--then order so userid under order
const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
  userID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'user',
    required: true
  },
  orderDate: {
    type: Date,
    default: Date.now
  },
  orderStatus: {
    type: String,
    enum: ['pending', 'processing', 'shipped', 'delivered', 'cancelled'],
    default: 'pending'
  },
  items: [
    {
      productID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'product',
        required: true
      },
      productName: {
        type: String,
        required: true
      },
      quantity: {
        type: Number,
        required: true
      },
      price: {
        type: Number,
        required: true
      },
      variant: {
        type: String,
      },
    }
  ],
  totalPrice: {
    type: Number,
    required: true
  },
  shippingAddress: {
    phone: {type:String,required:true},
    street: String,
    city: String,
    state: String,
    postalCode: String,
    country: String
  },

  paymentMethod: {
    type: String,
    enum: ['cod', 'prepaid']
  },

  couponCode: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'coupon'
},
  orderTotal: {
    subtotal: Number,
    discount: Number,
    total: Number
  },
  trackingUrl: {
    type: String
  },
});

const Order = mongoose.model('order', orderSchema);

module.exports = Order;
