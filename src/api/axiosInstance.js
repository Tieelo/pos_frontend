import axios from 'axios';

// Erstelle die Axios-Instanz
const axiosInstance = axios.create({
    baseURL: 'http://pos_spring:8080',
    // baseURL: 'http://pos_backend:8080',
    withCredentials: true,
    headers: {
        'X-API-Key': '1234' // Ersetze YOUR_API_KEY mit deinem echten API-Schlüssel
    }
});

console.log(axiosInstance.defaults.baseURL); // Logge die Basis-URL

export default axiosInstance;
