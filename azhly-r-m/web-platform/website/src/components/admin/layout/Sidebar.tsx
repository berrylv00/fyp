import { LayoutDashboard, DoorOpen, ClipboardList, Users, Building2, Calendar, Settings, LogOut, BarChart2 } from 'lucide-react';
import type { ScreenType } from '@/types';

interface SidebarProps {
  active: ScreenType;
  onNavigate: (screen: ScreenType) => void;
  pendingCount: number;
}

const navItems: { id: ScreenType; label: string; icon: React.ElementType }[] = [
  { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard },
  { id: 'room-management', label: 'Room Management', icon: DoorOpen },
  { id: 'booking-requests', label: 'Booking Requests', icon: ClipboardList },
  { id: 'timetable', label: 'Timetable Management', icon: Calendar },
  { id: 'users', label: 'Users', icon: Users },
  { id: 'departments', label: 'Departments', icon: Building2 },
  { id: 'analytics', label: 'Analytics', icon: BarChart2 },
  { id: 'settings', label: 'Settings', icon: Settings },
];

const Sidebar = ({ active, onNavigate, pendingCount }: SidebarProps) => {
  return (
    <aside
      className="fixed left-0 top-0 h-screen flex flex-col z-40"
      style={{ width: 260, background: '#001F5B' }}
    >
      {/* Logo */}
      <div className="flex items-center gap-3 px-5 py-5 border-b border-white/10">
        <img
          src="https://cdn-ai.onspace.ai/onspace/project/uploads/ijqHL9h4hGfvavooEfnMKp/pasted-image-1781258691576-1.png"
          alt="AZHly Logo"
          className="h-10 w-auto object-contain"
          style={{ filter: 'brightness(1.1)' }}
        />
      </div>

      {/* Nav */}
      <nav className="flex-1 py-4 overflow-y-auto">
        {navItems.map(({ id, label, icon: Icon }) => {
          const isActive = active === id;
          return (
            <button
              key={id}
              onClick={() => onNavigate(id)}
              className="w-full flex items-center gap-3 px-5 py-3 text-left transition-all duration-150 relative group"
              style={{
                background: isActive ? 'rgba(59,130,246,0.18)' : 'transparent',
                color: isActive ? '#fff' : '#8fa4c4',
                borderLeft: isActive ? '3px solid #3b82f6' : '3px solid transparent',
              }}
            >
              <Icon size={18} style={{ color: isActive ? '#3b82f6' : '#8fa4c4', flexShrink: 0 }} />
              <span className="text-sm font-medium">{label}</span>
              {id === 'booking-requests' && pendingCount > 0 && (
                <span
                  className="ml-auto text-xs font-bold rounded-full px-2 py-0.5"
                  style={{ background: '#ef4444', color: '#fff', minWidth: 22, textAlign: 'center' }}
                >
                  {pendingCount}
                </span>
              )}
              {!isActive && (
                <span
                  className="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity"
                  style={{ background: 'rgba(255,255,255,0.04)', pointerEvents: 'none' }}
                />
              )}
            </button>
          );
        })}
      </nav>

      {/* Logout */}
      <div className="p-4 border-t border-white/10">
        <button
          className="w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-colors text-sm font-medium"
          style={{ color: '#8fa4c4' }}
          onMouseEnter={e => { (e.currentTarget as HTMLButtonElement).style.background = 'rgba(239,68,68,0.12)'; (e.currentTarget as HTMLButtonElement).style.color = '#ef4444'; }}
          onMouseLeave={e => { (e.currentTarget as HTMLButtonElement).style.background = 'transparent'; (e.currentTarget as HTMLButtonElement).style.color = '#8fa4c4'; }}
        >
          <LogOut size={18} />
          <span>Logout</span>
        </button>
      </div>
    </aside>
  );
};

export default Sidebar;
