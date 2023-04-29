import { useState, useEffect } from "react";
import Dashboard from "./pages/Dashboard";
import Sidebar from "./components/Sidebar";
import Transaction from "./pages/Transaction";
import Users from "./pages/Users";
import Subscription1 from "./pages/Subscription1";
import Subscriptionform from "./pages/Subscriptionform";
import { BrowserRouter as Router, Route, Routes, useNavigate } from "react-router-dom";
import Startstream from "./pages/Startstream";
import Revenue from "./pages/Revenue";
import LoginPage from "./pages/Login";
import Notification from "./components/Notification";
import Audience from "./pages/Audience";
import Banners from "./pages/Banners";


function ProtectedRoutes() {
  const [loggedIn, setLoggedIn] = useState(false);
  const navigate = useNavigate();


  useEffect(() => {
    const token = localStorage.getItem("user");
    if (token) {
      setLoggedIn(true);
    } else {
      navigate("/");
      console.log("na");
    }
  }, [navigate]);


  if (!loggedIn) {
    return null;
  }


  return (
    <div className="flex flex-row">
      <Sidebar />
      <div className="flex-1">
        <Routes>
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/users" element={<Users />} />
          <Route path="/audience" element={<Audience />} />
          <Route path="/banners" element={<Banners />} />
          <Route path="/transactions" element={<Transaction />} />
          <Route path="/subscription" element={<Subscription1 />} />
          <Route path="/subscriptionform" element={<Subscriptionform />} />
          <Route path="/startstream" element={<Startstream />} />
          <Route path="/revenue" element={<Revenue />} />
        </Routes>
      </div>
    </div>
  );
}


function App() {
  return (
    <Router>
      <div className="relative">
        <Routes>
          <Route path="/" element={<LoginPage />} />
          <Route path="/*" element={<ProtectedRoutes />} />
        </Routes>
      </div>
    </Router>
  );
}


export default App;
