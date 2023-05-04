const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const bodyParser = require("body-parser");
const cors = require('cors');
const bannerRouter = require("./routes/banner")
const https = require('https');
const fs = require('fs');
require("dotenv").config();

const PORT = process.env.PORT || 8000;
const app = express();

app.use(cors());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.use(express.json());
app.use(authRouter);
app.use(bannerRouter);

app.use((req, res, next) => {
  if (req.secure) {
    next();
  } else {
    res.redirect(`https://${req.headers.host}${req.url}`);
  }
});

mongoose
  .connect(process.env.DATABASE_URL)
  .then(() => {
    console.log("Connected to DB");
  })
  .catch((e) => {
    console.log(e);
  });

const options = {
  key: fs.readFileSync('/etc/letsencrypt/live/talenttree.in/privkey.pem'),
  cert: fs.readFileSync('/etc/letsencrypt/live/talenttree.in/fullchain.pem')
};


app.get("/", (req, res) => {
  res.send("Hello World");
});

//app.listen(PORT, () => {
// console.log(`Server started on http://localhost:${PORT}`);
//});

https.createServer(options, app).listen(8000, () => {
  console.log('Server listening on port 8000');
});
