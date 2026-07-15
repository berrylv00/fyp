class Room {
  final int id;
  final String roomNo;
  final String blockName;
  final String floorNo;
  final String department;
  final String roomType;
  final int capacity;
  final String status;
  final String timeSlot;
  final bool available;
  final bool active;

  Room({
    required this.id,
    required this.roomNo,
    required this.blockName,
    required this.floorNo,
    required this.department,
    required this.roomType,
    required this.capacity,
    required this.status,
    required this.timeSlot,
    required this.available,
    required this.active,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] ?? 0,
      roomNo: json['roomNo'] ?? '',
      blockName: json['blockName'] ?? '',
      floorNo: json['floorNo'] ?? '',
      department: json['department'] ?? '',
      roomType: json['roomType'] ?? '',
      capacity: json['capacity'] ?? 0,
      status: json['status'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
      available: json['available'] ?? false,
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "roomNo": roomNo,
      "blockName": blockName,
      "floorNo": floorNo,
      "department": department,
      "roomType": roomType,
      "capacity": capacity,
      "status": status,
      "timeSlot": timeSlot,
      "available": available,
      "active": active,
    };
  }
}
