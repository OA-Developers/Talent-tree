import React, { useEffect, useState } from 'react'
import { Avatar, List, Form, Input, Select, Modal, message, Progress, Popconfirm } from 'antd';
import { Button, Row, Col, Upload } from 'antd';
import { UploadOutlined } from '@ant-design/icons';
import { FaPlus } from 'react-icons/fa';
import { useForm } from 'antd/es/form/Form';
import axios from 'axios';

const { Option } = Select;





const Banners = () => {
    const API_URL = process.env.REACT_APP_API_URL;
    console.log(API_URL);

    const [form] = useForm();
    const [visible, setVisible] = useState(false);
    const [isCreating, setIsCreating] = useState(true);
    const [uploadProgress, setUploadProgress] = useState(0);
    const [banners, setBanners] = useState([]);

    useEffect(() => {
        const fetchBanners = async () => {
            try {
                const response = await axios.get(`${API_URL}/banners`);
                setBanners(response.data);
            } catch (error) {
                console.error('Error fetching banners:', error);
            }
        };

        fetchBanners();
    }, []);

    const handleDelete = async (id) => {
        try {
            await axios.delete(`${API_URL}/banner/${id}`);
            setBanners(banners.filter((banner) => banner._id !== id));
            message.success('Banner deleted successfully');
        } catch (error) {
            console.error('Error deleting banner:', error);
            message.error('Error deleting banner');
        }
    };




    const handleCancel = () => {
        form.resetFields()
        setVisible(false);

    };

    const onFinish = async (values) => {
        const { title, type, media } = values;
        const { file } = media;

        const formData = new FormData();
        formData.append('title', title);
        formData.append('type', type);
        formData.append('file', file.originFileObj);

        try {
            const response = await axios.post(`${API_URL}/banner/upload`, formData, {
                onUploadProgress: (progressEvent) => {
                    const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                    console.log('Upload progress:', percentCompleted);
                    setUploadProgress(percentCompleted);
                },
            });
            console.log('Form submission successful:', response);
            message.success('Banner uploaded successfully');
        } catch (error) {
            console.error('Error submitting form:', error);
            message.error('Error uploading banner');
        }

        setVisible(false);
        form.resetFields();
        setUploadProgress(0);
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
                dataSource={banners}
                renderItem={(item) => (
                    <List.Item
                        actions={[
                            <Popconfirm
                                title="Are you sure you want to delete this banner?"
                                onConfirm={() => handleDelete(item._id)}
                                okText="Yes"
                                okButtonProps={{ style: { backgroundColor: '#00BFFF' } }}
                                cancelText="No"
                            >
                                <button
                                    className='py-2 px-3 border border-red-500 flex justify-center items-center rounded-lg gap-1 text-gray-500 cursor-pointer'
                                    key='list-loadmore-more'
                                >
                                    Delete
                                </button>
                            </Popconfirm>
                        ]}
                    >
                        <List.Item.Meta
                            avatar={
                                <img className='h-24 w-36 object-cover'
                                    src={`http://localhost:8000/files/${item.url}`}
                                />
                            }
                            title={<a href='https://ant.design'>{item.name}</a>}
                            description={item.type} />
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
                    {uploadProgress > 0 && <Progress percent={uploadProgress} />}

                </Form>
            </Modal>



        </div>
    );
}

export default Banners