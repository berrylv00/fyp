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
}