import React from "react";
import { FaUserAlt } from "react-icons/fa";

export default function Revenue() {
  return (
    <div className="ml-7">
      <div className="inline-block bg-blue-300 shadow-md rounded-sm p-6">
        <p>
          <b>Total Revenue</b>
        </p>
        <p className="pl-7 pt-2">$300K</p>
        <p className="flex pl-20 pt-5">
          <p className="pt-1">
            <FaUserAlt />
          </p>
          <p>&nbsp;300</p>
        </p>
      </div>
      <hr className="mt-[121px] w-[96%] border-1 border-black"></hr>
      <p>
        <b>Course Wise Details</b>
      </p>
      <br></br>
      <div className="flex gap-7">
        <div className="block w-[246px] p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 ">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Dialogues
          </h5>
          <div className="font-normal text-gray-700 dark:text-gray-400 gap-3">
            <p>$20K</p>
            <div className="flex p-3 gap-3 ml-32">
              <p className="flex">
                <p className="pt-1">
                  <FaUserAlt />
                </p>
                <p>&nbsp;300</p>
              </p>
            </div>
          </div>
        </div>
        <div className="block w-[246px] p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 ">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Expressions
          </h5>
          <div className="font-normal text-gray-700 dark:text-gray-400 gap-3">
            <p>$100</p>
            <div className="flex p-3 gap-3 ml-32">
              <p className="flex">
                <p className="pt-1">
                  <FaUserAlt />
                </p>
                <p>&nbsp;300</p>
              </p>
            </div>
          </div>
        </div>
        <div className="block w-[246px] p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 ">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Memorization
          </h5>
          <div className="font-normal text-gray-700 dark:text-gray-400 gap-3">
            <p>$100</p>
            <div className="flex p-3 gap-3 ml-32">
              <p className="flex">
                <p className="pt-1">
                  <FaUserAlt />
                </p>
                <p>&nbsp;300</p>
              </p>
            </div>
          </div>
        </div>
        <div className="block w-[246px] p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 ">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Salesmanship
          </h5>
          <div className="font-normal text-gray-700 dark:text-gray-400 gap-3">
            <p>$100</p>
            <div className="flex p-3 gap-3 ml-32">
              <p className="flex">
                <p className="pt-1">
                  <FaUserAlt />
                </p>
                <p>&nbsp;300</p>
              </p>
            </div>
          </div>
        </div>
      </div>
      <div className="mt-7 flex gap-7">
        <div className="block w-[246px] p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 ">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Teamwork
          </h5>
          <div className="font-normal text-gray-700 dark:text-gray-400 gap-3">
            <p>$100</p>
            <div className="flex p-3 gap-3 ml-32">
              <p className="flex">
                <p className="pt-1">
                  <FaUserAlt />
                </p>
                <p>&nbsp;300</p>
              </p>
            </div>
          </div>
        </div>
        <div className="block w-[246px] p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 ">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Improv
          </h5>
          <div className="font-normal text-gray-700 dark:text-gray-400 gap-3">
            <p>$100</p>
            <div className="flex p-3 gap-3 ml-32">
              <p className="flex">
                <p className="pt-1">
                  <FaUserAlt />
                </p>
                <p>&nbsp;300</p>
              </p>
            </div>
          </div>
        </div>
        <div className="block w-[246px] p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 ">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Communication
          </h5>
          <div className="font-normal text-gray-700 dark:text-gray-400 gap-3">
            <p>$100</p>
            <div className="flex p-3 gap-3 ml-32">
              <p className="flex">
                <p className="pt-1">
                  <FaUserAlt />
                </p>
                <p>&nbsp;300</p>
              </p>
            </div>
          </div>
        </div>
        <div className="block w-[246px] p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 ">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Innovation
          </h5>
          <div className="font-normal text-gray-700 dark:text-gray-400 gap-3">
            <p>$100</p>
            <div className="flex p-3 gap-3 ml-32">
              <p className="flex">
                <p className="pt-1">
                  <FaUserAlt />
                </p>
                <p>&nbsp;300</p>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
