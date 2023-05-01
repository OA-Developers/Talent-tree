import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Form, Input, Button, message } from 'antd';
import { UserOutlined, LockOutlined } from '@ant-design/icons';
import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL;

export default function Login() {
    const navigate = useNavigate();
    const onFinish = (values) => {
        axios.post(`${API_URL}/admin/login`, values)
            .then((response) => {
                localStorage.setItem('user', response.data.token);
                navigate("/")
            })
            .catch((error) => {
                console.log(error);
                message.error(error.response.data.msg)
            });
    };

    return (
        <section className="bg-white dark:bg-gray-900">
            <div className="container flex items-center justify-center min-h-screen px-6 mx-auto">
                <Form
                    name="login"
                    className="w-full max-w-md"
                    onFinish={onFinish}
                >
                    <img className="w-auto h-7 sm:h-8" src="https://merakiui.com/images/logo.svg" alt=""></img>

                    <h1 className="my-3 text-2xl font-semibold text-gray-800 capitalize sm:text-3xl dark:text-white">sign In</h1>

                    <Form.Item
                        name="email"
                        rules={[
                            {
                                type: 'email',
                                message: 'The input is not a valid email!',
                            },
                            {
                                required: true,
                                message: 'Please input your email!',
                            },
                        ]}
                    >
                        <Input prefix={<UserOutlined />} placeholder="Email address" />
                    </Form.Item>

                    <Form.Item
                        name="password"
                        rules={[
                            {
                                required: true,
                                message: 'Please input your password!',
                            },
                        ]}
                    >
                        <Input.Password prefix={<LockOutlined />} placeholder="Password" />
                    </Form.Item>

                    <Form.Item>
                        <Button type="primary" htmlType="submit" className="w-full bg-blue-600">
                            Sign In
                        </Button>
                    </Form.Item>
                </Form>
            </div>
        </section>
    );
}