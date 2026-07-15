import { useState } from "react";

import Sidebar from "@/components/admin/layout/Sidebar";
import TopBar from "@/components/admin/layout/TopBar";

import Dashboard from "@/components/admin/Dashboard";
import RoomManagement from "@/components/admin/RoomManagement";
import BookingRequests from "@/components/admin/BookingRequests";
import UsersManagement from "@/components/admin/UsersManagement";
import Departments from "@/components/admin/Departments";
import TimetableManagement from "@/components/admin/TimetableManagement";
import Analytics from "@/components/admin/Analytics";
import Settings from "@/components/admin/Settings";

import type { ScreenType } from "@/types";
import { BOOKING_REQUESTS } from "@/constants/data";

const SIDEBAR_WIDTH = 260;
const TOPBAR_HEIGHT = 64;

export default function AdminPage() {

  const [activeScreen, setActiveScreen] =
    useState<ScreenType>("dashboard");

  const pendingCount =
    BOOKING_REQUESTS.filter(r => r.status === "pending").length;

  const renderScreen = () => {

    switch (activeScreen) {

      case "dashboard":
        return <Dashboard onNavigate={setActiveScreen} />;

      case "room-management":
        return <RoomManagement />;

      case "booking-requests":
        return <BookingRequests />;

      case "users":
        return <UsersManagement />;

      case "departments":
        return <Departments />;

      case "timetable":
        return <TimetableManagement />;

      case "analytics":
        return <Analytics />;

      case "settings":
        return <Settings />;

      default:
        return <Dashboard onNavigate={setActiveScreen} />;

    }

  };

  return (

    <div
      className="min-h-screen"
      style={{ background: "#f4f6f9" }}
    >

      <Sidebar
        active={activeScreen}
        onNavigate={setActiveScreen}
        pendingCount={pendingCount}
      />

      <TopBar
        activeScreen={activeScreen}
        onNavigate={setActiveScreen}
      />

      <main
        className="min-h-screen"
        style={{
          marginLeft: SIDEBAR_WIDTH,
          paddingTop: TOPBAR_HEIGHT,
        }}
      >

        <div className="p-6">

          {renderScreen()}

        </div>

      </main>

    </div>

  );

}