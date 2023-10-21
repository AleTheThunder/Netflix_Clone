const contentController = require('../controllers/contentController');

module.exports = function(app){
    app.get('/content/top',async(req,res)=>{
        const response = await contentController.getTop(req.query.country, req.query.type, req.query.limit);
        res.status(response.code).send(response.data);
    });

    app.get('/content/latest',async(req,res)=>{
        const response = await contentController.getLatest(req.query.type, req.query.limit);
        res.status(response.code).send(response.data);
    });

    app.get('/content/rating/:id',async(req,res)=>{
        const response = await contentController.getRating(req.params.id);
        res.status(response.code).send(response.data);
    });

}
