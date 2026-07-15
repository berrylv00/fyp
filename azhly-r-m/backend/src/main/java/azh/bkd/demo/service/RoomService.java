package azh.bkd.demo.service;

import azh.bkd.demo.model.Room;
import azh.bkd.demo.repository.RoomRepository;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoomService {

    private final RoomRepository roomRepository;

    public RoomService(RoomRepository roomRepository) {
        this.roomRepository = roomRepository;
    }

    // Get all rooms
    public List<Room> getAllRooms() {
        return roomRepository.findAll();
    }

    // Save room
    public Room saveRoom(Room room) {
        return roomRepository.save(room);
    }

    // Get room by id
    public Optional<Room> getRoomById(Long id) {
        return roomRepository.findById(id);
    }

    // Department rooms
    public List<Room> getDepartmentRooms(String department) {
        return roomRepository.findByDepartment(department);
    }

    // Status rooms
    public List<Room> getRoomsByStatus(String status) {
        return roomRepository.findByStatus(status);
    }

    // Delete room
    public void deleteRoom(Long id) {
        roomRepository.deleteById(id);
    }
}