import React, { useEffect, useState } from "react";
import { PlusOutlined } from '@ant-design/icons';
import { Link } from "react-router-dom";
import axios from 'axios';
import { Card, Row, Col, Modal, Form, Input, Upload, Button, message, Select, Typography, Progress } from 'antd';
import { useForm } from 'antd/es/form/Form';
import { FiDelete } from "react-icons/fi";
import { MdDelete } from "react-icons/md";
const { Meta } = Card;
const { TextArea } = Input;
const { Option } = Select;

export default function Subscription() {

  const [plans, setPlans] = useState([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const API_URL = process.env.REACT_APP_API_URL;

  const [form] = useForm();

  const fetchPlans = async () => {
    try {
      const response = await axios.get(`${API_URL}/plans`);
      console.log(response.data);
      setPlans(response.data);
    } catch (e) {
      message.info("Error fetching plans:", e);
    }
  }
  useEffect(() => {
    fetchPlans();
  }, [])


  const handleCancel = () => {
    setIsModalVisible(false);
    form.resetFields()
  };

  function convertDays(numDays) {
    let years = Math.floor(numDays / 365);
    let remainingDays = numDays % 365;
    let months = Math.floor(remainingDays / 30);
    remainingDays %= 30;
    let output = '';
    if (years > 0) {
      output += `${years} year${years > 1 ? 's' : ''}`;
    }
    if (months > 0) {
      if (years > 0) {
        output += ' ';
      }
      output += `${months} month${months > 1 ? 's' : ''}`;
    }
    if (remainingDays > 0) {
      if (years > 0 || months > 0) {
        output += ' ';
      }
      output += `${remainingDays} day${remainingDays > 1 ? 's' : ''}`;
    }
    return output;
  }


  const handleDeletePlan = async (planId) => {
    try {
      const response = await axios.delete(`${API_URL}/plans/${planId}`);
      if (response.status === 200) {
        message.success("Plan deleted successfully");
        setIsModalVisible(false);

        fetchPlans();
      } else {
        message.error('Failed to delete plan');
        setIsModalVisible(false);

      }
    } catch (e) {
      message.error("Error deleting plan:", e);
      setIsModalVisible(false);

    }
  }


  const handleCreatePlan = async (values) => {

    try {

      const { price, duration } = values;
      const response = await axios.post(`${API_URL}/plans`, { price, duration });
      if (response.status === 200) {
        message.success("Plan created successfully");
        fetchPlans();
      } else {
        message.error('Failed to create plan');
        form.resetFields()
      }
    } catch (e) {
      message.error("Error creating plan:", e);
      message.error('Failed to create plan');

    }
  }
  const onFinishFailed = (errorInfo) => {
    console.log('Failed:', errorInfo);
  };
  return (
    <div div className='flex flex-col justify-center gap-5 m-5' >
      <Row>

        <Col xs={24} sm={12} md={8} lg={6}>
          <div
            className='h-[200px] w-[350px] border border-gray-300 rounded-md flex flex-col gap-2 justify-center items-center'
            style={{ textAlign: 'center' }}
            onClick={() => setIsModalVisible(true)}
          >
            <PlusOutlined style={{ fontSize: '48px' }} />
            <p>Create New Plan</p>
          </div>
        </Col>
      </Row>
      <div>

        <Typography.Title className='font-serif' level={4}>Subscription Plans</Typography.Title>
        <Row gutter={[8, 8]}>

          {plans.map((plan) => (
            <Col key={plan.title} xs={24} sm={12} md={8} lg={6}>
              <Card
                className='h-52 w-60 border flex flex-col text-center items-center p-5 bg-blue-600 border-gray-300 gap-5  relative rounded-md overflow-hidden'
              >
                <div type="text" className="absolute top-2 text-red-600 text-xl bg-white cursor-pointer rounded-full right-2" onClick={() => handleDeletePlan(plan._id)}><MdDelete /></div>
                <div className='text-2xl text-white font-serif font-semibold'>{convertDays(plan.duration)}</div>
                <div className='text-xl font-serif font-semibold text-white'>₹{plan.price}</div>
              </Card>
            </Col>

          ))}
        </Row>
      </div>
      <Modal
        title="Create New Plan"
        visible={isModalVisible}
        onCancel={handleCancel}
        onOk={() => form.submit()}
        okText="Upload"
        okButtonProps={{ style: { backgroundColor: '#00BFFF' } }}
        cancelText="Cancel"
      >
        <Form
          name="Create a Plan"
          onFinish={handleCreatePlan}
          form={form}
          onFinishFailed={onFinishFailed}
        >
          <Form.Item
            label="Price"
            name="price"
            rules={[{ required: true, message: 'Please input the price!' }]}
          >
            <Input />
          </Form.Item>
          <Form.Item
            label="Duration"
            name="duration"
            rules={[
              { required: true, message: 'Please enter the duration!' },
            ]}
          >
            <Input type="number" placeholder="Duration (In Days)" />
          </Form.Item>
        </Form>
      </Modal>
    </div >
  );
}
