package azh.bkd.demo.controller;

import azh.bkd.demo.model.RoomBooking;
import azh.bkd.demo.service.RoomBookingService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/bookings")
@CrossOrigin(origins = "*")
public class BookingController {

    private final RoomBookingService bookingService;

    public BookingController(RoomBookingService bookingService) {
        this.bookingService = bookingService;
    }

    // =====================================
    // Student sends booking request
    // =====================================

    @PostMapping("/request")
    public ResponseEntity<RoomBooking> requestBooking(
            @RequestBody RoomBooking booking) {

        booking.setStatus("PENDING");
        booking.setAdminMessage("Awaiting Smart Engine Review");

        RoomBooking savedBooking = bookingService.saveBooking(booking);

        return ResponseEntity.ok(savedBooking);
    }

    // =====================================
    // Admin Approve / Reject Booking
    // =====================================

    @PostMapping("/review/{id}")
    public ResponseEntity<?> reviewBooking(

            @PathVariable Long id,

            @RequestParam String action,

            @RequestParam(required = false) String message) {

        RoomBooking booking = bookingService
                .getBookingById(id)
                .orElseThrow(() ->
                        new RuntimeException("Booking not found"));

        if (action.equalsIgnoreCase("APPROVE")) {

            List<RoomBooking> conflicts =
                    bookingService.checkConflicts(

                            booking.getRoomNo(),

                            booking.getDay(),

                            booking.getTimeSlot());

            if (!conflicts.isEmpty()) {

                booking.setStatus("REJECTED");

                booking.setAdminMessage(
                        "Smart Engine: Conflict Detected! Room already booked.");

                bookingService.saveBooking(booking);

                return ResponseEntity
                        .badRequest()
                        .body("Conflict Detected! Room already booked.");

            }

            booking.setStatus("APPROVED");

            booking.setAdminMessage(

                    (message == null || message.isBlank())

                            ? "Approved Successfully."

                            : message);

        } else {

            booking.setStatus("REJECTED");

            booking.setAdminMessage(

                    (message == null || message.isBlank())

                            ? "Rejected by Admin."

                            : message);

        }

        RoomBooking updatedBooking = bookingService.saveBooking(booking);

        return ResponseEntity.ok(updatedBooking);
    }

    // =====================================
    // Admin gets all bookings
    // =====================================

    @GetMapping("/all")
    public List<RoomBooking> getAllBookings() {

        return bookingService.getAllBookings();

    }

    // =====================================
    // Student booking history
    // =====================================

    @GetMapping("/student/{name}")
    public List<RoomBooking> getStudentBookings(
            @PathVariable String name) {

        return bookingService.getStudentBookings(name);

    }

    // =====================================
    // Delete Booking
    // =====================================

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteBooking(
            @PathVariable Long id) {

        bookingService.deleteBooking(id);

        return ResponseEntity.ok("Booking deleted successfully.");

    }

}