import React from "react";
import { Link } from "react-router-dom";
import img from "../assets/download.jpeg";

export default function Dashboard() {
  return (
    <div className="parent flex flex-col p-5">
      <h1>Channel Dashboard</h1>
      <div className="flex flex-row gap-5 m-3">
        <div class=" flex flex-col justify-center align-middle bg-blue rounded-lg shadow-xl dark:bg-blue w-[350px] border border-slate-300 p-3 py-10">
          <img className="mt-10 mb-2 " src={img} alt=":)"></img>
          <p className="text-center">
            Want to see metrics on your recent video? Upload and publish a video
            to get started.
          </p>
          <div className="flex pl-[23px]">
            <Link to="/startstream">
          <button class="py-2 px-3 text-white bg-slate-500 w-[125px] h-[56px] text-sm m-2 rounded-md self-center mb-10 hover:bg-slate-400">
            Start Live
          </button>
          </Link>
          <button class="py-2 px-3 text-white bg-slate-500 h-[56px] w-[114px] text-sm m-2 rounded-md self-center mb-10 hover:bg-slate-400">
            Your Videos
          </button>
          </div>

        </div>

        <div
          class="relative rounded-lg shadow-xl p-5 h-[350px] border border-slate-300"
        >
          <p>
            <b>Channel analytics</b>
          </p>
          <p>Current subscribers</p>
          <p>2</p>
          <br></br>
          <br></br>
          <hr></hr>
          <p>
            <b>Summary</b>
          </p>
          <p>last 28 days</p>
          <p>
            <table>
              <tr>
                <td>Veiws</td>
                <td>16</td>
              </tr>
              <tr>
                <td style={{ width: "201px" }}>Watch Time</td>
                <td>0.2</td>
              </tr>
            </table>
          </p>
          <br></br>
          <br></br>
          <hr></hr>
          <p>
            <b>Top Videos</b>
          </p>
          <p>Last 48 hours.Veiws</p>
        </div>
        <div className="relative rounded-lg shadow-xl p-5 h-[350px] border border-slate-300">
          <p className="text-[30px]"><b>Total Users</b></p>
          <p className="text-[25px]">51 Lakh</p>
          <br></br>
          <br></br>
          <br></br>
          <hr></hr>
          <p className="text-[30px]"><b>Subscribed Users</b></p>
          <p className="text-[25px]">100</p>

        </div>
      </div>
    </div>
  );
}
