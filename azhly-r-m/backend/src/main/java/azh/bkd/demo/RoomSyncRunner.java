package azh.bkd.demo;

import azh.bkd.demo.model.Room;
import azh.bkd.demo.model.RoomBooking;
import azh.bkd.demo.service.RoomBookingService;
import azh.bkd.demo.service.RoomService;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class RoomSyncRunner implements CommandLineRunner {

    private final RoomService roomService;
    private final RoomBookingService bookingService;

    public RoomSyncRunner(RoomService roomService,
                          RoomBookingService bookingService) {

        this.roomService = roomService;
        this.bookingService = bookingService;
    }

    @Override
    public void run(String... args) {

        System.out.println("========== ROOM SYNC START ==========");

        // Step 1
        roomService.getAllRooms().forEach(room -> {
            room.setStatus("AVAILABLE");
            room.setAvailable(true);
            roomService.saveRoom(room);
        });

        // Step 2
        bookingService.getApprovedBookings().forEach(booking -> {

            Room room =
                    roomService.getRoomByRoomNo(
                            booking.getApprovedRoom());

            if (room != null) {

                room.setStatus("OCCUPIED");
                room.setAvailable(false);

                roomService.saveRoom(room);

                System.out.println(
                        room.getRoomNo() + " -> OCCUPIED");
            }
        });

        System.out.println("========== ROOM SYNC END ==========");
    }
}