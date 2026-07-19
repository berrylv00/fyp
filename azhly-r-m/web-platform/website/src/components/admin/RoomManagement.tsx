import { useState } from 'react';
import { Plus, X, Building, Layers, CheckCircle, XCircle, BookOpen, Lock } from 'lucide-react';
import api from "@/services/api";
import { useEffect } from "react";
import type { Room } from '@/types';

const statusConfig = {
  AVAILABLE: { label: 'Available', bg: '#dcfce7', color: '#16a34a', icon: CheckCircle },
  OCCUPIED: { label: 'Occupied', bg: '#fee2e2', color: '#dc2626', icon: XCircle },

  RESERVED: { label: 'Reserved', bg: '#fef3c7', color: '#d97706', icon: Lock },
};

const RoomCard = ({ room }: { room: Room }) => {
  const cfg = statusConfig[room.status];
  const Icon = cfg.icon;
  return (
    <div className="bg-white rounded-xl p-4 flex flex-col gap-3 transition-shadow hover:shadow-md" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 3px rgba(0,0,0,0.04)' }}>
      <div className="flex items-start justify-between">
        <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: '#f0f4ff' }}>
          <Building size={18} style={{ color: '#3b82f6' }} />
        </div>
        <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ background: cfg.bg, color: cfg.color }}>
          <span className="flex items-center gap-1"><Icon size={11} />{cfg.label}</span>
        </span>
      </div>
      <div>
        <p className="text-base font-bold text-slate-800">Room {room.roomNo}</p>
        {room.label && <p className="text-xs font-medium mt-0.5" style={{ color: '#d97706' }}>{room.label}</p>}
      </div>
      <div className="flex items-center gap-4 text-xs text-slate-500">
    <span className="flex items-center gap-1">
        <Layers size={11}/>
        {room.floorNo}
    </span>

    <span>{room.blockName}</span>

    {room.capacity && (
        <span className="ml-auto">
            Cap: {room.capacity}
        </span>
    )}
</div>

<div className="mt-2 space-y-1 text-xs text-slate-500">

    <p>🕒 {room.timeSlot}</p>

    <p>🏫 {room.department}</p>

    <p>📚 {room.roomType}</p>

</div>
    </div>
  );
};

const AddRoomModal = ({ onClose, onAdd }: { onClose: () => void; onAdd: (r: Room) => void }) => {
 const [form, setForm] = useState({
    roomNo: "",
    floorNo: "1st Floor",
    blockName: "Block B",
    department: "Computer Science",
    roomType: "Lecture Room",
    timeSlot: "08:40 AM - 10:10 AM",
    status: "AVAILABLE" as Room["status"],
    label: "",
    capacity: ""
});
  const submit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!form.roomNo) return;
    onAdd({ id: Date.now().toString(), ...form, capacity: form.capacity ? Number(form.capacity) : 30 });
    onClose();
  };
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4" style={{ background: 'rgba(0,0,0,0.4)' }}>
      <div className="bg-white rounded-2xl w-full max-w-md" style={{ boxShadow: '0 20px 60px rgba(0,0,0,0.2)' }}>
        <div className="flex items-center justify-between px-6 py-4" style={{ borderBottom: '1px solid #f0f4f8' }}>
          <h3 className="font-bold text-slate-800">Add New Room</h3>
          <button onClick={onClose} className="w-8 h-8 rounded-full flex items-center justify-center hover:bg-slate-100"><X size={16} /></button>
        </div>
        <form onSubmit={submit} className="p-6 space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-semibold text-slate-600 mb-1.5">Room Number *</label>
              <input required value={form.roomNo} onChange={e => setForm(p => ({ ...p, roomNo: e.target.value }))} placeholder="e.g. B-410" className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc' }} />
            </div>
            <div>
              <label className="block text-xs font-semibold text-slate-600 mb-1.5">Capacity</label>
              <input type="number" value={form.capacity} onChange={e => setForm(p => ({ ...p, capacity: e.target.value }))} placeholder="30" className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc' }} />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-semibold text-slate-600 mb-1.5">Floor</label>
              <select value={form.floorNo} onChange={e => setForm(p => ({ ...p, floorNo: e.target.value }))} className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc' }}>
                {['1st Floor', '2nd Floor', '3rd Floor', '4th Floor'].map(f => <option key={f}>{f}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-xs font-semibold text-slate-600 mb-1.5">Block</label>
              <select value={form.blockName} onChange={e => setForm(p => ({ ...p, blockName: e.target.value }))} className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc' }}>
                {['Block A', 'Block B', 'Block C'].map(b => <option key={b}>{b}</option>)}
              </select>
            </div>
          </div>
          <div>
            <label className="block text-xs font-semibold text-slate-600 mb-1.5">Status</label>
            <select value={form.status} onChange={e => setForm(p => ({ ...p, status: e.target.value as Room['status'] }))} className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc' }}>
              <option value="available">Available</option>
              <option value="occupied">Occupied</option>
              <option value="regular-class">Regular Class</option>
              <option value="reserved">Reserved</option>
            </select>
          </div>
          {form.status === 'reserved' && (
            <div>
              <label className="block text-xs font-semibold text-slate-600 mb-1.5">Reserved For</label>
              <input value={form.label} onChange={e => setForm(p => ({ ...p, label: e.target.value }))} placeholder="e.g. HOD Office - DS" className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc' }} />
            </div>
          )}
          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose} className="flex-1 py-2.5 rounded-lg text-sm font-semibold text-slate-600 transition-colors" style={{ border: '1px solid #e5eaf2' }}>Cancel</button>
            <button type="submit" className="flex-1 py-2.5 rounded-lg text-sm font-semibold text-white transition-colors" style={{ background: '#3b82f6' }}>Add Room</button>
          </div>
        </form>
      </div>
    </div>
  );
};

const RoomManagement = () => {
  const [rooms, setRooms] = useState<Room[]>([]);
  useEffect(() => {

    loadRooms();

}, []);

const loadRooms = async () => {

    try {

        const response = await api.get("/rooms");

        setRooms(response.data);

    }

    catch (error) {

        console.log(error);

    }

};
  const [showModal, setShowModal] = useState(false);
  const [filter, setFilter] = useState<string>('all');

  const filtered = filter === 'all' ? rooms : rooms.filter(r => r.status === filter);
  const counts = { all: rooms.length, available: rooms.filter(r => r.status === 'available').length, occupied: rooms.filter(r => r.status === 'occupied').length, 'regular-class': rooms.filter(r => r.status === 'regular-class').length, reserved: rooms.filter(r => r.status === 'reserved').length };

  return (
    <div className="space-y-5">
      <div className="flex flex-wrap items-center justify-between gap-4">
        <div>
          <h2 className="text-xl font-bold text-slate-800">Room Management</h2>
          <p className="text-sm text-slate-500 mt-0.5">{rooms.length} spaces across all blocks</p>
        </div>
        <button onClick={() => setShowModal(true)} className="flex items-center gap-2 px-4 py-2.5 rounded-xl text-sm font-semibold text-white transition-all" style={{ background: '#071224' }}>
          <Plus size={16} /> Add Room
        </button>
      </div>

      {/* Filter tabs */}
      <div className="flex flex-wrap gap-2">
        {[
          { key: 'all', label: 'All Rooms' },
          { key: 'available', label: 'Available' },
          { key: 'occupied', label: 'Occupied' },
          { key: 'regular-class', label: 'Regular Class' },
          { key: 'reserved', label: 'Reserved' },
        ].map(({ key, label }) => (
          <button
            key={key}
            onClick={() => setFilter(key)}
            className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold transition-all"
            style={{
              background: filter === key ? '#071224' : '#f0f4f8',
              color: filter === key ? '#fff' : '#475569',
              border: filter === key ? '1px solid #071224' : '1px solid #e5eaf2',
            }}
          >
            {label}
            <span className="rounded-full px-1.5 py-0.5 text-[10px] font-bold" style={{ background: filter === key ? 'rgba(255,255,255,0.2)' : '#e2e8f0', color: filter === key ? '#fff' : '#64748b' }}>
              {counts[key as keyof typeof counts]}
            </span>
          </button>
        ))}
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
        {filtered.map(room => <RoomCard key={room.id} room={room} />)}
      </div>

      {showModal && <AddRoomModal onClose={() => setShowModal(false)} onAdd={async (room) => {

    await api.post("/rooms", room);

    loadRooms();

}} />}
    </div>
  );
};

export default RoomManagement;
