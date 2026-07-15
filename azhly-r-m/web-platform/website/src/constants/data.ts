import type { BookingRequest, Room, User, Department, Notification } from '@/types';

export const BOOKING_REQUESTS: BookingRequest[] = [
  { id: 1, name: 'Areeba Khan', role: 'Student', roomNo: 'B-213', purpose: 'Group Study Session', timeSlot: '1:30 PM - 3:00 PM', date: '23 May 2025', status: 'pending' },
  { id: 2, name: 'Usman Ahmed', role: 'Faculty', roomNo: 'B-112', purpose: 'Department Meeting', timeSlot: '1:30 PM - 3:00 PM', date: '23 May 2025', status: 'pending' },
  { id: 3, name: 'Hina Malik', role: 'Faculty', roomNo: 'B-301', purpose: 'Research Discussion', timeSlot: '1:30 PM - 3:00 PM', date: '23 May 2025', status: 'pending' },
  { id: 4, name: 'Sara Noman', role: 'Student', roomNo: 'B-205', purpose: 'Project Presentation', timeSlot: '3:00 PM - 4:30 PM', date: '23 May 2025', status: 'pending' },
  { id: 5, name: 'Ali Raza', role: 'Student', roomNo: 'B-409', purpose: 'Lab Practice', timeSlot: '10:00 AM - 11:30 AM', date: '23 May 2025', status: 'pending' },
  { id: 6, name: 'Fatima Zahra', role: 'Faculty', roomNo: 'B-108', purpose: 'Faculty Meeting', timeSlot: '11:00 AM - 12:30 PM', date: '24 May 2025', status: 'pending' },
  { id: 7, name: 'Bilal Hassan', role: 'Student', roomNo: 'B-305', purpose: 'Seminar', timeSlot: '2:00 PM - 3:30 PM', date: '24 May 2025', status: 'pending' },
];

export const ROOMS: Room[] = [
  { id: '1', roomNo: 'B-101', floor: '1st Floor', block: 'Block B', status: 'occupied', capacity: 40 },
  { id: '2', roomNo: 'B-102', floor: '1st Floor', block: 'Block B', status: 'regular-class', capacity: 35 },
  { id: '3', roomNo: 'B-103', floor: '1st Floor', block: 'Block B', status: 'available', capacity: 30 },
  { id: '4', roomNo: 'B-108', floor: '1st Floor', block: 'Block B', status: 'available', capacity: 25 },
  { id: '5', roomNo: 'B-112', floor: '1st Floor', block: 'Block B', status: 'occupied', capacity: 45 },
  { id: '6', roomNo: 'B-201', floor: '2nd Floor', block: 'Block B', status: 'regular-class', capacity: 40 },
  { id: '7', roomNo: 'B-205', floor: '2nd Floor', block: 'Block B', status: 'available', capacity: 30 },
  { id: '8', roomNo: 'B-207', floor: '2nd Floor', block: 'Block B', status: 'reserved', label: 'Admin Room', capacity: 10 },
  { id: '9', roomNo: 'B-210', floor: '2nd Floor', block: 'Block B', status: 'reserved', label: 'HOD Office - CS', capacity: 5 },
  { id: '10', roomNo: 'B-213', floor: '2nd Floor', block: 'Block B', status: 'available', capacity: 35 },
  { id: '11', roomNo: 'B-301', floor: '3rd Floor', block: 'Block B', status: 'occupied', capacity: 40 },
  { id: '12', roomNo: 'B-305', floor: '3rd Floor', block: 'Block B', status: 'regular-class', capacity: 35 },
  { id: '13', roomNo: 'B-310', floor: '3rd Floor', block: 'Block B', status: 'reserved', label: 'HOD Office - SE', capacity: 5 },
  { id: '14', roomNo: 'B-315', floor: '3rd Floor', block: 'Block B', status: 'available', capacity: 30 },
  { id: '15', roomNo: 'B-401', floor: '4th Floor', block: 'Block B', status: 'regular-class', capacity: 40 },
  { id: '16', roomNo: 'B-405', floor: '4th Floor', block: 'Block B', status: 'available', capacity: 35 },
  { id: '17', roomNo: 'B-409', floor: '4th Floor', block: 'Block B', status: 'available', capacity: 30 },
  { id: '18', roomNo: 'A-101', floor: '1st Floor', block: 'Block A', status: 'regular-class', capacity: 50 },
  { id: '19', roomNo: 'A-205', floor: '2nd Floor', block: 'Block A', status: 'available', capacity: 45 },
  { id: '20', roomNo: 'A-301', floor: '3rd Floor', block: 'Block A', status: 'reserved', label: 'Dean Office', capacity: 8 },
  { id: '21', roomNo: 'C-101', floor: '1st Floor', block: 'Block C', status: 'occupied', capacity: 40 },
  { id: '22', roomNo: 'C-201', floor: '2nd Floor', block: 'Block C', status: 'available', capacity: 35 },
  { id: '23', roomNo: 'C-301', floor: '3rd Floor', block: 'Block C', status: 'regular-class', capacity: 30 },
];

export const USERS: User[] = [
  { id: '1', name: 'Areeba Khan', role: 'Student', department: 'Computer Science', batch: '2026', semester: '4th', email: 'areeba.khan@azhly.edu', status: 'active' },
  { id: '2', name: 'Usman Ahmed', role: 'Student', department: 'Computer Science', batch: '2025', semester: '6th', email: 'usman.ahmed@azhly.edu', status: 'active' },
  { id: '3', name: 'Sara Noman', role: 'Student', department: 'Software Engineering', batch: '2026', semester: '4th', email: 'sara.noman@azhly.edu', status: 'active' },
  { id: '4', name: 'Ali Raza', role: 'Student', department: 'Data Science', batch: '2027', semester: '2nd', email: 'ali.raza@azhly.edu', status: 'active' },
  { id: '5', name: 'Bilal Hassan', role: 'Student', department: 'Computer Science', batch: '2025', semester: '6th', email: 'bilal.hassan@azhly.edu', status: 'active' },
  { id: '6', name: 'Hina Malik', role: 'Faculty', department: 'Computer Science', email: 'hina.malik@azhly.edu', status: 'active' },
  { id: '7', name: 'Fatima Zahra', role: 'Faculty', department: 'Software Engineering', email: 'fatima.zahra@azhly.edu', status: 'active' },
  { id: '8', name: 'Dr. Raheel Ahmad', role: 'Faculty', department: 'Mathematics', email: 'raheel.ahmad@azhly.edu', status: 'active' },
  { id: '9', name: 'Prof. Nadia Siddiqui', role: 'HOD', department: 'Computer Science', email: 'nadia.siddiqui@azhly.edu', status: 'active' },
  { id: '10', name: 'Prof. Kamran Shah', role: 'HOD', department: 'Software Engineering', email: 'kamran.shah@azhly.edu', status: 'active' },
  { id: '11', name: 'Dr. Asif Mehmood', role: 'Dean', department: 'Faculty of Computing', email: 'asif.mehmood@azhly.edu', status: 'active' },
  { id: '12', name: 'Ms. Robia Naveed', role: 'Coordinator', department: 'Academics', email: 'robia.naveed@azhly.edu', status: 'active' },
];

export const DEPARTMENTS: Department[] = [
  { id: '1', name: 'Computer Science', shortName: 'CS', facultyCount: 18, blocks: ['Block B'], studentCount: 320, head: 'Prof. Nadia Siddiqui' },
  { id: '2', name: 'Software Engineering', shortName: 'SE', facultyCount: 14, blocks: ['Block B'], studentCount: 260, head: 'Prof. Kamran Shah' },
  { id: '3', name: 'Data Science', shortName: 'DS', facultyCount: 10, blocks: ['Block A'], studentCount: 180, head: 'Dr. Tariq Raza' },
  { id: '4', name: 'Economics', shortName: 'ECO', facultyCount: 12, blocks: ['Block A'], studentCount: 210, head: 'Dr. Salma Qureshi' },
  { id: '5', name: 'Mathematics', shortName: 'MATH', facultyCount: 9, blocks: ['Block C'], studentCount: 150, head: 'Dr. Raheel Ahmad' },
  { id: '6', name: 'English', shortName: 'ENG', facultyCount: 8, blocks: ['Block A'], studentCount: 190, head: 'Ms. Aisha Baig' },
  { id: '7', name: 'Electronic & Power', shortName: 'EPV', facultyCount: 11, blocks: ['Block C'], studentCount: 140, head: 'Engr. Farhan Malik' },
  { id: '8', name: 'Social Sciences', shortName: 'SSG', facultyCount: 7, blocks: ['Block A'], studentCount: 120, head: 'Dr. Zara Hussain' },
];

export const NOTIFICATIONS: Notification[] = [
  { id: 1, type: 'booking', message: 'Usman Ahmed - Approved for Room B-205', time: '23 May 2025 - 3:00 PM', read: false },
  { id: 2, type: 'room-status', message: 'Room B-112 state updated to Pending', time: '23 May 2025 - 9:00 PM', read: false },
  { id: 3, type: 'conflict', message: '⚠️ Room B-213 has a timing conflict between Areeba Khan and Sara Noman (23 May 2025, 1:30 PM - 3:00 PM)', time: '23 May 2025 - 4:30 PM', read: false },
  { id: 4, type: 'conflict', message: '⚠️ Room B-205 is double booked for 23 May 2025, 3:00 PM - 4:30 PM', time: '23 May 2025 - 3:00 PM', read: false },
  { id: 5, type: 'conflict', message: '⚠️ Room B-301 has a conflict with an existing master timetable layout schedule.', time: '23 May 2025 - 2:15 PM', read: false },
  { id: 6, type: 'booking', message: 'Ali Raza - New booking request for Room B-409', time: '23 May 2025 - 10:00 AM', read: true },
  { id: 7, type: 'room-status', message: 'Room C-101 status changed to Occupied', time: '23 May 2025 - 8:30 AM', read: true },
];

export const TIMETABLE_COURSES: { code: string; color: string; bg: string; border: string }[] = [
  { code: 'OOP', color: 'text-green-800', bg: 'bg-green-100', border: 'border-green-300' },
  { code: 'DB', color: 'text-blue-800', bg: 'bg-blue-100', border: 'border-blue-300' },
  { code: 'OS', color: 'text-yellow-800', bg: 'bg-yellow-100', border: 'border-yellow-300' },
  { code: 'SE', color: 'text-orange-800', bg: 'bg-orange-100', border: 'border-orange-300' },
  { code: 'ENG', color: 'text-red-800', bg: 'bg-red-100', border: 'border-red-300' },
  { code: 'DS', color: 'text-purple-800', bg: 'bg-purple-100', border: 'border-purple-300' },
  { code: 'MATH', color: 'text-pink-800', bg: 'bg-pink-100', border: 'border-pink-300' },
  { code: 'CN', color: 'text-teal-800', bg: 'bg-teal-100', border: 'border-teal-300' },
];

export const TIMETABLE_BATCHES = [
  'BS-CS-21-II-A', 'BS-CS-21-II-B', 'BS-CS-20-IV-A', 'BS-CS-20-IV-B',
  'BS-SE-21-II-A', 'BS-SE-20-IV-A', 'MS-CS-II-A', 'Repeat Course',
];

// Grid data: [batchIndex][day 0-4][slot 0-9] = courseCode or ''
export const TIMETABLE_GRID: Record<number, Record<number, Record<number, string>>> = {
  0: { 0: { 0: 'OOP', 1: 'OOP', 3: 'DB', 4: 'DB', 6: 'ENG', 9: '' }, 1: { 1: 'OS', 2: 'OS', 5: 'SE', 6: 'SE', 8: 'DS' }, 2: { 0: 'MATH', 3: 'OOP', 4: 'OOP', 7: 'ENG' }, 3: { 2: 'DB', 3: 'DB', 6: 'OS', 7: 'OS', 9: 'CN' }, 4: { 1: 'SE', 4: 'DS', 5: 'DS', 8: 'MATH' } },
  1: { 0: { 2: 'DB', 3: 'DB', 7: 'SE', 8: 'SE' }, 1: { 0: 'OOP', 1: 'OOP', 4: 'ENG', 6: 'OS' }, 2: { 2: 'DS', 5: 'MATH', 6: 'MATH', 9: 'CN' }, 3: { 1: 'OOP', 2: 'OOP', 5: 'DB', 8: 'SE' }, 4: { 0: 'ENG', 3: 'OS', 4: 'OS', 7: 'DS' } },
  2: { 0: { 1: 'SE', 2: 'SE', 5: 'OOP', 6: 'OOP' }, 1: { 3: 'MATH', 4: 'MATH', 8: 'DB' }, 2: { 0: 'ENG', 2: 'OS', 3: 'OS', 7: 'DS' }, 3: { 1: 'OOP', 5: 'SE', 6: 'SE', 9: 'CN' }, 4: { 2: 'DB', 3: 'DB', 6: 'MATH', 8: 'ENG' } },
  3: { 0: { 0: 'DS', 1: 'DS', 4: 'OOP', 7: 'CN' }, 1: { 2: 'SE', 3: 'SE', 6: 'ENG', 9: 'DB' }, 2: { 1: 'MATH', 5: 'OS', 6: 'OS', 8: 'DS' }, 3: { 0: 'DB', 1: 'DB', 4: 'SE', 7: 'OOP' }, 4: { 3: 'ENG', 5: 'DS', 6: 'DS', 9: 'MATH' } },
  4: { 0: { 2: 'OOP', 3: 'OOP', 6: 'SE', 8: 'DS' }, 1: { 0: 'DB', 1: 'DB', 5: 'ENG', 7: 'CN' }, 2: { 4: 'SE', 5: 'SE', 8: 'MATH', 9: 'MATH' }, 3: { 2: 'OOP', 6: 'DB', 7: 'DB', 9: 'ENG' }, 4: { 1: 'OS', 2: 'OS', 4: 'DS', 8: 'SE' } },
  5: { 0: { 1: 'ENG', 4: 'DB', 5: 'DB', 8: 'OS' }, 1: { 3: 'SE', 4: 'SE', 7: 'OOP', 9: 'DS' }, 2: { 0: 'MATH', 2: 'CN', 6: 'OOP', 7: 'OOP' }, 3: { 1: 'ENG', 3: 'DS', 4: 'DS', 8: 'SE' }, 4: { 0: 'DB', 5: 'OS', 6: 'OS', 9: 'MATH' } },
  6: { 0: { 0: 'MATH', 3: 'SE', 6: 'OOP', 7: 'OOP' }, 1: { 2: 'DS', 4: 'DB', 5: 'DB', 9: 'CN' }, 2: { 1: 'ENG', 5: 'SE', 7: 'OS', 8: 'OS' }, 3: { 0: 'OOP', 1: 'OOP', 6: 'MATH', 9: 'ENG' }, 4: { 3: 'DS', 4: 'DS', 7: 'DB', 8: 'DB' } },
  7: { 0: { 2: 'CN', 5: 'OOP', 8: 'ENG' }, 1: { 1: 'DB', 2: 'DB', 6: 'SE', 9: 'DS' }, 2: { 0: 'OS', 4: 'MATH', 7: 'OOP', 8: 'OOP' }, 3: { 3: 'ENG', 5: 'DS', 6: 'DS', 9: 'SE' }, 4: { 2: 'DB', 5: 'OOP', 7: 'CN', 9: 'MATH' } },
};
