import api from "./api";

// =========================
// Get All Bookings
// =========================

export const getAllBookings = async () => {
  const response = await api.get("/bookings/all");
  return response.data;
};

// =========================
// Approve Booking
// =========================

export const approveBooking = async (
  id: number,
  message: string = ""
) => {
  const response = await api.post(
    `/bookings/review/${id}?action=APPROVE&message=${encodeURIComponent(message)}`
  );

  return response.data;
};

// =========================
// Reject Booking
// =========================

export const rejectBooking = async (
  id: number,
  message: string = ""
) => {
  const response = await api.post(
    `/bookings/review/${id}?action=REJECT&message=${encodeURIComponent(message)}`
  );

  return response.data;
};

// =========================
// Delete Booking
// =========================

export const deleteBooking = async (id: number) => {
  const response = await api.delete(`/bookings/${id}`);
  return response.data;
};