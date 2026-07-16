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

    // Stage 2
    bookingService.updateStage(
            savedBooking,
            "Checking Room Availability..."
    );

    List<RoomBooking> conflicts =
            bookingService.checkConflicts(

                    savedBooking.getRoomNo(),

                    savedBooking.getDay(),

                    savedBooking.getTimeSlot());

    // ===============================
    // Conflict Found
    // ===============================

    if (!conflicts.isEmpty()) {

        Room alternate = roomService.findAlternateRoom();

        savedBooking.setConflictWith(
                conflicts.get(0).getStudentName());

        if (alternate != null) {

            bookingService.waitingForUser(

                    savedBooking,

                    alternate.getRoomNo());

            savedBooking.setAdminMessage(
                    "Conflict detected. Waiting for teacher response.");

        } else {

            bookingService.reject(

                    savedBooking,

                    "No alternate room available.");

        }

        bookingService.saveBooking(savedBooking);

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