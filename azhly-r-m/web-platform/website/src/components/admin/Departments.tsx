import { ExternalLink, Users, MapPin, BookOpen } from 'lucide-react';
import { DEPARTMENTS } from '@/constants/data';
import { toast } from 'sonner';

const deptColors = [
  { gradient: 'linear-gradient(135deg, #1d4ed8 0%, #3b82f6 100%)', light: '#dbeafe', text: '#1d4ed8' },
  { gradient: 'linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%)', light: '#ede9fe', text: '#7c3aed' },
  { gradient: 'linear-gradient(135deg, #0f766e 0%, #2dd4bf 100%)', light: '#ccfbf1', text: '#0f766e' },
  { gradient: 'linear-gradient(135deg, #b45309 0%, #f59e0b 100%)', light: '#fef3c7', text: '#b45309' },
  { gradient: 'linear-gradient(135deg, #be185d 0%, #f472b6 100%)', light: '#fce7f3', text: '#be185d' },
  { gradient: 'linear-gradient(135deg, #065f46 0%, #34d399 100%)', light: '#d1fae5', text: '#065f46' },
  { gradient: 'linear-gradient(135deg, #1e40af 0%, #60a5fa 100%)', light: '#dbeafe', text: '#1e40af' },
  { gradient: 'linear-gradient(135deg, #92400e 0%, #fbbf24 100%)', light: '#fef9c3', text: '#92400e' },
];

const Departments = () => {
  return (
    <div className="space-y-5">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-xl font-bold text-slate-800">Departments</h2>
          <p className="text-sm text-slate-500 mt-0.5">All academic disciplines within the institute</p>
        </div>
        <div className="flex items-center gap-3 text-xs text-slate-500">
          <span className="font-semibold text-slate-700 text-base">{DEPARTMENTS.length}</span> Departments
        </div>
      </div>

      {/* Summary row */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[
          { label: 'Total Departments', value: DEPARTMENTS.length, color: '#3b82f6', bg: '#dbeafe' },
          { label: 'Total Faculty', value: DEPARTMENTS.reduce((s, d) => s + d.facultyCount, 0), color: '#7c3aed', bg: '#ede9fe' },
          { label: 'Total Students', value: DEPARTMENTS.reduce((s, d) => s + d.studentCount, 0), color: '#0f766e', bg: '#ccfbf1' },
          { label: 'Blocks Used', value: [...new Set(DEPARTMENTS.flatMap(d => d.blocks))].length, color: '#b45309', bg: '#fef3c7' },
        ].map(({ label, value, color, bg }) => (
          <div key={label} className="bg-white rounded-xl p-4 flex items-center gap-3" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 3px rgba(0,0,0,0.04)' }}>
            <div className="w-10 h-10 rounded-xl flex items-center justify-center" style={{ background: bg }}>
              <span className="text-lg font-bold" style={{ color }}>{value}</span>
            </div>
            <p className="text-xs font-semibold text-slate-600 leading-snug">{label}</p>
          </div>
        ))}
      </div>

      {/* Department Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5">
        {DEPARTMENTS.map((dept, i) => {
          const c = deptColors[i % deptColors.length];
          return (
            <div key={dept.id} className="bg-white rounded-2xl overflow-hidden transition-shadow hover:shadow-lg" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 4px rgba(0,0,0,0.06)' }}>
              {/* Header stripe */}
              <div className="h-2" style={{ background: c.gradient }} />
              <div className="p-5">
                <div className="flex items-start justify-between mb-4">
                  <div>
                    <div className="flex items-center gap-2 mb-1">
                      <span className="text-xs font-bold px-2 py-0.5 rounded-md" style={{ background: c.light, color: c.text }}>{dept.shortName}</span>
                    </div>
                    <h3 className="text-base font-bold text-slate-800">{dept.name}</h3>
                    <p className="text-xs text-slate-500 mt-0.5">Head: {dept.head}</p>
                  </div>
                  <button
                    onClick={() => toast.info(`Viewing schedule for ${dept.name}`)}
                    className="flex items-center gap-1 text-xs font-semibold px-2.5 py-1.5 rounded-lg transition-colors"
                    style={{ background: c.light, color: c.text }}
                  >
                    Schedule <ExternalLink size={11} />
                  </button>
                </div>

                {/* Stats */}
                <div className="grid grid-cols-3 gap-3">
                  <div className="rounded-xl p-3 text-center" style={{ background: '#f8fafc' }}>
                    <div className="flex items-center justify-center mb-1">
                      <Users size={13} className="text-slate-400" />
                    </div>
                    <p className="text-lg font-bold text-slate-800">{dept.facultyCount}</p>
                    <p className="text-[10px] text-slate-500 leading-tight">Faculty</p>
                  </div>
                  <div className="rounded-xl p-3 text-center" style={{ background: '#f8fafc' }}>
                    <div className="flex items-center justify-center mb-1">
                      <BookOpen size={13} className="text-slate-400" />
                    </div>
                    <p className="text-lg font-bold text-slate-800">{dept.studentCount}</p>
                    <p className="text-[10px] text-slate-500 leading-tight">Students</p>
                  </div>
                  <div className="rounded-xl p-3 text-center" style={{ background: '#f8fafc' }}>
                    <div className="flex items-center justify-center mb-1">
                      <MapPin size={13} className="text-slate-400" />
                    </div>
                    <p className="text-sm font-bold text-slate-800 leading-tight">{dept.blocks.join(', ')}</p>
                    <p className="text-[10px] text-slate-500 leading-tight">Blocks</p>
                  </div>
                </div>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
};

export default Departments;
