import React from 'react'
import { Avatar, List } from 'antd';
import { Table, Input, Space, Button, Modal,Colu } from 'antd';
import { SearchOutlined, ExclamationCircleOutlined,UserOutlined } from '@ant-design/icons';


const data = [
    {
        key: '1',
        name: 'John Doe',
        age: 32,
        address: '123 Main St',
    },
    {
        key: '2',
        name: 'John Doe',
        age: 32,
        address: '123 Main St',
    },
    {
        key: '3',
        name: 'John Doe',
        age: 32,
        address: '123 Main St',
    },
    {
        key: '4',
        name: 'John Doe',
        age: 32,
        address: '123 Main St',
    },
  ];

export default function Users() {
  return (
    <div className='p-5'>
  <Table dataSource={data}>
  <Table.Column  dataIndex="logo" key="logo" render={()=>(
   <Avatar src={"https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-profiles/avatar-1.webp"}/>
  )} />
  <Table.Column  title="Name" dataIndex="name" key="name" />
  <Table.Column title="Age" dataIndex="age" key="age" />
  <Table.Column title="Address" dataIndex="address" key="address" />
  <Table.Column
    title="Action"
    key="action"
    render={(text, record) => (
      <Space size="middle">
        <Button className='bg-red-500 text-white font-semibold' type="danger" onClick={() => this.handleBanUser(record)}>
          Disable
        </Button>
      </Space>
    )}
  />
</Table>

</div>
  )
}
