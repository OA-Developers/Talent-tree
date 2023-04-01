import Dashboard from "./components/Dashboard";
import Header from "./components/Header";
import Sidebar from "./components/Sidebar";
import Transaction from "./components/Transaction";
import Users from "./components/Users";
import Subscription1 from "./components/Subscription1";
import Subscriptionform from "./components/Subscriptionform";

import { BrowserRouter as Router, Route,Routes } from "react-router-dom";
import Startstream from "./components/Startstream";
import Revenue from "./components/Revenue";
import LoginPage from "./components/login";
import Signup from "./components/Signup";
import Notification from "./components/Notification";

function App() {
  return (
    <Router>
      <div className="relative">
        <Routes>
          <Route path="/" element={<LoginPage />} />
          <Route path="/Signup" element={<Signup/>} />
          <Route path="/Notification" element={<Notification/>} />

          <Route path="*" element={
            <>
              <Header />
              <div className="flex flex-row">
                <Sidebar />
                <div className="flex-1">
                  <Routes>
                    <Route exact path="/Dashboard" element={<Dashboard />} />
                    <Route path="/users" element={<Users />} />
                    <Route path="/transactions" element={<Transaction />} />
                    <Route path="/subscription" element={<Subscription1 />} />
                    <Route path="/subscriptionform" element={<Subscriptionform />} />
                    <Route path="/startstream" element={<Startstream />} />
                    <Route path="/revenue" element={<Revenue />} />
                  </Routes>
                </div>
              </div>
            </>
          } />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
