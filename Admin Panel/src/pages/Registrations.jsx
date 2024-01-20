import React, { useEffect, useState } from "react";
import { Table, Input, Select, Button, Modal, Space, message } from "antd";
import "./css/RegistrationPage.css";
import axios from "axios";
import * as XLSX from 'xlsx';

const { Option } = Select;
const API_URL = process.env.REACT_APP_API_URL;

const RegistrationPage = () => {
  const [registrations, setRegistrations] = useState([]);
  const [filteredData, setFilteredData] = useState([]);
  const [filterOptions, setFilterOptions] = useState({
    type: "",
    value: "",
  });
  useEffect(() => {
    setFilteredData(registrations);
  }, [registrations]);

  const fetchUsers = async () => {
    try {
      const data = await axios.get(`${API_URL}/getAllRegistrations`);
      if (data.data.registrations) {
        setRegistrations(data.data.registrations);
      } else {
        message.error("Failed to fetch registrations");
      }
    } catch (e) {
      console.log(e);
      message.error("Failed to fetch registrations");
    }
  };
  const exportAllRegistration = async () => {
    try {
      const data = await axios.get(`${API_URL}/exportRegistrations`);
      const ws = XLSX.utils.json_to_sheet(data);
      const wb = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(wb, ws, "Sheet1");
      XLSX.writeFile(wb, "output.xlsx");
    } catch (e) {
      console.log(e);
      message.error("Failed to fetch registrations");
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  useEffect(() => {
    applyFilter();
  }, [filterOptions]);

  const handleFilterChange = (name, value) => {
    setFilterOptions((prevFilterOptions) => ({
      ...prevFilterOptions,
      [name]: value,
    }));
  };

  const applyFilter = () => {
    const { type, value } = filterOptions;

    if (type && value) {
      const lowerCaseValue = value.toLowerCase();

      const filteredRegistrations = registrations.filter((registration) => {
        const lowerCaseRegistrationValue = registration[type].toLowerCase();

        return lowerCaseRegistrationValue.includes(lowerCaseValue);
      });

      setFilteredData(filteredRegistrations);
    } else {
      setFilteredData(registrations);
    }
  };

  const columns = [
    {
      title: "Name",
      dataIndex: "fullName",
      key: "fullName",
    },
    {
      title: "Email",
      dataIndex: "email",
      key: "email",
    },
    {
      title: "Gender",
      dataIndex: "gender",
      key: "gender",
    },
    {
      title: "DOB",
      dataIndex: "dob",
      key: "dob",
    },
    {
      title: "State",
      dataIndex: "state",
      key: "state",
    },
    {
      title: "City",
      dataIndex: "city",
      key: "city",
    },
    {
      title: "Actions",
      key: "actions",
      render: (_, record) => (
        <Button onClick={() => handleView(record)}>View</Button>
      ),
    },
  ];

  const handleView = (record) => {
    Modal.info({
      title: "Registration Details",
      content: (
        <div>
          {Object.entries(record).map(([key, value]) => (
            <p key={key}>
              {key}: {value}
            </p>
          ))}
        </div>
      ),
    });
  };

  return (
    <div className="registration-page">
      <h1 className="page-title">Registration Page</h1>
      <div className="filter-container">
        <Space>
          <Select
            value={filterOptions.type}
            style={{ width: "200px" }}
            onChange={(value) => handleFilterChange("type", value)}
          >
            <Option value="">Select Filter Type</Option>
            <Option value="gender">Gender</Option>
            <Option value="city">City</Option>
            <Option value="state">State</Option>
            <Option value="dob">DOB</Option>
          </Select>
          <Input
            placeholder="Enter filter value"
            value={filterOptions.value}
            onChange={(e) => handleFilterChange("value", e.target.value)}
          />
          <Button onClick={applyFilter}>Search</Button>
          <Button className="text-white bg-red-500" onClick={exportAllRegistration}>
            Export Data
          </Button>
        </Space>
      </div>
      <Table dataSource={filteredData} columns={columns} />
    </div>
  );
};

export default RegistrationPage;
