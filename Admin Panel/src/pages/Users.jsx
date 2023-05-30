import React, { useEffect, useState } from 'react'
import { Avatar, List, message } from 'antd';
import { Table, Input, Space, Button, Modal, Colu } from 'antd';
import { SearchOutlined, ExclamationCircleOutlined, UserOutlined } from '@ant-design/icons';
import axios from "axios";
import logo from "../assets/logo.png"


const API_URL = process.env.REACT_APP_API_URL;


export default function Users() {
  const [users, setUsers] = useState([]);
  const [isVisible, setIsVisible] = useState(false);
  const [regData, setRegData] = useState({})

  const fetchUsers = async () => {
    try {
      const data = await axios.get(`${API_URL}/getAllUsers`);
      if (users) {
        console.log(data);
        setUsers(data.data.users);

      } else {
        message.error("Failed to fetch users");
      }
    } catch (e) {
      console.log(e);
      message.error("Failed to fetch users");
    }
  }
  const showRegistration = async (id) => {
    try {
      const data = await axios.get(`${API_URL}/getUserRegistration?userId=${id}`);
      if (users) {
        console.log(data);
        if (data.data.userRegistration.length > 0) {
          console.log(Object.keys(data.data.userRegistration[0]))
          setRegData(data.data.userRegistration[0]);
          setIsVisible(true);
        } else {
          message.info("User not registered!")
        }

      } else {
        message.error("Failed to fetch users");
      }
    } catch (e) {
      console.log(e);
      message.error("Failed to fetch users");
    }
  }
  useEffect(() => {
    fetchUsers();
  }, [])
  const handleCancel = () => {
    setIsVisible(false);

  };
  return (
    <div className='p-5'>
      <Table dataSource={users}>
        <Table.Column dataIndex="logo" key="logo" render={(c, record) => {
          return (

            <Avatar src={record.profileImage ? `${API_URL}/files${record.profileImage}` : logo} />
          )
        }
        }
        />
        <Table.Column title="Name" dataIndex="name" key="name" />
        <Table.Column title="Email" dataIndex="email" key="age" />
        {/* <Table.Column title="Address" dataIndex="address" key="address" /> */}
        <Table.Column
          title="Registration"
          key="registration"
          render={(text, record) => (
            <Space size="middle">
              <Button className='bg-red-500 text-white font-semibold' type="danger" onClick={() => showRegistration(record._id)}>
                View
              </Button>
            </Space>
          )}
        />
      </Table>
      <Modal
        title={"Registration Info"}
        onCancel={handleCancel}
        onOk={() => setIsVisible(false)}
        // confirmLoading={loading}
        open={isVisible}
        okText="Ok"
        okButtonProps={{ style: { backgroundColor: '#00BFFF' } }}
        cancelText="Cancel"
      >
        <div>
          <ul>
            {regData && Object.keys(regData).map((key) => (
              <li>{key} : {regData[key]}</li>
            ))}
          </ul>
        </div>
      </Modal >

    </div >
  )
}
