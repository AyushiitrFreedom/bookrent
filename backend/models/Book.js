const mongoose = require('mongoose');
const { Schema } = mongoose;

const BookSchema = new Schema({
    user:{
      type:mongoose.Schema.Types.ObjectId,
      ref : 'user'
    },
    key: {
      type: String,
      required: true,
    },
    price:{
      type: Number,
      required: true,
      min : 0,
    }
   
  });
  
  module.exports = mongoose.model('book',TasksSchema);