// src/utils/auth.ts

const TOKEN_KEY = "azhly_token";

export const saveToken = (token: string): void => {
  localStorage.setItem(TOKEN_KEY, token);
};

export const getToken = (): string | null => {
  return localStorage.getItem(TOKEN_KEY);
};

export const removeToken = (): void => {
  localStorage.removeItem(TOKEN_KEY);
};

export const isAuthenticated = (): boolean => {
  return getToken() !== null;
};

export const logout = (): void => {
  localStorage.removeItem(TOKEN_KEY);
  window.location.href = "/";
};