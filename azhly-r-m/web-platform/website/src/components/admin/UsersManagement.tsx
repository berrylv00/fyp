import { useState } from 'react';
import { Edit, UserX, Calendar, Search, Users, GraduationCap, Briefcase, Shield } from 'lucide-react';
import { USERS } from '@/constants/data';
import type { User } from '@/types';
import { toast } from 'sonner';

const roleColors: Record<string, { bg: string; color: string }> = {
  Student: { bg: '#dbeafe', color: '#1d4ed8' },
  Faculty: { bg: '#d1fae5', color: '#065f46' },
  HOD: { bg: '#ede9fe', color: '#6d28d9' },
  Dean: { bg: '#fce7f3', color: '#9d174d' },
  Coordinator: { bg: '#fff7ed', color: '#c2410c' },
};

const UsersManagement = () => {
  const [users, setUsers] = useState<User[]>(USERS);
  const [activeTab, setActiveTab] = useState<'all' | 'Student' | 'Faculty' | 'Management'>('all');
  const [search, setSearch] = useState('');

  const filtered = users.filter(u => {
    const matchSearch = u.name.toLowerCase().includes(search.toLowerCase()) || u.department.toLowerCase().includes(search.toLowerCase());
    if (activeTab === 'all') return matchSearch;
    if (activeTab === 'Management') return matchSearch && ['HOD', 'Dean', 'Coordinator'].includes(u.role);
    return matchSearch && u.role === activeTab;
  });

  const toggleSuspend = (id: string) => {
    setUsers(p => p.map(u => u.id === id ? { ...u, status: u.status === 'active' ? 'suspended' : 'active' } : u));
    const user = users.find(u => u.id === id);
    toast.info(`${user?.name} ${user?.status === 'active' ? 'suspended' : 'reactivated'}`);
  };

  const tabCounts = {
    all: users.length,
    Student: users.filter(u => u.role === 'Student').length,
    Faculty: users.filter(u => u.role === 'Faculty').length,
    Management: users.filter(u => ['HOD', 'Dean', 'Coordinator'].includes(u.role)).length,
  };

  const tabs = [
    { key: 'all' as const, label: 'All Users', icon: Users },
    { key: 'Student' as const, label: 'Students', icon: GraduationCap },
    { key: 'Faculty' as const, label: 'Faculty', icon: Briefcase },
    { key: 'Management' as const, label: 'Management', icon: Shield },
  ];

  return (
    <div className="space-y-5">
      <div>
        <h2 className="text-xl font-bold text-slate-800">Users Management</h2>
        <p className="text-sm text-slate-500 mt-0.5">Manage all stakeholders across the institution</p>
      </div>

      {/* Stat chips */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {tabs.map(({ key, label, icon: Icon }) => (
          <div key={key} className="bg-white rounded-xl p-4 flex items-center gap-3" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 3px rgba(0,0,0,0.04)' }}>
            <div className="w-9 h-9 rounded-lg flex items-center justify-center" style={{ background: '#f0f4ff' }}>
              <Icon size={16} style={{ color: '#3b82f6' }} />
            </div>
            <div>
              <p className="text-xl font-bold text-slate-800">{tabCounts[key]}</p>
              <p className="text-xs text-slate-500">{label}</p>
            </div>
          </div>
        ))}
      </div>

      <div className="bg-white rounded-xl" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
        {/* Toolbar */}
        <div className="flex flex-wrap items-center justify-between gap-3 px-5 py-4" style={{ borderBottom: '1px solid #f0f4f8' }}>
          <div className="flex gap-1.5">
            {tabs.map(({ key, label }) => (
              <button key={key} onClick={() => setActiveTab(key)} className="px-3 py-1.5 rounded-lg text-xs font-semibold transition-all" style={{ background: activeTab === key ? '#071224' : '#f0f4f8', color: activeTab === key ? '#fff' : '#475569', border: activeTab === key ? '1px solid #071224' : '1px solid #e5eaf2' }}>
                {label}
              </button>
            ))}
          </div>
          <div className="flex items-center gap-2 rounded-lg px-3 py-2" style={{ background: '#f8fafc', border: '1px solid #e5eaf2' }}>
            <Search size={14} className="text-slate-400" />
            <input value={search} onChange={e => setSearch(e.target.value)} placeholder="Search users..." className="bg-transparent outline-none text-sm text-slate-600 placeholder-slate-400 w-40" />
          </div>
        </div>

        {/* Table */}
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr style={{ background: '#f8fafc' }}>
                {['#', 'Name', 'Role', 'Department', 'Batch / Semester', 'Email', 'Status', 'Actions'].map(h => (
                  <th key={h} className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide whitespace-nowrap">{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {filtered.length === 0 && (
                <tr><td colSpan={8} className="px-4 py-12 text-center text-sm text-slate-400">No users found.</td></tr>
              )}
              {filtered.map((u, i) => {
                const rc = roleColors[u.role] || roleColors.Student;
                return (
                  <tr key={u.id} style={{ borderTop: '1px solid #f0f4f8', opacity: u.status === 'suspended' ? 0.55 : 1 }} className="hover:bg-slate-50 transition-colors">
                    <td className="px-4 py-3.5 text-sm text-slate-400">{i + 1}</td>
                    <td className="px-4 py-3.5">
                      <div className="flex items-center gap-2.5">
                        <div className="w-8 h-8 rounded-full flex items-center justify-center text-xs font-bold text-white flex-shrink-0" style={{ background: '#071224' }}>
                          {u.name.charAt(0)}
                        </div>
                        <p className="text-sm font-semibold text-slate-700 whitespace-nowrap">{u.name}</p>
                      </div>
                    </td>
                    <td className="px-4 py-3.5">
                      <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ background: rc.bg, color: rc.color }}>{u.role}</span>
                    </td>
                    <td className="px-4 py-3.5 text-sm text-slate-600 whitespace-nowrap">{u.department}</td>
                    <td className="px-4 py-3.5 text-xs text-slate-500">
                      {u.batch ? `Batch ${u.batch}` : '—'}
                      {u.semester ? ` · ${u.semester} Sem` : ''}
                    </td>
                    <td className="px-4 py-3.5 text-xs text-slate-500">{u.email}</td>
                    <td className="px-4 py-3.5">
                      <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ background: u.status === 'active' ? '#dcfce7' : '#fee2e2', color: u.status === 'active' ? '#16a34a' : '#dc2626' }}>
                        {u.status === 'active' ? 'Active' : 'Suspended'}
                      </span>
                    </td>
                    <td className="px-4 py-3.5">
                      <div className="flex items-center gap-1.5">
                        <button title="Edit" className="w-7 h-7 rounded-lg flex items-center justify-center transition-colors" style={{ background: '#dbeafe' }} onClick={() => toast.info(`Editing ${u.name}`)}>
                          <Edit size={12} className="text-blue-700" />
                        </button>
                        <button title={u.status === 'active' ? 'Suspend' : 'Reactivate'} className="w-7 h-7 rounded-lg flex items-center justify-center transition-colors" style={{ background: '#fee2e2' }} onClick={() => toggleSuspend(u.id)}>
                          <UserX size={12} className="text-red-700" />
                        </button>
                        <button title="View Schedule" className="w-7 h-7 rounded-lg flex items-center justify-center transition-colors" style={{ background: '#ede9fe' }} onClick={() => toast.info(`Viewing schedule for ${u.name}`)}>
                          <Calendar size={12} className="text-purple-700" />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default UsersManagement;
