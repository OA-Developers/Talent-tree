import React, { useEffect, useState } from 'react';
import { Card, Row, Col, Modal, Form, Input, Upload, Button, message, Select, Typography, Progress } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import axios from 'axios';
import { useForm } from 'antd/es/form/Form';
import { MdDelete } from 'react-icons/md';
const { Meta } = Card;
const { TextArea } = Input;
const { Option } = Select;

const Debate = () => {
    const [debates, setDebates] = useState([
    ]);
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [type, setType] = useState('link');
    const [uploadProgress, setUploadProgress] = useState(0);

    const [form] = useForm();
    const API_URL = process.env.REACT_APP_API_URL;

    const fetchDebates = async () => {
        try {
            const response = await axios.get(`${API_URL}/debates`);
            setDebates(response.data);
        } catch (error) {
            message.error('Error fetching debates:', error);
        }
    };

    const handleDeleteDebate = async (debateId) => {
        try {
            const response = await axios.delete(`${API_URL}/debate/${debateId}`);
            if (response.status === 200) {
                message.success("Debate deleted successfully");
                setIsModalVisible(false);

                fetchDebates();
            } else {
                message.error('Failed to delete debate');
                setIsModalVisible(false);

            }
        } catch (e) {
            message.error("Error deleting debate:", e);
            setIsModalVisible(false);

        }
    }

    useEffect(() => {


        fetchDebates();
    }, []);
    const handleAddDebate = async (values) => {
        try {
            const { title, description, type, videoLink, video, thumbnail } = values;
            const { file: thumbnailFile } = thumbnail;
            const formData = new FormData();
            formData.append('title', title);
            formData.append('description', description);
            formData.append('thumbnail', thumbnailFile.originFileObj);
            let response;

            if (type === 'link') {
                formData.append('videoLink', videoLink);
                response = await axios.post(`${API_URL}/debate/upload/link`, formData, formData, {
                    onUploadProgress: (progressEvent) => {
                        const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                        console.log('Upload progress:', percentCompleted);
                        setUploadProgress(percentCompleted);
                    }
                });
            } else if (type === 'upload') {
                const { file } = video;
                console.log(file);
                formData.append('file', file.originFileObj);
                response = await axios.post(`${API_URL}/debate/upload/file`, formData, formData, {
                    onUploadProgress: (progressEvent) => {
                        const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                        console.log('Upload progress:', percentCompleted);
                        setUploadProgress(percentCompleted);
                    },
                });
            }

            if (response.status === 200) {
                message.success('Debate created successfully');
                setIsModalVisible(false);
                form.resetFields()
            } else {
                message.error('Failed to create debate');
                form.resetFields()
            }
        } catch (error) {
            console.error('Error creating debate:', error);
            message.error('Failed to create debate');
        }
    };


    const handleCancel = () => {
        setIsModalVisible(false);
        form.resetFields()
    };

    const handleCreateDebate = () => {
        setIsModalVisible(true);
    };

    const onFinishFailed = (errorInfo) => {
        console.log('Failed:', errorInfo);
    };

    const handleTypeChange = (value) => {
        console.log(`Selected ${value}`);
        setType(value);
    };

    return (
        <div className='flex flex-col justify-center gap-5 m-5'>
            <Row>

                <Col xs={24} sm={12} md={8} lg={6}>
                    <div
                        className='h-[200px] w-[350px] border border-gray-300 rounded-md flex flex-col gap-2 justify-center items-center'
                        style={{ textAlign: 'center' }}
                        onClick={handleCreateDebate}
                    >
                        <PlusOutlined style={{ fontSize: '48px' }} />
                        <p>Create New Debate</p>
                    </div>
                </Col>
            </Row>
            <div>

                <Typography.Title className='font-serif' level={4}>Debates</Typography.Title>
                <Row gutter={[8, 8]}>

                    {debates.map((debate) => (
                        <Col key={debate.title} xs={24} sm={12} md={8} lg={6}>
                            <div className='h-48 w-80 border border-gray-300 flex flex-col relative rounded-md overflow-hidden'>
                                <div
                                    type='text'
                                    className='absolute top-2 text-red-600 text-xl bg-white cursor-pointer rounded-full left-2'
                                    onClick={() => handleDeleteDebate(debate._id)}
                                >
                                    <MdDelete />
                                </div>

                                <div className='h-full w-full bg-contain bg-center' style={{ backgroundImage: `url(${API_URL}/${debate.thumbnailUrl})` }}></div>
                                <div className='absolute bottom-0 w-full bg-[rgba(0,0,0,0.6)] py-2 text-white px-5'>
                                    <div className='text-lg font-medium'>{debate.title}</div>
                                    <div className='text-sm overflow-ellipsis overflow-hidden'>{debate.description}</div>
                                </div>
                            </div>

                        </Col>
                    ))}
                </Row>
            </div>
            <Modal
                title="Create New Debate"
                visible={isModalVisible}
                onCancel={handleCancel}
                onOk={() => form.submit()}
                okText="Upload"
                okButtonProps={{ style: { backgroundColor: '#00BFFF' } }}
                cancelText="Cancel"
            >
                <Form
                    name="createDebate"
                    onFinish={handleAddDebate}
                    form={form}
                    onFinishFailed={onFinishFailed}
                >
                    <Form.Item
                        label="Title"
                        name="title"
                        rules={[{ required: true, message: 'Please input the title!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        label="Description"
                        name="description"
                        rules={[
                            { required: true, message: 'Please input the description!' },
                        ]}
                    >
                        <TextArea rows={4} />
                    </Form.Item>
                    <Form.Item
                        label="Type"
                        name="type"
                        rules={[{ required: true, message: 'Please select the type!' }]}
                    >
                        <Select onChange={handleTypeChange}>
                            <Option value="link">Link</Option>
                            <Option value="upload">Upload</Option>
                        </Select>
                    </Form.Item>
                    {type === 'link' ? (
                        <Form.Item
                            label="Video Link"
                            name="videoLink"
                            rules={[{ required: true, message: 'Please input the video link!' }]}
                        >
                            <Input />
                        </Form.Item>
                    ) : (
                        <Form.Item
                            label="File"
                            name="video"
                            rules={[{ required: true, message: 'Please select the video file!' }]}
                        >
                            <Upload accept="video/*">
                                <Button>Choose File</Button>
                            </Upload>
                        </Form.Item>
                    )}
                    <Form.Item
                        label="Thumbnaill"
                        name="thumbnail"
                        rules={[
                            { required: true, message: 'Please select the thumbnail file!' },
                        ]}
                    >
                        <Upload accept="image/*">
                            <Button>Choose File</Button>
                        </Upload>
                    </Form.Item>
                    {uploadProgress > 0 && <Progress percent={uploadProgress} />}
                </Form>
            </Modal>
        </div>
    );
};

export default Debate;
