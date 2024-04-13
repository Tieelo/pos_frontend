// axiosInstance.js
import axios from 'axios'

// Create the Axios instance
const axiosInstance = axios.create({
    baseURL: import.meta.env.VITE_APP_BASE_URL || 'http://localhost:11386'
})

console.log(axiosInstance.defaults.baseURL) // Log the base URL

export default axiosInstance
