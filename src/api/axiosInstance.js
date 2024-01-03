// axiosInstance.js

import axios from 'axios'

const axiosInstance = axios.create({
    baseURL: 'http://localhost:11386'
});

export default axiosInstance;