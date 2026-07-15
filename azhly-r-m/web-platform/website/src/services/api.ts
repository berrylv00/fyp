import axios from "axios";

const api = axios.create({

    baseURL:"https://expert-engine-vpp95qjgj45xcp77-8082.app.github.dev/",

    headers: {
        "Content-Type": "application/json",
    },

});

export default api;