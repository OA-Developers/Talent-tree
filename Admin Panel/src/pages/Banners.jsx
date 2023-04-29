import React, { useState } from 'react'
import { Avatar, List, Form, Input, Select, Modal, message } from 'antd';
import { Button, Row, Col, Upload } from 'antd';
import { UploadOutlined } from '@ant-design/icons';
import { FaPlus } from 'react-icons/fa';
import { useForm } from 'antd/es/form/Form';
import axios from 'axios';

const { Option } = Select;

const data = [
    {
        key: '1',
        title: 'Opening',
        category: 'TV',
        description: 'Demo Description',
    },
    {
        key: '2',
        name: 'John Doe',
        description: 'Demo Descriotion',
        category: 'Ads',
    },
    {
        key: '3',
        title: 'Opening',
        description: 'Demo Descriotion',
        category: 'Web',
    },
    {
        key: '4',
        title: 'Opening',
        description: 'Demo Descriotion',
        category: 'Movies',
    },
];

const Banners = () => {

    const [form] = useForm();
    const [visible, setVisible] = useState(false);
    const [isCreating, setIsCreating] = useState(true);

    const handleEdit = () => {
        setVisible(true);
    };

    const handleCancel = () => {
        form.resetFields()
        setVisible(false);

    };

    const onFinish = async (values) => {
        // Handle According to isCreating 
        const { title, type, media } = values;
        const { file } = media;

        console.log(file.originFileObj);

        const formData = new FormData();
        formData.append('title', title);
        formData.append('type', type);
        formData.append('file', file.originFileObj);

        try {
            const response = await axios.post('http://localhost:8000/upload', formData);
            console.log('Form submission successful:', response);
        } catch (error) {
            console.error('Error submitting form:', error);
        }
        setVisible(false);
        form.resetFields();
    };

    return (
        <div className='p-5'>
            <Row justify={'space-between'} align={'center'}>
                <p className='text-lg font-semibold'>Banners</p>
                <div onClick={() => {
                    setIsCreating(true);
                    setVisible(true);

                }} className='py-2 px-3 bg-red-600 flex justify-center items-center rounded-lg gap-1 text-white cursor-pointer'>
                    <FaPlus />
                    Create
                </div>
            </Row>
            <List
                itemLayout='horizontal'
                className='p-5'
                dataSource={data}
                renderItem={(item) => (
                    <List.Item
                        actions={[
                            <button
                                className='py-2 px-3 border border-red-500 flex justify-center items-center rounded-lg gap-1 text-gray-500 cursor-pointer'
                                key='list-loadmore-more'
                            >
                                Delete
                            </button>,
                        ]}
                    >
                        <List.Item.Meta
                            avatar={
                                <img className='h-24 w-36 object-cover'
                                    src={`https://picsum.photos/500/150`}
                                />
                            }
                            title={<a href='https://ant.design'>{item.title}</a>}
                            description='Image'
                        />
                    </List.Item>
                )}
            />
            <Modal
                title={isCreating ? "Add a Item" : "Edit Item"}
                onCancel={handleCancel}
                onOk={() => form.submit()}
                // confirmLoading={loading}
                visible={visible}
                okText="Save"
                okButtonProps={{ style: { backgroundColor: '#00BFFF' } }}
                cancelText="Cancel"
            >
                <Form onFinish={onFinish} form={form} layout="vertical" initialValues={{ category: 'TV' }}>
                    <Form.Item
                        label="Title"
                        name="title"
                        rules={[{ required: true, message: 'Please enter a title!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        label="Type"
                        name="type"
                        rules={[{ required: true, message: 'Please select a category!' }]}
                    >
                        <Select>
                            <Option value="image">Image</Option>
                            <Option value="video">Video</Option>
                        </Select>
                    </Form.Item>

                    <Form.Item label="Media" name="media">
                        <Upload accept="video/*,image/*">
                            <Button icon={<UploadOutlined />}>Upload Media File</Button>
                        </Upload>
                    </Form.Item>

                </Form>
            </Modal>



        </div>
    );
}

export default Banners