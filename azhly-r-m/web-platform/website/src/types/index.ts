export type ScreenType = 
  | 'dashboard'
  | 'room-management'
  | 'booking-requests'
  | 'users'
  | 'departments'
  | 'timetable'
  | 'analytics'
  | 'settings';

export interface BookingRequest {
  id: number;
  name: string;
  role: 'Student' | 'Faculty';
  roomNo: string;
  purpose: string;
  timeSlot: string;
  date: string;
  status: 'pending' | 'approved' | 'rejected';
}

export interface Room {
  id: string;

  roomNo: string;

  floorNo: string;
  blockName: string;

  department: string;
  roomType: string;

  timeSlot: string;

  status: 'available' | 'occupied' | 'regular-class' | 'reserved';

  label?: string;

  capacity?: number;
}

export interface User {
  id: string;
  name: string;
  role: 'Student' | 'Faculty' | 'HOD' | 'Dean' | 'Coordinator';
  department: string;
  batch?: string;
  semester?: string;
  email: string;
  status: 'active' | 'suspended';
}

export interface Department {
  id: string;
  name: string;
  shortName: string;
  facultyCount: number;
  blocks: string[];
  studentCount: number;
  head: string;
}

export interface Notification {
  id: number;
  type: 'booking' | 'room-status' | 'conflict';
  message: string;
  time: string;
  read: boolean;
}
