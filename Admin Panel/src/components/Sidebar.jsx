import React from "react";
import { Link } from "react-router-dom";
import { GrChat, GrGroup, GrTransaction } from "react-icons/gr";
import { MdOutlineDashboard, MdOutlineGroup } from "react-icons/md";
import { MdOutlineSubscriptions } from "react-icons/md";

import logo_h from "../assets/logo_h.png"
import logo from "../assets/logo.png"
import { FiSettings } from "react-icons/fi";
import { FaGift, FaMoneyBill, FaUser } from "react-icons/fa";

export default function Sidebar() {
  return (
    <aside className="flex flex-col w-64 h-screen px-4 py-8 overflow-y-auto bg-white border-r drop-shadow-md border-gray-300">
      <Link to="/">
        <img
          className="w-full object-cover h-20"
          src={logo_h}
          alt=""
        ></img>
      </Link>



      <div className="flex flex-col justify-between flex-1 mt-10">
        <nav>
          <Link
            className="flex items-center px-4 py-2 text-gray-700 rounded-md no::hover:bg-gray-800 no::hover:text-gray-200 no::text-gray-400 hover:text-gray-700 hover:bg-gray-100"
            to="/"
          >
            <MdOutlineDashboard />

            <span className="mx-4 font-medium">Dashboard</span>
          </Link>

          <Link
            className="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md no::text-gray-400 hover:bg-gray-100 no::hover:bg-gray-800 no::hover:text-gray-200 hover:text-gray-700"
            to="/users"
          >
            <FaUser />

            <span className="mx-4 font-medium">Users</span>
          </Link>

          <Link
            className="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md no::text-gray-400 hover:bg-gray-100 no::hover:bg-gray-800 no::hover:text-gray-200 hover:text-gray-700"
            to="/audience"
          >
            <GrGroup />

            <span className="mx-4 font-medium">Audience</span>
          </Link>
          <Link
            className="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md no::text-gray-400 hover:bg-gray-100 no::hover:bg-gray-800 no::hover:text-gray-200 hover:text-gray-700"
            to="/debates"
          >
            <GrChat />

            <span className="mx-4 font-medium">Debate</span>
          </Link>
          <Link
            className="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md no::text-gray-400 hover:bg-gray-100 no::hover:bg-gray-800 no::hover:text-gray-200 hover:text-gray-700"
            to="/coupons"
          >
            <FaGift />

            <span className="mx-4 font-medium">Coupons</span>
          </Link>

          <Link
            className="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md no::text-gray-400 hover:bg-gray-100 no::hover:bg-gray-800 no::hover:text-gray-200 hover:text-gray-700"
            to="/subscription"
          >
            <MdOutlineSubscriptions />

            <span className="mx-4 font-medium">Subscription</span>
          </Link>

          <hr className="my-6 border-gray-200 no::border-gray-600" />

          <Link
            className="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md no::text-gray-400 hover:bg-gray-100 no::hover:bg-gray-800 no::hover:text-gray-200 hover:text-gray-700"
            to="/revenue"
          >
            <FaMoneyBill />

            <span className="mx-4 font-medium">Revenue Details</span>
          </Link>

          <Link
            className="flex items-center px-4 py-2 mt-5 text-gray-600 transition-colors duration-300 transform rounded-md no::text-gray-400 hover:bg-gray-100 no::hover:bg-gray-800 no::hover:text-gray-200 hover:text-gray-700"
            to="/settings"
          >
            <FiSettings />

            <span className="mx-4 font-medium">Settings</span>
          </Link>
        </nav>

        <a href="#" className="flex items-center px-4 -mx-2">
          <img
            className="object-cover mx-2 rounded-full h-9 w-9"
            src={logo}
            alt="avatar"
          />
          <span className="mx-2 font-medium text-gray-800 no::text-gray-200">
            Admin
          </span>
        </a>
      </div>
    </aside>
  );
}
