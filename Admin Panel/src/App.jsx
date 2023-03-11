import Dashboard from "./components/Dashboard";
import Header from "./components/Header";
import Sidebar from "./components/Sidebar";
import Transaction from "./components/Transaction";
import Users from "./components/Users";
import Subscription1 from "./components/Subscription1";
import Subscriptionform from "./components/Subscriptionform";
import Videolist from "./components/Videolist";
import { BrowserRouter as Router, Route,Routes } from "react-router-dom";
import Startstream from "./components/Startstream";
import Revenue from "./components/Revenue";

function App() {
  return (
    <Router>
      <div className="relative">
        <Header />
        <div className="flex flex-row">
          <Sidebar />
          <div className="flex-1">
            <Routes>

            <Route exact path="/" element={<Dashboard/>} />
            <Route path="/users" element={<Users/>} />
            <Route path="/transactions" element={<Transaction/>} />
            <Route path="/subscription" element={<Subscription1/>} />
            <Route path="/subscriptionform" element={<Subscriptionform/>} />
            <Route path="/startstream" element={<Startstream/>} />
            <Route path="/revenue" element={<Revenue/>} />
            </Routes>
          </div>
        </div>
      </div>
    </Router>
  );
}

export default App;
