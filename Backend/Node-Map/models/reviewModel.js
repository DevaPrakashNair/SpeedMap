const mongoose = require('mongoose');
const schema = mongoose.Schema;
var SchemeTypes =  mongoose.Schema.Types;

const reviewModelSchema = new mongoose.Schema({
    review:{
        type: String
    },
    datetime:{
        type: String
    },
    time:{
        type: String
    },
    location:{
        type: String
    },
    role:{
        type:String,
        default: 'review'
    },
    status:{
        type: String,
        default: 'Active'
    }
});

module.exports = mongoose.model("reviewModel",reviewModelSchema);
