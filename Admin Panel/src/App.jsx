import { useState, useEffect } from "react";
import Dashboard from "./pages/Dashboard";
import Sidebar from "./components/Sidebar";
import Transaction from "./pages/Transaction";
import Users from "./pages/Users";
import { BrowserRouter as Router, Route, Routes, useNavigate } from "react-router-dom";
import Startstream from "./pages/Startstream";
import Revenue from "./pages/Revenue";
import LoginPage from "./pages/Login";
import Notification from "./components/Notification";
import Audience from "./pages/Audience";
import Banners from "./pages/Banners";
import Debate from "./pages/Debate";
import Subscription from "./pages/Subscription";
import Coupons from "./pages/Coupons";
import Settings from "./pages/Settings";

function ProtectedRoutes() {
  const [loggedIn, setLoggedIn] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem("user");
    if (token) {
      setLoggedIn(true);
    } else {
      navigate("/login");
    }
    console.log(token);
  }, [navigate]);

  if (!loggedIn) {
    return null;
  }

  return (
    <div className="flex flex-row">
      <Sidebar />
      <div className="flex-1">
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/users" element={<Users />} />
          <Route path="/audience" element={<Audience />} />
          <Route path="/banners" element={<Banners />} />
          <Route path="/transactions" element={<Transaction />} />
          <Route path="/subscription" element={<Subscription />} />
          <Route path="/coupons" element={<Coupons />} />
          <Route path="/startstream" element={<Startstream />} />
          <Route path="/revenue" element={<Revenue />} />
          <Route path="/debates" element={<Debate />} />
          <Route path="/settings" element={<Settings />} />
        </Routes>
      </div>
    </div>
  );
}

function LoginRedirect() {
  const navigate = useNavigate();
  const token = localStorage.getItem("user");

  useEffect(() => {
    if (token) {
      navigate("/");
    }
  }, [navigate, token]);

  return <LoginPage />;
}

function App() {
  return (
    <Router>
      <div className="relative">
        <Routes>
          <Route path="/login" element={<LoginRedirect />} />
          <Route path="/*" element={<ProtectedRoutes />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
