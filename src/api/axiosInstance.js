import axios from 'axios'
// Create the Axios instance


const axiosInstance = axios.create({
    baseURL: 'http://pos_backend:8080',
/*    baseURL: 'http://192.168.10.167:8080',*/
    withCredentials: true
    /*baseURL: import.meta.env.VITE_BACKEND_URL || 'http://localhost:11386'*/
})

console.log(axiosInstance.defaults.baseURL) // Log the base URL

export default axiosInstance
