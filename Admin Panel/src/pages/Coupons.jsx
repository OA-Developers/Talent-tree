
import React, { useEffect, useState } from "react";
import { PlusOutlined } from '@ant-design/icons';
import { Link } from "react-router-dom";
import axios from 'axios';
import { Card, Row, Col, Modal, Form, Input, Upload, Button, message, Select, Typography, Progress, DatePicker } from 'antd';
import { useForm } from 'antd/es/form/Form';
import { FiDelete } from "react-icons/fi";
import { MdDelete } from "react-icons/md";
import moment from "moment/moment";

export default function Coupons() {

  const [coupons, setCoupons] = useState([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const API_URL = process.env.REACT_APP_API_URL;
  const [form] = useForm();

  const handleCancel = () => {
    setIsModalVisible(false);
    form.resetFields()
  };

  const fetchCoupons = async () => {
    try {
      const response = await axios.get(`${API_URL}/coupons`);
      console.log(response.data);
      setCoupons(response.data);
    } catch (e) {
      message.info("Error fetching coupons:", e);
    }
  }
  useEffect(() => {
    fetchCoupons();
  }, [])
  const handleCreateCoupon = async (values) => {

    try {

      const { code, expiry, discount } = values;
      const response = await axios.post(`${API_URL}/coupons`, { code, expiry, discount });
      if (response.status === 200) {
        message.success("Plan created successfully");
        fetchCoupons();
        setIsModalVisible(false);
        form.resetFields()

      } else {
        message.error('Failed to create plan');
        form.resetFields()
        setIsModalVisible(false);
        form.resetFields()

      }
    } catch (e) {
      message.error("Error creating plan:", e);
      message.error('Failed to create plan');
      setIsModalVisible(false);
      form.resetFields()

    }
  }
  const handleDeleteCoupon = async (couponId) => {
    try {
      const response = await axios.delete(`${API_URL}/coupons/${couponId}`);
      if (response.status === 200) {
        message.success("Coupon deleted successfully");
        setIsModalVisible(false);

        fetchCoupons();
      } else {
        message.error('Failed to delete coupon');
        setIsModalVisible(false);

      }
    } catch (e) {
      message.error("Error deleting coupon:", e);
      setIsModalVisible(false);

    }
  }
  const onFinishFailed = (errorInfo) => {
    console.log('Failed:', errorInfo);
  };



  return (
    <div className="flex flex-col justify-center gap-5 m-5">
      <Row>

        <Col xs={24} sm={12} md={8} lg={6}>
          <div
            className='h-[200px] w-[350px] border border-gray-300 rounded-md flex flex-col gap-2 justify-center items-center'
            style={{ textAlign: 'center' }}
            onClick={() => setIsModalVisible(true)}
          >
            <PlusOutlined style={{ fontSize: '48px' }} />
            <p>Create New Coupon</p>
          </div>
        </Col>
      </Row>
      <div>

        <Typography.Title className='font-serif' level={4}>Coupons</Typography.Title>
        <Row gutter={[8, 8]}>
          {coupons.map((coupon) => (
            <Col key={coupon._id} xs={24} sm={12} md={8} lg={6}>
              <Card className='h-52 w-60 border flex flex-col text-center items-center p-5 bg-blue-600 border-gray-300 gap-8 relative rounded-md overflow-hidden'>
                <div className='absolute top-2 right-2'>
                </div>
                <div
                  type='text'
                  className='absolute top-2 text-red-600 text-xl bg-white cursor-pointer rounded-full left-2'
                  onClick={() => handleDeleteCoupon(coupon._id)}
                >
                  <MdDelete />
                </div>
                <div className='text-xl font-serif font-semibold text-white'>{coupon.discount}%</div>
                <div className='text-2xl text-white font-serif font-semibold'>{coupon.code}</div>
                <div className='text-md font-serif font-semibold text-white'>
                  {coupon.expiry}
                </div>
              </Card>
            </Col>
          ))}
        </Row>
      </div>
      <Modal
        title="Create New Coupon"
        visible={isModalVisible}
        onCancel={handleCancel}
        onOk={() => form.submit()}
        okText="Upload"
        okButtonProps={{ style: { backgroundColor: '#00BFFF' } }}
        cancelText="Cancel"
      >
        <Form
          name="Create a Coupon"
          onFinish={handleCreateCoupon}
          form={form}
          onFinishFailed={onFinishFailed}
        >
          <Form.Item
            label="Code"
            name="code"
            rules={[{ required: true, message: 'Please input the price!' }]}
          >
            <Input />
          </Form.Item>
          <Form.Item
            label="Expiry"
            name="expiry"
            rules={[{ required: true, message: 'Please input the mrp!' }]}
          >
            <DatePicker placeholder="Select expiry date" format="DD/MM/YYYY" disabledDate={(current) => current && current < moment().startOf('day')} />
          </Form.Item>
          <Form.Item
            label="Discount(%)"
            name="discount"
            rules={[
              { required: true, message: 'Please enter the discount!' },
            ]}
          >
            <Input suffix="%" type="number" placeholder="Discount (Percentage)" />
          </Form.Item>
        </Form>
      </Modal>

    </div>
  );
}
