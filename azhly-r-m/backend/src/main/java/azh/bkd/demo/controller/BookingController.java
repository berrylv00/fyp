package azh.bkd.demo.controller;
import azh.bkd.demo.model.Room;
import azh.bkd.demo.service.RoomService;
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
private final RoomService roomService;

public BookingController(
        RoomBookingService bookingService,
        RoomService roomService) {

    this.bookingService = bookingService;
    this.roomService = roomService;
}

    // =====================================
    // Student sends booking request
    // =====================================
@PostMapping("/request")
public ResponseEntity<RoomBooking> requestBooking(
        @RequestBody RoomBooking booking) {

    // Request Received
    booking.setStatus("PENDING");
    booking.setSmartEngineStage("Reading Timetable...");
    booking.setAdminMessage("Smart Engine is processing your request...");

    RoomBooking savedBooking = bookingService.saveBooking(booking);
    try {
    Thread.sleep(1000);
} catch (InterruptedException e) {
    Thread.currentThread().interrupt();
}

    // Stage 2
    savedBooking.setStatus("PROCESSING");
bookingService.saveBooking(savedBooking);
    bookingService.updateStage(
            savedBooking,
            "Checking Room Availability..."
    );
try {
    Thread.sleep(3000);
} catch (InterruptedException e) {
    Thread.currentThread().interrupt();
}
    List<RoomBooking> conflicts =
            bookingService.checkConflicts(

                    savedBooking.getRoomNo(),

                    savedBooking.getDay(),

                    savedBooking.getTimeSlot());

    // ===============================
    // Conflict Found
    // ===============================

if (!conflicts.isEmpty()) {

    savedBooking.setConflictWith(
            conflicts.get(0).getStudentName());

    bookingService.reject(
            savedBooking,
            "Room is already booked for this time slot.");

    return ResponseEntity.ok(savedBooking);
}
    // ===============================
    // No Conflict
    // ===============================

    bookingService.updateStage(

            savedBooking,

            "Finalizing Allocation...");

    bookingService.approve(

            savedBooking,

            "Automatically approved by Smart Engine.");

    return ResponseEntity.ok(savedBooking);

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

// =====================================
// Admin Review / Override
// =====================================

@PostMapping("/review/{id}")
public ResponseEntity<RoomBooking> reviewBooking(

        @PathVariable Long id,

        @RequestParam String action,

        @RequestParam(required = false, defaultValue = "") String message,

        @RequestParam(required = false, defaultValue = "") String alternateRoom) {

    RoomBooking booking = bookingService
            .getBookingById(id)
            .orElse(null);

    if (booking == null) {

        return ResponseEntity.notFound().build();

    }

    switch (action.toUpperCase()) {

        case "APPROVE_ORIGINAL":

            bookingService.approveOriginal(
                    booking,
                    message.isBlank()
                            ? "Original room approved by Admin."
                            : message);

            break;

        case "APPROVE_ALTERNATE":

            bookingService.approveAlternate(
                    booking,
                    alternateRoom,
                    message.isBlank()
                            ? "Alternate room approved by Admin."
                            : message);

            break;

        case "REJECT":

            bookingService.overrideReject(
                    booking,
                    message.isBlank()
                            ? "Rejected by Admin."
                            : message);

            break;

        default:

            return ResponseEntity.badRequest().build();

    }

    return ResponseEntity.ok(booking);

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