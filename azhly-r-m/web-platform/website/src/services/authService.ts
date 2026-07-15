import api from "./api";

// =========================
// Login
// =========================

export interface LoginRequest {
  email: string;
  password: string;
}

// =========================
// Register
// =========================

export interface RegisterRequest {
  universityName: string;
  campusName: string;
  instituteType: string;

  adminName: string;
  email: string;
  phone: string;
  designation: string;

  password: string;
  confirmPassword: string;

  logo: string;

  agreeTerms: boolean;
}

// =========================
// Register API
// =========================

export const register = async (data: RegisterRequest) => {
  const response = await api.post("/auth/register", data);
  return response.data;
};

// =========================
// Login API
// =========================

export const login = async (data: LoginRequest) => {
  const response = await api.post("/auth/login", data);
  return response.data;
};