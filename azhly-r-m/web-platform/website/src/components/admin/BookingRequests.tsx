import { useEffect, useState } from "react";
import {Search, Filter, Cpu, ShieldAlert, CheckCircle2, XCircle, Clock3, Zap } from "lucide-react";
import {getAllBookings, approveBooking, rejectBooking } from "@/services/bookingService";

import { toast } from 'sonner';

const statusBadge = (status: string) => {
  const map: Record<string, { bg: string; color: string; label: string }> = {
    pending: { bg: '#fef3c7', color: '#d97706', label: 'Pending' },
    approved: { bg: '#dcfce7', color: '#16a34a', label: 'Approved' },
    rejected: { bg: '#fee2e2', color: '#dc2626', label: 'Rejected' },
    rescheduled: { bg: '#ede9fe', color: '#7c3aed', label: 'Rescheduled' },
  };
  const s = map[status] || map.pending;
  return <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ background: s.bg, color: s.color }}>{s.label}</span>;
};

const BookingRequests = () => {
  const [requests, setRequests] = useState<any[]>([]);
  const [filterStatus, setFilterStatus] = useState<string>('all');
  const [search, setSearch] = useState('');
  const loadBookings = async () => {

    try {

        const data = await getAllBookings();

        setRequests(data);

    } catch (error) {

        console.error(error);

        toast.error("Unable to load bookings.");

    }

};
useEffect(() => {

    loadBookings();

}, []);

  const filtered = requests.filter(r => {
    const matchStatus = filterStatus === 'all' || r.status.toLowerCase() === filterStatus.toLowerCase();
    const matchSearch = r.studentName.toLowerCase().includes(search.toLowerCase()) || r.roomNo.toLowerCase().includes(search.toLowerCase());
    return matchStatus && matchSearch;
  });

 const approve = async (id:number)=>{

    try{

        await approveBooking(id);

        toast.success("Booking Approved");

        loadBookings();

    }

    catch{

        toast.error("Approval Failed");

    }

}
  const reject = async (id:number)=>{

    try{

        await rejectBooking(id);

        toast.success("Booking Rejected");

        loadBookings();

    }

    catch{

        toast.error("Rejection Failed");

    }

}

  const counts = {
    all: requests.length,
    pending: requests.filter(r => r.status.toLowerCase() === 'pending').length,
    approved: requests.filter(r => r.status.toLowerCase() === 'approved').length,
    rejected: requests.filter(r => r.status.toLowerCase() === 'rejected').length,
  };

  return (
    <div className="space-y-5">
      <div>
        <h2 className="text-xl font-bold text-slate-800">Booking Requests</h2>
        <p className="text-sm text-slate-500 mt-0.5">Manage all room reservation submissions</p>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[
          { label: 'Total', count: counts.all, color: '#6366f1', bg: '#eef2ff' },
          { label: 'Pending', count: counts.pending, color: '#d97706', bg: '#fef3c7' },
          { label: 'Approved', count: counts.approved, color: '#16a34a', bg: '#dcfce7' },
          { label: 'Rejected', count: counts.rejected, color: '#dc2626', bg: '#fee2e2' },
        ].map(({ label, count, color, bg }) => (
          <div key={label} className="bg-white rounded-xl p-4 flex items-center gap-3" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 3px rgba(0,0,0,0.04)' }}>
            <div className="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0" style={{ background: bg }}>
              <span className="text-lg font-bold" style={{ color }}>{count}</span>
            </div>
            <p className="text-sm font-semibold text-slate-600">{label}</p>
          </div>
        ))}
      </div>

      {/* Toolbar */}
      <div className="bg-white rounded-xl" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
        <div className="flex flex-wrap items-center justify-between gap-3 px-5 py-4" style={{ borderBottom: '1px solid #f0f4f8' }}>
          <div className="flex items-center gap-2 rounded-lg px-3 py-2" style={{ background: '#f8fafc', border: '1px solid #e5eaf2' }}>
            <Search size={14} className="text-slate-400" />
            <input value={search} onChange={e => setSearch(e.target.value)} placeholder="Search by name or room..." className="bg-transparent outline-none text-sm text-slate-600 placeholder-slate-400 w-48" />
          </div>
          <div className="flex items-center gap-2">
            <Filter size={14} className="text-slate-400" />
            {['all', 'pending', 'approved', 'rejected'].map(s => (
              <button key={s} onClick={() => setFilterStatus(s)} className="px-3 py-1.5 rounded-lg text-xs font-semibold capitalize transition-all" style={{ background: filterStatus === s ? '#071224' : '#f0f4f8', color: filterStatus === s ? '#fff' : '#475569', border: filterStatus === s ? '1px solid #071224' : '1px solid #e5eaf2' }}>
                {s === 'all' ? 'All' : s.charAt(0).toUpperCase() + s.slice(1)}
              </button>
            ))}
          </div>
        </div>

        {/* Table */}
               {/* Table */}
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr style={{ background: "#f8fafc" }}>
                {[
                  "#",
                  "Student",
                  "Role",
                  "Room No",
                  "Purpose",
                  "Day",
                  "Time Slot",
                  "Status",
                  "Actions",
                ].map((h) => (
                  <th
                    key={h}
                    className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide whitespace-nowrap"
                  >
                    {h}
                  </th>
                ))}
              </tr>
            </thead>

            <tbody>
              {filtered.length === 0 ? (
                <tr>
                  <td
                    colSpan={9}
                    className="px-4 py-12 text-center text-sm text-slate-400"
                  >
                    No booking requests found.
                  </td>
                </tr>
              ) : (
                filtered.map((r, i) => (
                  <tr
                    key={r.id}
                    style={{ borderTop: "1px solid #f0f4f8" }}
                    className="hover:bg-slate-50 transition-colors"
                  >
                    <td className="px-4 py-3.5 text-sm text-slate-400">
                      {i + 1}
                    </td>

                    {/* Student Name */}
                    <td className="px-4 py-3.5">
                      <p className="text-sm font-semibold text-slate-700 whitespace-nowrap">
                        {r.studentName}
                      </p>
                    </td>

                    {/* Role */}
                    <td className="px-4 py-3.5">
                      <span
                        className="text-xs font-medium px-2 py-0.5 rounded-full"
                        style={{
                          background: "#dbeafe",
                          color: "#1d4ed8",
                        }}
                      >
                        Student
                      </span>
                    </td>

                    {/* Room */}
                    <td
                      className="px-4 py-3.5 text-sm font-bold"
                      style={{ color: "#3b82f6" }}
                    >
                      {r.roomNo}
                    </td>

                    {/* Purpose */}
                    <td className="px-4 py-3.5 text-sm text-slate-600">
                      Room Booking
                    </td>

                    {/* Day */}
                    <td className="px-4 py-3.5 text-xs text-slate-500 whitespace-nowrap">
                      {r.day}
                    </td>

                    {/* Time */}
                    <td className="px-4 py-3.5 text-xs text-slate-600 whitespace-nowrap">
                      {r.timeSlot}
                    </td>

                    {/* Status */}
                    <td className="px-4 py-3.5">
                      {statusBadge(r.status.toLowerCase())}
                    </td>

                    {/* Actions */}
                    <td className="px-4 py-3.5">
                      {r.status.toLowerCase() === "pending" ? (
                        <div className="flex items-center gap-1.5">
                          <button
                            onClick={() => approve(r.id)}
                            title="Approve"
                            className="w-7 h-7 rounded-lg flex items-center justify-center hover:scale-105"
                            style={{ background: "#dcfce7" }}
                          >
                            <Check
                              size={13}
                              className="text-green-700"
                            />
                          </button>

                          <button
                            onClick={() => reject(r.id)}
                            title="Reject"
                            className="w-7 h-7 rounded-lg flex items-center justify-center hover:scale-105"
                            style={{ background: "#fee2e2" }}
                          >
                            <X
                              size={13}
                              className="text-red-700"
                            />
                          </button>
                        </div>
                      ) : (
                        <span className="text-xs text-slate-400">—</span>
                      )}
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
        </div>
      </div>
    
  );
};

export default BookingRequests;
