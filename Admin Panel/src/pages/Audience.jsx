import React, { useEffect, useState } from 'react'
import { Avatar, List, Form, Input, Select, Modal, message, Progress } from 'antd';
import { Button, Row, Col, Upload } from 'antd';
import { UploadOutlined } from '@ant-design/icons';
import { FaPlus } from 'react-icons/fa';
import { useForm } from 'antd/es/form/Form';
import axios from 'axios';

const { Option } = Select;



const Audience = () => {
    const API_URL = process.env.REACT_APP_API_URL;

    const [form] = useForm();
    const [visible, setVisible] = useState(false);
    const [isCreating, setIsCreating] = useState(true);
    const [uploadProgress, setUploadProgress] = useState(0);
    const [currentItemId, setCurrentItemId] = useState(null);


    const [data, setData] = useState([]);

    const handleEdit = (itemId) => {
        const currentItem = data.find((item) => item._id === itemId);
        form.setFieldsValue({
            title: currentItem.title,
            description: currentItem.description,
            source: currentItem.source,
            category: currentItem.category,
            location: currentItem.location,
            email: currentItem.email,
            whatsAppNumber: currentItem.whatsAppNumber,
            image: {
                file: null,
                originFileObj: {
                    uid: currentItem._id, // Use a unique identifier for the image field
                    name: currentItem.imageUrl, // Use the current image URL as the name
                    status: 'done',
                    url: `${API_URL}/${currentItem.imageUrl}`, // Use the current image URL as the URL
                },
            }, // Clear the image field
        });
        setCurrentItemId(itemId); // Set the current item ID
        setIsCreating(false);
        setVisible(true);
    };


    const fetchListings = async () => {
        try {
            const response = await axios.get(`${API_URL}/openings`);
            setData(response.data);
        } catch (error) {
            console.error('Error fetching debates:', error);
        }
    }
    useEffect(() => {
        fetchListings();
    }, [])

    const handleCancel = () => {
        form.resetFields()
        setVisible(false);

    };
    const handleDelete = async (planId) => {
        try {
            const response = await axios.delete(`${API_URL}/opening/${planId}`);
            if (response.status === 200) {
                message.success("Listing deleted successfully");
                setVisible(false);
                fetchListings();
            } else {
                message.error('Failed to delete listing');
                setVisible(false);


            }
        } catch (e) {
            message.error("Error deleting listing:", e);
            setVisible(false);

        }
    }

    const onFinish = async (values) => {
        form.resetFields();
        try {
            const { title, description, source, category, location, image, email, whatsAppNumber } = values;
            const { file } = image;
            const formData = new FormData();
            formData.append('title', title);
            formData.append('description', description);
            formData.append('source', source);
            formData.append('category', category);
            formData.append('location', location);
            formData.append('email', email);
            formData.append('whatsAppNumber', whatsAppNumber);
            if (file) {
                formData.append('image', file.originFileObj);
            }

            let response;
            if (isCreating) {
                // Create a new item
                response = await axios.post(`${API_URL}/opening`, formData, {
                    onUploadProgress: (progressEvent) => {
                        const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                        console.log('Upload progress:', percentCompleted);
                        setUploadProgress(percentCompleted);
                    },
                });
            } else {
                // Update an existing item
                response = await axios.put(`${API_URL}/opening/${currentItemId}`, formData, {
                    onUploadProgress: (progressEvent) => {
                        const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                        console.log('Upload progress:', percentCompleted);
                        setUploadProgress(percentCompleted);
                    },
                });
            }

            if (response.status === 200) {
                message.success(isCreating ? 'Added successfully' : 'Updated successfully');
                setVisible(false);
                fetchListings();
            } else {
                message.error(isCreating ? 'Failed to add' : 'Failed to update');
                setVisible(false);
            }
        } catch (error) {
            console.error('Error:', error);
            message.error(isCreating ? 'Failed to add' : 'Failed to update');
            setVisible(false);
        }
    };

    return (
        <div className='p-5'>
            <Row justify={'space-between'} align={'center'}>
                <p className='text-lg font-semibold'>Audience</p>
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
                            // <Button
                            //     className='bg-blue-400 rounded-lg text-white hover:text-white active:text-white'
                            //     key="list-edit"
                            //     onClick={() => handleEdit(item._id)}
                            // >
                            //     Edit
                            // </Button>,
                            <Button
                                className='bg-blue-400 rounded-lg text-white hover:text-white'
                                key="list-delete"
                                onClick={() => handleEdit(item._id)}
                            >
                                Edit
                            </Button>,
                            <Button
                                className='bg-red-400 rounded-lg text-white hover:text-white'
                                key="list-delete"
                                onClick={() => handleDelete(item._id)}
                            >
                                Delete
                            </Button>,
                        ]}
                        className="border shadow-sm rounded-lg border-gray-200 py-4 m-2"
                    >
                        <List.Item.Meta
                            avatar={<img className='h-24 w-36 object-cover' src={`${API_URL}/${item.imageUrl}`} alt={item.title} />}
                            title={item.title}
                            description={item.description}
                            className="flex items-center"
                        />
                        <div className="ml-auto text-right">
                            <p className="text-gray-500">Source: {item.source}</p>
                            <p className="text-gray-500">Category: {item.category}</p>
                            <p className="text-gray-500">Location: {item.location}</p>
                            <p className="text-gray-500">Email: {item.email}</p>
                            <p className="text-gray-500">WhatsApp Number: {item.whatsAppNumber}</p>
                        </div>
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
                <Form form={form} onFinish={onFinish} layout="vertical" initialValues={{ category: 'TV' }}>
                    <Form.Item label="Title"
                        name="title"
                        rules={[{ required: true, message: 'Please input the title!' }]}>
                        <Input />
                    </Form.Item>
                    <Form.Item label="Description"
                        name="description"
                        rules={[{ required: true, message: 'Please input the description!' }]}>
                        <Input />
                    </Form.Item>
                    <Form.Item label="Source"
                        name="source"
                        rules={[{ required: true, message: 'Please input the source!' }]}>
                        <Input placeholder='TT IN HOUSE' />
                    </Form.Item>
                    <Form.Item label="Category"
                        name="category"
                        rules={[{ required: true, message: 'Please select the category!' }]}>
                        <Select>
                            <Option default value="tv">TV SHOW</Option>
                            <Option value="web">WEB/MOVIE</Option>
                            <Option value="ads">AD SHOOTS</Option>
                        </Select>
                    </Form.Item>
                    <Form.Item label="Location"
                        name="location"
                        rules={[{ required: true, message: 'Please enter the location' }]}>
                        <Input />

                    </Form.Item>
                    <Form.Item label="Email"
                        name="email"
                        rules={[{ required: true, message: 'Please enter the email !' }]}>
                        <Input type='email' />

                    </Form.Item>
                    <Form.Item label="WhatsApp Number"
                        name="whatsAppNumber"
                        rules={[{ required: true, message: 'Please enter the whatsapp number !' }]}>
                        <Input type='number' />

                    </Form.Item>
                    <Form.Item label="Image"
                        name="image"
                        rules={[{ required: true, message: 'Please select the image file!' }]}>
                        <Upload accept="image/*">
                            <Button>Choose File</Button>
                        </Upload>
                    </Form.Item>
                    {uploadProgress > 0 && <Progress percent={uploadProgress} />}

                </Form>
            </Modal>



        </div>
    );
}

export default Audience