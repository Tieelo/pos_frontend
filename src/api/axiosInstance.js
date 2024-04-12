// axiosInstance.js

import axios from 'axios'
import dotenv from 'dotenv'

dotenv.config()

const axiosInstance = axios.create({
    baseURL: process.env.BASE_URL || "http://localhost:11386"
});

export default axiosInstance;