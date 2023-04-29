import React from "react";
import { Link } from "react-router-dom";
import img from "../assets/download.jpeg";
import { Card, Statistic, Row, Col, Typography, } from 'antd';
import { UserOutlined, PictureOutlined, VideoCameraOutlined, TransactionOutlined, } from '@ant-design/icons';
import { FiPackage, } from "react-icons/fi"
import { FaImage, FaVideo } from "react-icons/fa";


export default function Dashboard() {
  return (
    <div className="parent flex flex-col p-10">
      <Typography.Title className="text-gray-500" level={4}>Home Screen</Typography.Title>

      <Row gutter={16} className="m-2">
        <Col span={12}>
          <Link to="/banners" className="bg-[#0059ffb4] cursor-pointer flex flex-col rounded-md shadow-md py-10 px-12 text-white text-xl items-center justify-center">
            <FaImage size={30} />
            Images
          </Link>
        </Col>
        <Col span={12}>
          <Link to="/banners" className="bg-[#0e0e0eb5] cursor-pointer flex flex-col rounded-md shadow-md py-10 px-12 text-white text-xl items-center justify-center">
            <FaVideo size={30} />
            Videos
          </Link>
        </Col>
      </Row>
      <br />

      <Typography.Title level={4}>Statistics</Typography.Title>
      <Row gutter={[16, 16]} className="shadow-lg drop-shadow-xl p-5 cursor-pointer">
        <Col span={12}>
          <Statistic title="Users" value={5} prefix={<UserOutlined />} />
        </Col>
        <Col span={12}>
          <Statistic title="Debates" value={3} prefix={<VideoCameraOutlined />} />
        </Col>
        <Col span={12}>
          <Statistic title="Transactions" value={3} prefix={<TransactionOutlined />} />
        </Col>
        <Col span={12}>
          <Statistic title="Subscriptions" value={3} prefix={<FiPackage />} />
        </Col>
      </Row>




    </div>
  );
}
