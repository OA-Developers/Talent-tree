const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
require("dotenv").config();

const PORT = process.env.PORT || 8000;
const app = express();

app.use(express.json());
app.use(authRouter);

mongoose
  .connect(process.env.DATABASE_URL)
  .then(() => {
    console.log("Connected to DB");
  })
  .catch((e) => {
    console.log(e);
  });

app.get("/", (req, res) => {
  res.send("Hello World");
});

app.listen(PORT, () => {
  console.log(`Server started on http://localhost:${PORT}`);
});
