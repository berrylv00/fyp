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

    // -----------------------------
    // Step 1 : Request Received
    // -----------------------------
    booking.setStatus("PROCESSING");
    booking.setSmartEngineStage("Reading Timetable...");
    booking.setAdminMessage("Smart Engine is processing your request...");

    RoomBooking savedBooking = bookingService.saveBooking(booking);

    // -----------------------------
    // Step 2 : Checking Availability
    // -----------------------------
    bookingService.updateStage(savedBooking, "Checking Room Availability...");

    List<RoomBooking> conflicts =
            bookingService.checkConflicts(
                    savedBooking.getRoomNo(),
                    savedBooking.getDay(),
                    savedBooking.getTimeSlot());

    // -----------------------------
    // Step 3 : Conflict Found
    // -----------------------------
    if (!conflicts.isEmpty()) {

        RoomBooking conflictBooking = conflicts.get(0);

        savedBooking.setConflictWith(conflictBooking.getStudentName());

        bookingService.waitingForUser(
                savedBooking,
                "Lab-5"      // Temporary alternate room
        );

        savedBooking.setAdminMessage(
                "Requested room is occupied. Waiting for user decision."
        );

        bookingService.saveBooking(savedBooking);

        return ResponseEntity.ok(savedBooking);
    }

    // -----------------------------
    // Step 4 : Auto Approve
    // -----------------------------
    bookingService.updateStage(
            savedBooking,
            "Finalizing Allocation..."
    );

    bookingService.approve(
            savedBooking,
            "Approved automatically by Smart Engine."
    );

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