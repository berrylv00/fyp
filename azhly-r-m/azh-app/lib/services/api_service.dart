import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/room.dart' show Room;

class ApiService {
  
 
  // ==============================
  // BASE URL
  // ==============================

  // web

   static const String baseUrl =
    "https://expert-engine-vpp95qjgj45xcp77-8081.app.github.dev/api";
  

  // Android Emulator
  // static const String baseUrl = "http://10.0.2.2:8080/api";

  // Physical Phone
  // static const String baseUrl = "http://192.168.1.5:8080/api";

  // ==============================
  // LOGIN
  // ==============================

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Login Failed");
  }

  // ==============================
  // REGISTER
  // ==============================

  Future<String> register({
    required String universityName,
    required String campusName,
    required String instituteType,
    required String adminName,
    required String email,
    required String phone,
    required String designation,
    required String password,
    required String confirmPassword,
    required bool agreeTerms,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "universityName": universityName,
        "campusName": campusName,
        "instituteType": instituteType,
        "adminName": adminName,
        "email": email,
        "phone": phone,
        "designation": designation,
        "password": password,
        "confirmPassword": confirmPassword,
        "agreeTerms": agreeTerms,
      }),
    );

    return response.body;
  }

  // ==============================
  // ROOMS
  // ==============================

  Future<List<Room>> getRooms() async {
    final response = await http.get(
      Uri.parse("$baseUrl/rooms"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => Room.fromJson(e)).toList();
    }

    throw Exception("Unable to load rooms");
  }

  // ==============================
  // REQUEST BOOKING
  // ==============================

  Future<Map<String, dynamic>> requestBooking({
    required String studentName,
    required String roomNo,
    required String day,
    required String timeSlot,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/bookings/request"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "studentName": studentName,
        "roomNo": roomNo,
        "day": day,
        "timeSlot": timeSlot,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Booking Failed");
  }

  // ==============================
  // STUDENT BOOKINGS
  // ==============================

  Future<List<dynamic>> getStudentBookings(
    String studentName,
  ) async {
    final response = await http.get(
      Uri.parse("$baseUrl/bookings/student/$studentName"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Unable to fetch bookings");
  }

  // ==============================
  // ALL BOOKINGS
  // ==============================

  Future<List<dynamic>> getAllBookings() async {
    final response = await http.get(
      Uri.parse("$baseUrl/bookings/all"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Unable to fetch bookings");
  }

  // ==============================
  // APPROVE BOOKING
  // ==============================

  Future<String> approveBooking(
    int id,
    String message,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/bookings/review/$id?action=APPROVE&message=$message"),
    );

    return response.body;
  }

  // ==============================
  // REJECT BOOKING
  // ==============================

  Future<String> rejectBooking(
    int id,
    String message,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/bookings/review/$id?action=REJECT&message=$message"),
    );

    return response.body;
  }

  // ==============================
  // DELETE BOOKING
  // ==============================

  Future<void> deleteBooking(int id) async {
    await http.delete(
      Uri.parse("$baseUrl/bookings/$id"),
    );
  }
}
