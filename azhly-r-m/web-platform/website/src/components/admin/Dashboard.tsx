import { Building2, CalendarCheck, Clock, AlertTriangle } from "lucide-react";
import type { ScreenType } from "@/types";

const admin = JSON.parse(localStorage.getItem("admin") || "{}");

const hour = new Date().getHours();

let greeting = "Good Morning ☀️";

if (hour >= 12 && hour < 17) {
  greeting = "Good Afternoon 🌤️";
} else if (hour >= 17 && hour < 21) {
  greeting = "Good Evening 🌇";
} else if (hour >= 21 || hour < 5) {
  greeting = "Good Night 🌙";
}

interface DashboardProps {
  onNavigate: (screen: ScreenType) => void;
}

const StatCard = ({
  icon: Icon,
  iconBg,
  value,
  label,
  sub,
  action,
  onAction,
}: {
  icon: React.ElementType;
  iconBg: string;
  value: string | number;
  label: string;
  sub?: string;
  action?: string;
  onAction?: () => void;
}) => (
  <div
    className="bg-white rounded-xl p-5 flex items-start gap-4"
    style={{
      border: "1px solid #e5eaf2",
      boxShadow: "0 1px 4px rgba(0,0,0,0.04)",
    }}
  >
    <div
      className="w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0"
      style={{ background: iconBg }}
    >
      <Icon size={22} className="text-white" />
    </div>

    <div className="flex-1">
      <p className="text-2xl font-bold text-slate-800">{value}</p>

      <p className="text-sm font-medium text-slate-600">{label}</p>

      {sub && (
        <p className="text-xs text-slate-400 mt-1">
          {sub}
        </p>
      )}

      {action && onAction && (
        <button
          onClick={onAction}
          className="mt-3 px-3 py-1 rounded-lg text-xs font-semibold text-white"
          style={{ background: "#3b82f6" }}
        >
          {action}
        </button>
      )}
    </div>
  </div>
);

const Dashboard = ({ onNavigate }: DashboardProps) => {
  return (
    <div className="space-y-6">

      {/* Welcome Card */}

      <div
        className="rounded-2xl p-7 text-white shadow-lg"
        style={{
          background:
            "linear-gradient(135deg,#001F5B,#2448A8,#5B6EF5)",
        }}
      >
        <h2 className="text-3xl font-bold">
          {greeting} {admin.adminName || "Admin"} 👋
        </h2>

        <p className="mt-3 text-indigo-100">
          Welcome back to <strong>AZHly Smart Room Allocation System</strong>.
        </p>

        <p className="text-indigo-200 mt-1 text-sm">
          Let's manage classrooms efficiently today.
        </p>
      </div>

      {/* Stats */}

      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">

        <StatCard
          icon={Building2}
          iconBg="#6366f1"
          value={13}
          label="Total Rooms"
          sub="one Block"
        />

        <StatCard
          icon={CalendarCheck}
          iconBg="#3b82f6"
          value={18}
          label="Today's Bookings"
          sub="All Rooms"
        />

        <StatCard
          icon={Clock}
          iconBg="#f59e0b"
          value={7}
          label="Pending Requests"
          sub="Approval Required"
          action="View"
          onAction={() => onNavigate("booking-requests")}
        />

        <StatCard
          icon={AlertTriangle}
          iconBg="#ef4444"
          value={3}
          label="Conflicts"
          sub="Need Attention"
          action="View"
          onAction={() => onNavigate("booking-requests")}
        />

      </div>

    </div>
  );
};

export default Dashboard;