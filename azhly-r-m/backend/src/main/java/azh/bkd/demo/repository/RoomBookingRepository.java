package azh.bkd.demo.repository;
import azh.bkd.demo.model.RoomBooking;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface RoomBookingRepository extends JpaRepository<RoomBooking, Long> {
    
    // Custom query to find existing approved bookings for conflict check
    List<RoomBooking> findByRoomNoAndDayAndTimeSlotAndStatus(
        String roomNo, String day, String timeSlot, String status
    );
    
    List<RoomBooking> findByStudentName(String studentName);

    // Find all active approved bookings
List<RoomBooking> findByStatus(String status);

// Find all bookings of a room
List<RoomBooking> findByRoomNo(String roomNo);

// Find bookings by room and status
List<RoomBooking> findByRoomNoAndStatus(String roomNo, String status);

public void completeBooking(RoomBooking booking) {

    booking.setStatus("COMPLETED");

    booking.setSmartEngineStage("Completed");

    booking.setAdminMessage("Class completed successfully.");

    bookingRepository.save(booking);
}

public List<RoomBooking> getApprovedBookings() {

    return bookingRepository.findByStatus("APPROVED");
}

public void markCompleted(Long id) {

    Optional<RoomBooking> booking = bookingRepository.findById(id);

    if (booking.isPresent()) {

        RoomBooking b = booking.get();

        b.setStatus("COMPLETED");

        b.setSmartEngineStage("Completed");

        bookingRepository.save(b);
    }
}
}