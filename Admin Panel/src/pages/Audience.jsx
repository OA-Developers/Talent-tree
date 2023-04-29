import React, { useState } from 'react'
import { Avatar, List, Form, Input, Select, Modal } from 'antd';
import { Button, Row, Col, Upload } from 'antd';
import { UploadOutlined } from '@ant-design/icons';
import { FaPlus } from 'react-icons/fa';
import { useForm } from 'antd/es/form/Form';

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

const Audience = () => {

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

    const onFinish = (values) => {
        // Handle According to isCreating 
        console.log('Received values of form: ', values);
        setVisible(false);
        form.resetFields();
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
                            <button
                                className='py-2 px-3 border border-black flex justify-center items-center rounded-lg gap-1 text-gray-500 cursor-pointer'
                                key='list-loadmore-edit'
                                onClick={handleEdit}
                            >
                                Edit
                            </button>,
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
                                <Avatar
                                    src={`https://xsgames.co/randomusers/avatar.php?g=pixel&key=${item.key}`}
                                />
                            }
                            title={<a href='https://ant.design'>{item.title}</a>}
                            description='Ant Design, a design langudescription for background applications, is refined by Ant UED Team'
                        />
                    </List.Item>
                )}
            />
            <Modal
                title={isCreating ? "Add a Item" : "Edit Item"}
                onCancel={handleCancel}
                onOk={onFinish}
                // confirmLoading={loading}
                visible={visible}
                okText="Save"
                okButtonProps={{ style: { backgroundColor: '#00BFFF' } }}
                cancelText="Cancel"
            >
                <Form form={form} layout="vertical" initialValues={{ category: 'TV' }}>
                    <Form.Item
                        label="Title"
                        name="title"
                        rules={[{ required: true, message: 'Please enter a title!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        label="Category"
                        name="category"
                        rules={[{ required: true, message: 'Please select a category!' }]}
                    >
                        <Select>
                            <Option value="TV">TV</Option>
                            <Option value="Ads">Ads</Option>
                            <Option value="Web">Web</Option>
                            <Option value="Movies">Movies</Option>
                        </Select>
                    </Form.Item>
                    <Form.Item
                        label="Location"
                        name="location"
                        rules={[{ required: true, message: 'Please enter a title!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        label="Description"
                        name="description"
                        rules={[{ required: true, message: 'Please enter a description!' }]}
                    >
                        <Input.TextArea rows={4} />
                    </Form.Item>
                    <Form.Item label="Logo Image" name="logoImage">
                        <Upload>
                            <Button icon={<UploadOutlined />}>Upload Logo Image</Button>
                        </Upload>
                    </Form.Item>
                    <Form.Item label="Banner Image" name="bannerImage">
                        <Upload>
                            <Button icon={<UploadOutlined />}>Upload Banner Image</Button>
                        </Upload>
                    </Form.Item>
                </Form>
            </Modal>



        </div>
    );
}

export default Audience