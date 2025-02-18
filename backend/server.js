const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const db = require("./db");

const adminRoutes = require("./routes/adminRoutes");
const userRoutes = require("./routes/userRoutes");
const teacherRoutes = require("./routes/teacherRoutes");
const studentRoutes = require("./routes/studentRoutes");

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// Use existing routes
app.use("/admin", adminRoutes);
app.use("/users", userRoutes);
app.use("/teacher", teacherRoutes);
app.use("/student", studentRoutes);

const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server running on port 5000`);
});
