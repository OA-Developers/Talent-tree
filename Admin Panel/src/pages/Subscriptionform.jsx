import React from "react";

export default function Subscriptionform() {
  return (
      <div className="flex justify-center w-full ">
        <div class="flex h-fit justify-center align-middle border-2 border-slate-500 rounded-lg shadow  md:mt-0 sm:max-w-md xl:p-0">
          <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
            <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl ">
              Make a new Course
            </h1>
            <form class="space-y-4 md:space-y-6" action="#">
              <div className="flex gap-6">
              <div>
                <label
                  
                  class="block mb-2 text-sm font-medium text-gray-900 "
                >
                  Course Name
                </label>
                <input
                  type="text"
                  name="course"
                  id="course"
                  class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5"
                  placeholder="Enter Course name"
                  required
                ></input>
              </div>
              <div>
                <label
                  class="block mb-2 text-sm font-medium text-gray-900 "
                >
                  Slots
                </label>
                <input
                  type="number"
                  name="slot"
                  id="slot"
                  placeholder="Total number of seats"
                  class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5"
                  required
                ></input>
              </div>
              </div>
              <div>
                <label
                 
                  class="block mb-2 text-sm font-medium text-gray-900 "
                >
                  Ammount
                </label>
                <input
                  type="number"
                  name="ammount"
                  id="ammount"
                  placeholder="in rupees"
                  class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5"
                  required
                ></input>
              </div>
              <div>
                <label
                  class="block mb-2 text-sm font-medium text-gray-900 "
                >
                  Timing
                </label>
                <input
                  type="time"
                  name="time"
                  id="time"
                  class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5"
                  required
                ></input>
              </div>
              <div class="flex items-start">
                <div class="flex items-center h-5">
                  <input
                    id="terms"
                    aria-describedby="terms"
                    type="checkbox"
                    class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300"
                    required
                  ></input>
                </div>
                <div class="ml-3 text-sm">
                  <label
                    for="terms"
                    class="font-light text-gray-500"
                  >
                    I accept the{" "}
                    <a
                      class="font-medium text-primary-600 hover:underline "
                      href="#"
                    >
                      Terms and Conditions
                    </a>
                  </label>
                </div>
              </div>
              <button
                type="submit"
                class="w-full  bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center  text-black"
              >
                Create
              </button>
             
            </form>
          </div>
        </div>
      </div>
  );
}
