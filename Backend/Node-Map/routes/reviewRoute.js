const router=require("express").Router()
const { get } = require("http");
const reviewModel=require('../models/reviewModel');

router.post('/review/recieve',async(req,res)=>{
    try 
    {
         var{review,location} = req.body;
         if(review == null || review == undefined){
            res.status(200).json({
                status: false,
                msg: 'Review Needed',
            });
            return;
         }
         if(location == null || location == undefined){
            res.status(200).json({
                status: false,
                msg: 'location Needed',
            });
            return;
         }
         var rev = new reviewModel({
            review: review,
            location: location,
            // time: get.currenttime(),
            datetime: Date(Date.now),
         })
         await rev.save() // to save data in database
         res.status(200).json({
            status:true, msg:"sucessful", data: rev
         })

    } 
    catch (error) 
    {
        console.log(error);
        res.status(500).json({
            status:false,
            msg:'Internal Server Error'
        })
        return;
    }
})

router.get('/view/review',async(req,res)=>{
    try {
        var view = await reviewModel.findOne({role:'review'})
        
        res.status(200).json({
            status: true, 
            msg:"sucessful",
            data: view
         })
       
    } catch (error) {
        console.log(error);
        res.status(500).json({
            status:false,
            msg:'Internal Server Error'
        })
        return;        
    }
})
module.exports=router;