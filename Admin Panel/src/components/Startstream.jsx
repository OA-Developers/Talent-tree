import React from "react";

export default function startstream() {
  return (
    <div className="flex justify-center w-full ">
      <div class="flex h-fit justify-center align-middle border-2 border-slate-500 rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
        <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
          <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
            Create new live stream
          </h1>
          <form class="space-y-4 md:space-y-6" action="#">
            <div className="flex gap-6">
              <div>
                <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                  Stream Title
                </label>
                <input
                  type="text"
                  name="Title"
                  id="Title"
                  class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                  placeholder="Enter Title of your Stream"
                  required=""
                ></input>
              </div>
              <div>
                <label
                  for="course"
                  class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                >
                  Course
                </label>
                <select
                  className="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                  name="course"
                  id="course"
                >
                  <option value="select">---select---</option>
                  <option value="course1">Dialogues</option>
                  <option value="course2">Expressions</option>
                  <option value="course3">Memorization</option>
                  <option value="course4">Salemanship</option>
                  <option value="course5">Teamwork</option>
                  <option value="course6">Improv</option>
                  <option value="course7">Communication</option>
                  <option value="course8">Innovation</option>
                  <option value="course9">Interveiw Prep</option>
                </select>
              </div>
            </div>
            <div>
              <label
                for="camera"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >
                Camera
              </label>
              <select
                className="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                name="camera"
                id="camera"
              >
                <option value="camera1">HP Webcam</option>
                <option value="camera1">Internal Camera</option>
              </select>
            </div>
            <div>
              <label
                for="mic"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >
                Microphone
              </label>
              <select
                className="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                name="mic"
                id="mic"
              >
                <option value="mic1">Realtek Audio</option>
                <option value="mic2">Shure</option>
              </select>
            </div>
            <div class="flex items-start">
              <div class="flex items-center h-5">
                <input
                  id="terms"
                  aria-describedby="terms"
                  type="checkbox"
                  class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800"
                  required=""
                ></input>
              </div>
              <div class="ml-3 text-sm">
                <label
                  for="terms"
                  class="font-light text-gray-500 dark:text-gray-300"
                >
                  I accept the{" "}
                  <a
                    class="font-medium text-primary-600 hover:underline dark:text-primary-500"
                    href="#"
                  >
                    Terms and Conditions
                  </a>
                </label>
              </div>
            </div>
            <button
              type="submit"
              class="w-full text-white bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
            >
              Start Stream
            </button>
          </form>
        </div>
      </div>
    </div>
  );
}
