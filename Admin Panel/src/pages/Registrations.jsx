import React, { useEffect, useState } from 'react';
import { Table, Input, Select, Button, Modal, Space, message } from 'antd';
import './css/RegistrationPage.css';
import axios from 'axios';

const { Option } = Select;
const API_URL = process.env.REACT_APP_API_URL;

const RegistrationPage = () => {
    const [registrations, setRegistrations] = useState([
        {
            _id: "645e887919e5e3f600562a1a",
            userId: "645799b1bb2f446df8788871",
            fullName: "Demo Demo",
            gender: "male",
            email: "demo@mail.com",
            mobile: "79XXXXXXX",
            mobileAlt: "79XXXXXXX",
            dob: "12 December",
            state: "Demo",
            district: "Demo",
            city: "Demo",
            currentCity: "Demo",
            height: "5'8",
            experience: "",
            __v: 0,
        },
        // Add more registrations here
    ]);

    const fetchUsers = async () => {
        try {
            const data = await axios.get(`${API_URL}/getAllRegistrations`);
            if (data.data.registrations) {
                console.log(data);
                setRegistrations(data.data.registrations);

            } else {
                message.error("Failed to fetch registrations");
            }
        } catch (e) {
            console.log(e);
            message.error("Failed to fetch registrations");
        }
    }
    useEffect(() => { fetchUsers() }, [])

    const [filterOptions, setFilterOptions] = useState({
        type: '',
        value: '',
    });

    const [modalVisible, setModalVisible] = useState(false);
    const [selectedData, setSelectedData] = useState(null);

    const handleFilterChange = (name, value) => {
        setFilterOptions((prevFilterOptions) => ({
            ...prevFilterOptions,
            [name]: value,
        }));
    };

    const filteredData = registrations.filter((registration) => {
        const { type, value } = filterOptions;

        if (type && value) {
            // Apply filters
            if (type === 'gender' && registration.gender !== value) {
                return false;
            }
            if (type === 'city' && registration.city !== value) {
                return false;
            }
            if (type === 'state' && registration.state !== value) {
                return false;
            }
            if (type === 'dob' && registration.dob !== value) {
                return false;
            }
        }

        return true;
    });

    const columns = [
        {
            title: 'Name',
            dataIndex: 'fullName',
            key: 'fullName',
        },
        {
            title: 'Email',
            dataIndex: 'email',
            key: 'email',
        },
        {
            title: 'Gender',
            dataIndex: 'gender',
            key: 'gender',
        },
        {
            title: 'DOB',
            dataIndex: 'dob',
            key: 'dob',
        },
        {
            title: 'State',
            dataIndex: 'state',
            key: 'state',
        },
        {
            title: 'City',
            dataIndex: 'city',
            key: 'city',
        },
        {
            title: 'Actions',
            key: 'actions',
            render: (_, record) => (
                <Button onClick={() => handleView(record)}>View</Button>
            ),
        },
    ];

    const handleView = (record) => {
        setSelectedData(record);
        setModalVisible(true);
    };

    const closeModal = () => {
        setSelectedData(null);
        setModalVisible(false);
    };

    return (
        <div className="registration-page">
            <h1 className="page-title">Registration Page</h1>
            <div className="filter-container">
                <Space>
                    <Select
                        value={filterOptions.type}
                        // size=''
                        style={{ width: "200px" }}
                        onChange={(value) => handleFilterChange('type', value)}
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
                        onChange={(e) => handleFilterChange('value', e.target.value)}
                    />
                </Space>
            </div>
            <Table dataSource={filteredData} columns={columns} />
            <Modal
                title="Registration Details"
                visible={modalVisible}
                onCancel={closeModal}
                footer={null}
            >
                {selectedData && (
                    <div>
                        {Object.entries(selectedData).map(([key, value]) => (
                            <p key={key}>
                                {key}: {value}
                            </p>
                        ))}
                    </div>
                )}
            </Modal>
        </div>
    );
};

export default RegistrationPage;
