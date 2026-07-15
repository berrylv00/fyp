import { useState } from 'react';
import { Wand2, AlertTriangle } from 'lucide-react';
import { TIMETABLE_COURSES, TIMETABLE_BATCHES, TIMETABLE_GRID } from '@/constants/data';
import { toast } from 'sonner';

const DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
const TIME_SLOTS = [
  { id: '08:00-09:00', label: '08:00 - 09:00' },
  { id: '09:00-10:00', label: '09:00 - 10:00' },
  { id: '10:00-11:00', label: '10:00 - 11:00' },
  { id: '11:00-12:00', label: '11:00 - 12:00' },
  { id: '12:00-13:00', label: '12:00 - 13:00' },
  { id: '13:00-14:00', label: '13:00 - 14:00' },
  { id: '14:00-15:00', label: '14:00 - 15:00' },
  { id: '15:00-16:00', label: '15:00 - 16:00' },
  { id: '16:00-17:00', label: '16:00 - 17:00' },
  { id: '17:00-18:00', label: '17:00 - 18:00' },
];

const getCourseStyle = (code: string) => {
  const c = TIMETABLE_COURSES.find(c => c.code === code);
  return c || null;
};

const TimetableManagement = () => {
  const [selectedRoom, setSelectedRoom] = useState('');
  const [selectedBatch, setSelectedBatch] = useState('');
  const [selectedTeacher, setSelectedTeacher] = useState('');
  const [selectedCourse, setSelectedCourse] = useState('');
  const [selectedTimeSlot, setSelectedTimeSlot] = useState('');
  const [generated, setGenerated] = useState(true);
  const [conflicts, setConflicts] = useState(2);

  const handleGenerate = () => {
    toast.success('Timetable optimized! 2 conflict(s) flagged.');
    setGenerated(true);
    setConflicts(2);
  };

  const visibleSlots = selectedTimeSlot ? TIME_SLOTS.filter(slot => slot.id === selectedTimeSlot) : TIME_SLOTS;

  return (
    <div className="space-y-5">
      <div>
        <h2 className="text-xl font-bold text-slate-800">Timetable Management</h2>
        <p className="text-sm text-slate-500 mt-0.5">Weekly master schedule generation and conflict resolution</p>
      </div>

      {/* Control Panel */}
      <div className="bg-white rounded-xl p-5" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
        <h3 className="text-sm font-semibold text-slate-700 mb-4">Schedule Configuration</h3>
        <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
          <div>
            <label className="block text-xs font-semibold text-slate-500 mb-1.5 uppercase tracking-wide">Room</label>
            <select value={selectedRoom} onChange={e => setSelectedRoom(e.target.value)} className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc', color: '#334155' }}>
              <option value="">All Rooms</option>
              {['B-101', 'B-112', 'B-205', 'B-213', 'B-301', 'B-305', 'B-409', 'A-101', 'C-101'].map(r => <option key={r}>{r}</option>)}
            </select>
          </div>
          <div>
            <label className="block text-xs font-semibold text-slate-500 mb-1.5 uppercase tracking-wide">Batch</label>
            <select value={selectedBatch} onChange={e => setSelectedBatch(e.target.value)} className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc', color: '#334155' }}>
              <option value="">All Batches</option>
              {TIMETABLE_BATCHES.map(b => <option key={b}>{b}</option>)}
            </select>
          </div>
          <div>
            <label className="block text-xs font-semibold text-slate-500 mb-1.5 uppercase tracking-wide">Teacher</label>
            <select value={selectedTeacher} onChange={e => setSelectedTeacher(e.target.value)} className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc', color: '#334155' }}>
              <option value="">All Teachers</option>
              {['Hina Malik', 'Fatima Zahra', 'Dr. Raheel Ahmad', 'Prof. Nadia Siddiqui', 'Prof. Kamran Shah'].map(t => <option key={t}>{t}</option>)}
            </select>
          </div>
          <div>
            <label className="block text-xs font-semibold text-slate-500 mb-1.5 uppercase tracking-wide">Course</label>
            <select value={selectedCourse} onChange={e => setSelectedCourse(e.target.value)} className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc', color: '#334155' }}>
              <option value="">All Courses</option>
              {TIMETABLE_COURSES.map(c => <option key={c.code}>{c.code}</option>)}
            </select>
          </div>
          <div>
            <label className="block text-xs font-semibold text-slate-500 mb-1.5 uppercase tracking-wide">Time Slot</label>
            <select value={selectedTimeSlot} onChange={e => setSelectedTimeSlot(e.target.value)} className="w-full px-3 py-2 rounded-lg text-sm outline-none" style={{ border: '1px solid #e5eaf2', background: '#f8fafc', color: '#334155' }}>
              <option value="">All Time Slots</option>
              {TIME_SLOTS.map(slot => <option key={slot.id} value={slot.id}>{slot.label}</option>)}
            </select>
          </div>
        </div>
        <div className="flex items-center gap-3 mt-4">
          <button onClick={handleGenerate} className="flex items-center gap-2 px-5 py-2.5 rounded-xl text-sm font-bold text-white transition-all hover:opacity-90" style={{ background: 'linear-gradient(135deg, #071224 0%, #1d4ed8 100%)' }}>
            <Wand2 size={16} /> Generate / Optimize Timetable
          </button>
          {conflicts > 0 && (
            <div className="flex items-center gap-2 px-3 py-2 rounded-lg text-xs font-semibold" style={{ background: '#fef3c7', color: '#d97706', border: '1px solid #fde68a' }}>
              <AlertTriangle size={14} /> {conflicts} conflict{conflicts > 1 ? 's' : ''} detected
            </div>
          )}
        </div>
      </div>

      {/* Legend */}
      <div className="flex flex-wrap gap-2 items-center">
        <span className="text-xs font-semibold text-slate-500 mr-1">Courses:</span>
        {TIMETABLE_COURSES.map(c => (
          <span key={c.code} className={`text-xs font-bold px-2.5 py-1 rounded-md border ${c.color} ${c.bg} ${c.border}`}>{c.code}</span>
        ))}
        <span className="ml-2 text-xs text-slate-400 px-2.5 py-1 rounded-md bg-slate-100 border border-slate-200">Empty = Free Slot</span>
      </div>

      {/* Timetable Grid */}
      <div className="bg-white rounded-xl overflow-hidden" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
        <div className="overflow-x-auto">
          <table style={{ minWidth: 900, borderCollapse: 'collapse', tableLayout: 'fixed' }}>
            <colgroup>
              <col style={{ width: 140 }} />
              {DAYS.flatMap(() => visibleSlots.map(() => <col key={Math.random()} style={{ width: 72 }} />))}
            </colgroup>
            <thead>
              {/* Day row */}
              <tr style={{ background: '#071224' }}>
                <th className="px-3 py-2 text-left text-xs font-semibold text-slate-300 whitespace-nowrap" style={{ borderRight: '1px solid rgba(255,255,255,0.1)' }}>
                  Lesson Grid / Room Supervision
                </th>
                {DAYS.map(day => (
                  <th key={day} colSpan={visibleSlots.length} className="py-2 text-center text-xs font-bold text-white" style={{ borderRight: '1px solid rgba(255,255,255,0.1)', borderLeft: '1px solid rgba(255,255,255,0.05)' }}>
                    {day}
                  </th>
                ))}
              </tr>
              {/* Slot numbers */}
              <tr style={{ background: '#0f1f38' }}>
                <th className="px-3 py-1.5" style={{ borderRight: '1px solid rgba(255,255,255,0.1)' }} />
                {DAYS.flatMap(day =>
                  visibleSlots.map((slot, index) => (
                    <th key={`${day}-${slot.id}`} className="text-center text-[10px] font-bold py-1.5" style={{ color: '#94a3b8', borderRight: index === visibleSlots.length - 1 ? '1px solid rgba(255,255,255,0.1)' : '1px solid rgba(255,255,255,0.05)', minWidth: 72 }}>
                      {slot.label}
                    </th>
                  ))
                )}
              </tr>
            </thead>
            <tbody>
              {TIMETABLE_BATCHES.map((batch, bIdx) => (
                <tr key={batch} style={{ borderBottom: '1px solid #f0f4f8', background: bIdx % 2 === 0 ? '#fff' : '#fafbfc' }}>
                  <td className="px-3 py-2 text-xs font-semibold text-slate-700 whitespace-nowrap sticky left-0" style={{ background: bIdx % 2 === 0 ? '#fff' : '#fafbfc', borderRight: '2px solid #e5eaf2', zIndex: 1 }}>
                    {batch}
                  </td>
                  {DAYS.flatMap((_, dIdx) =>
                    visibleSlots.map((_, sIdx) => {
                      const code = TIMETABLE_GRID[bIdx]?.[dIdx]?.[sIdx] || '';
                      const style = code ? getCourseStyle(code) : null;
                      const isConflict = code && bIdx < 2 && dIdx === 0 && sIdx === 0;
                      return (
                        <td
                          key={`${bIdx}-${dIdx}-${sIdx}`}
                          className="text-center p-0.5"
                          style={{ borderRight: sIdx === 9 ? '2px solid #e5eaf2' : '1px solid #f0f4f8', position: 'relative' }}
                        >
                          {code && style ? (
                            <div
                              className={`text-[10px] font-bold rounded px-0.5 py-0.5 ${style.color} ${style.bg} ${style.border} border`}
                              style={{ position: 'relative', outline: isConflict ? '2px solid #ef4444' : 'none' }}
                            >
                              {code}
                            </div>
                          ) : null}
                        </td>
                      );
                    })
                  )}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Conflict Alerts */}
      {generated && (
        <div className="space-y-2">
          <h3 className="text-sm font-semibold text-slate-700">Detected Conflicts</h3>
          {[
            '⚠️ Room B-213 has a timing conflict between Areeba Khan and Sara Noman (23 May 2025, 1:30 PM - 3:00 PM)',
            '⚠️ Room B-205 is double booked for 23 May 2025, 3:00 PM - 4:30 PM',
          ].map((msg, i) => (
            <div key={i} className="flex items-start gap-3 px-4 py-3 rounded-xl text-sm" style={{ background: '#fef2f2', border: '1px solid #fecaca', color: '#dc2626' }}>
              <AlertTriangle size={15} className="mt-0.5 flex-shrink-0" />
              <span>{msg}</span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default TimetableManagement;
