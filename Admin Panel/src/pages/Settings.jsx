import React, { useEffect, useState } from 'react';
import { Modal, Form, Input, Upload, Button, message } from 'antd';
import { FiEdit } from 'react-icons/fi';
import axios from "axios"

const { TextArea } = Input;
function Settings() {
    const API_URL = process.env.REACT_APP_API_URL;
    const [visible, setVisible] = useState(false);
    const [settingsData, setSettingsData] = useState({});
    const [categoryName, setCategoryName] = useState('');
    const [form] = Form.useForm();

    const fetchSettings = async () => {
        try {
            const response = await axios.get(`${API_URL}/settings`);
            if (response.data)
                setSettingsData(response.data);
        } catch (error) {
            message.error('Error fetching Settings:', error);
        }
    };

    useEffect(() => { fetchSettings() }, [])
    const showModal = (category) => {
        setCategoryName(category);
        setVisible(true);
    };
    const handleOk = () => {
        form.validateFields().then(async (values) => {
            try {
                const formData = new FormData();
                formData.append('file', values.file[0].originFileObj);

                const response = await axios.post(`${API_URL}/settings/${categoryName}`, formData, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                });

                console.log('Image upload successful:', response.data);
                message.success("Updated Successfully!")
                fetchSettings();
                setVisible(false);
            } catch (error) {
                console.error('Image upload failed:', error);
                // Handle error
            }
        });
    };

    const handleCancel = () => {
        setVisible(false);
    };

    const normFile = (e) => {
        if (Array.isArray(e)) {
            return e;
        }
        return e && e.fileList;
    };

    return (
        <div className="p-5 flex flex-col">
            <h1 className="text-lg font-semibold">Settings</h1>
            <h2 className="text-md font-semibold mt-10">Categories</h2>
            <div className="flex gap-10 p-2 mt-3">
                <div className="w-72 rounded-sm flex justify-center relative items-center h-44 border border-gray-300 shadow-md">
                    <p className="absolute -translate-x-1/2 left-1/2 -bottom-6 font-semibold">Serial Audition</p>
                    <FiEdit onClick={() => showModal('updateTvBanner')} className="text-white cursor-pointer absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 " size={30} />
                    <img className="w-full rounded-sm h-full" src={settingsData.tvBanner ? `${API_URL}/files/${settingsData.tvBanner}` : "https://images.unsplash.com/photo-1685094488656-9231107be07f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"} alt="" />
                </div>
                <div className="w-72 rounded-sm flex justify-center relative items-center h-44 border border-gray-300 shadow-md">
                    <p className="absolute -translate-x-1/2 left-1/2 -bottom-6 font-semibold">Web/Movie</p>
                    <FiEdit onClick={() => showModal('updateWebBanner')} className="text-white cursor-pointer absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 " size={30} />
                    <img className="w-full rounded-sm h-full" src={settingsData.webBanner ? `${API_URL}/files/${settingsData.webBanner}` : "https://images.unsplash.com/photo-1685094488656-9231107be07f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"} alt="" />
                </div>
                <div className="w-72 rounded-sm flex justify-center relative items-center h-44 border border-gray-300 shadow-md">
                    <p className="absolute -translate-x-1/2 left-1/2 -bottom-6 font-semibold">Ad Audition</p>
                    <FiEdit onClick={() => showModal('updateAdBanner')} className="text-white cursor-pointer absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 " size={30} />
                    <img className="w-full rounded-sm h-full" src={settingsData.adBanner ? `${API_URL}/files/${settingsData.adBanner}` : "https://images.unsplash.com/photo-1685094488656-9231107be07f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"} alt="" />
                </div>
            </div>

            <Modal
                visible={visible}
                title={`Upload Image`}
                onOk={handleOk}
                okButtonProps={{ style: { backgroundColor: '#00BFFF' } }}
                onCancel={handleCancel}
            >
                <Form form={form}>
                    <Form.Item name="file" label="Image" valuePropName="fileList" getValueFromEvent={normFile}>
                        <Upload name="file" action="/your-upload-url" listType="picture">
                            <Button>Upload</Button>
                        </Upload>
                    </Form.Item>
                </Form>
            </Modal>
        </div>
    );
}

export default Settings;
