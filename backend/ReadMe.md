# Backend
## Controller Pattern Explanation:
Für jede Kategorie/Tabelle gibt es eine ...Routes.js und ...Controller.js Datei. In der Routes.js kommen die Routen und in Controller.js die ganzen Funktionen. In der Routes.js Datei muss nur der Controller importiert werden. Um eine neue "Kategorie" hinzuzufügen muss nur in der Server.js Datei eine Kategorie hinzugefügt werden.
```js
/* Include all Routes */
['movie', /** hier hinzufügen */].forEach(route => {
    require(`./src/routes/${route}Routes`)(app);
});
```
### Routes
```js
const movieController = require('../controllers/movieController');

module.exports = function(app){
    app.get('/movies', async(req,res)=>{
        const response = await movieController.getMovies();
        res.status(response.code).send(response.data);
    });

    app.post('/movies/add', async(req,res)=>{
        const response = await movieController.addMovie(req.body.name);
        res.status(response.code).send(response.data);
    });

    app.delete('/movies/delete/:id', async(req,res)=>{
        console.log(req.params);
        const response = await movieController.deleteMovie(req.params.id);
        res.status(response.code).send(response.data);
    });

    app.post('/movies/edit', async(req,res)=>{
        const response = await movieController.updateMovie(req.body.id, req.body.name);
        res.status(response.code).send(response.data);
    });
};
```
### Controller
```js
/** Fetch Movies */
async function getMovies(){
    const movies = await db.query(
        `SELECT * FROM movies ORDER BY release_date DESC`
    );

    return {data: movies, code: CODES.SUCCESS.code};
}

/** Add Movie */
async function addMovie(name){
    if(!helper.isDefined(name)) return {data: CODES.MISSING_PARAMS.key, code: CODES.MISSING_PARAMS.code};

    const exists = await db.query(
        `SELECT * FROM movies WHERE name = :name`,
        {name: name}
    );

    // if there is already a movie with the same name respond with an error
    if(exists.length > 0) return {data: CODES.EXISTS_ALREADY.key, code: CODES.EXISTS_ALREADY.code};

    const added = await db.query(
        `INSERT INTO movies (name, release_date) VALUES (:name, NOW())`,
        {name: name}
    );

    // check if adding was successful (otherwise insertId is null)
    if(added.insertId) return {data: CODES.SUCCESS.key, code: CODES.SUCCESS.code};
    else return {data: CODES.ERROR.key, code: CODES.ERROR.code};
}

/* ... */
```
Jede Funktion in den Controller gibt ein Objekt zurück mit den properties 'data' und 'code'. Somit muss man bei den Routen-Definitionen nichts mehr ändern und bleibt bei allen Routen gleich.
## Validation
Um Inputs schnell auf undefined oder null zu überprüfen gibt es im helper eine Hilfsfunktion "isDefined".
Um zu überprüfen ob ein hinzufügen Erfolgreich war kann man die insertId überprüfen:
```js
// check if adding was successful (otherwise insertId is null)
if(added.insertId) return {data: CODES.SUCCESS.key, code: CODES.SUCCESS.code};
else return {data: CODES.ERROR.key, code: CODES.ERROR.code};
```
Um zu überprüfen ob ein update oder delete Erfolgreich war kann man die updatedRows überprüfen
```js
// check if deletion was successful
if(deleted.affectedRows > 0) return {data: CODES.SUCCESS.key, code: CODES.SUCCESS.code};
else return {data: CODES.ERROR.key, code: CODES.ERROR.code};
```

//TODO: 
//Wenn was gemacht ist: löschem
//Wenn ihr Ideen habt, schreibt sie hier rein!
--
Login(salt+hash)
logout
Sign Up
next Content recommondation afer findesed older Content
Recommendation for Movies based of viewed movies
Recommendation for series based of viewed series
Recommedation based of watched content (habe Star Wars 1 geschaut => Alle anderen Star Wars Filme und Serien, Star Trek, Space Filme usw.)
Add Movie to Watchlist. 
Delete Movie from Watchlist
Order Watchlist
Recommendation for Watchlist
Recommend watched content to watch again
Display current or not finised content as "continue to watch" (weiter schauen,)
Delete from "contunue to watch" content after content ends but the screenplay is still on (Content ist ferit aber es gibt 2 Minuten abspann, trotzdem soll der Content nicht mehr bei "weiterschauen angeszeigt werden")
Load Content information (Actors, Dircector, Realease Date)
Recommend Content based on, where the Content was made. (Top Japanische Filme, Top Französische Serien usw)
save rating of one content in database
--