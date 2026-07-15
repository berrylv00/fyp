package azh.bkd.demo.service;
import azh.bkd.demo.model.RoomBooking;
import azh.bkd.demo.repository.RoomBookingRepository;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoomBookingService {

    private final RoomBookingRepository bookingRepository;

    public RoomBookingService(RoomBookingRepository bookingRepository) {
        this.bookingRepository = bookingRepository;
    }

    // ===========================
    // Save Booking
    // ===========================

    public RoomBooking saveBooking(RoomBooking booking) {
        return bookingRepository.save(booking);
    }

    // ===========================
    // Get All Bookings
    // ===========================

    public List<RoomBooking> getAllBookings() {
        return bookingRepository.findAll();
    }

    // ===========================
    // Get Booking By ID
    // ===========================

    public Optional<RoomBooking> getBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    // ===========================
    // Student Bookings
    // ===========================

    public List<RoomBooking> getStudentBookings(String studentName) {
        return bookingRepository.findByStudentName(studentName);
    }

    // ===========================
    // Delete Booking
    // ===========================

    public void deleteBooking(Long id) {
        bookingRepository.deleteById(id);
    }

    // ===========================
    // Smart Conflict Checking
    // ===========================

    public List<RoomBooking> checkConflicts(

            String roomNo,

            String day,

            String timeSlot) {

        return bookingRepository
                .findByRoomNoAndDayAndTimeSlotAndStatus(

                        roomNo,

                        day,

                        timeSlot,

                        "APPROVED");
    }

}