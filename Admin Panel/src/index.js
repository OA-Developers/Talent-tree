import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';

import App from './App';

import { ConfigProvider, theme } from 'antd';


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
<ConfigProvider theme={{algorithm:theme.defaultAlgorithm}}>
  <App />
</ConfigProvider>
);
