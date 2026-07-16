import { useEffect, useState } from "react";

import {
  Search,
  Filter,
  Cpu,
  ShieldAlert,
  CheckCircle2,
  XCircle,
  Clock3,
  Zap,
} from "lucide-react";

import {
  getAllBookings,
  approveBooking,
  rejectBooking,
} from "@/services/bookingService";

import { toast } from "sonner";

const statusBadge = (status: string) => {

  const map: Record<string, any> = {

    processing: {
      bg: "#dbeafe",
      color: "#2563eb",
      label: "Processing",
    },

    waiting_user: {
      bg: "#fef3c7",
      color: "#d97706",
      label: "Waiting User",
    },

    approved: {
      bg: "#dcfce7",
      color: "#16a34a",
      label: "Approved",
    },

    rejected: {
      bg: "#fee2e2",
      color: "#dc2626",
      label: "Rejected",
    },
  };

  const s = map[status.toLowerCase()] || map.processing;

  return (

    <span
      className="px-3 py-1 rounded-full text-xs font-semibold"
      style={{
        background: s.bg,
        color: s.color,
      }}
    >
      {s.label}
    </span>

  );

};

const smartEngineBadge = (stage: string) => {

  if (!stage)
    return (
      <span className="text-slate-400 text-xs">
        —
      </span>
    );

  if (stage.includes("Reading")) {

    return (
      <div className="flex items-center gap-2 text-blue-600">

        <Clock3 size={15} />

        <span className="text-xs font-medium">
          {stage}
        </span>

      </div>
    );

  }

  if (stage.includes("Checking")) {

    return (
      <div className="flex items-center gap-2 text-purple-600">

        <Cpu size={15} />

        <span className="text-xs font-medium">
          {stage}
        </span>

      </div>
    );

  }

  if (stage.includes("Waiting")) {

    return (
      <div className="flex items-center gap-2 text-orange-600">

        <ShieldAlert size={15} />

        <span className="text-xs font-medium">
          {stage}
        </span>

      </div>
    );

  }

  if (stage.includes("Completed")) {

    return (
      <div className="flex items-center gap-2 text-green-600">

        <CheckCircle2 size={15} />

        <span className="text-xs font-medium">
          Completed
        </span>

      </div>
    );

  }

  return (

    <div className="flex items-center gap-2">

      <Zap size={15} />

      <span className="text-xs">
        {stage}
      </span>

    </div>

  );

};

const BookingRequests = () => {

  const [requests, setRequests] = useState<any[]>([]);

  const [filterStatus, setFilterStatus] =
    useState("all");

  const [search, setSearch] =
    useState("");
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

  const filtered = requests.filter((r) => {

    const matchStatus =
      filterStatus === "all" ||
      r.status.toLowerCase() ===
      filterStatus.toLowerCase();

    const matchSearch =
      r.studentName
        .toLowerCase()
        .includes(search.toLowerCase()) ||

      r.roomNo
        .toLowerCase()
        .includes(search.toLowerCase());

    return matchStatus && matchSearch;

  });

  const approve = async (id: number) => {

    try {

      await approveBooking(id);

      toast.success("Booking Approved");

      loadBookings();

    } catch {

      toast.error("Approval Failed");

    }

  };

  const reject = async (id: number) => {

    try {

      await rejectBooking(id);

      toast.success("Booking Rejected");

      loadBookings();

    } catch {

      toast.error("Rejection Failed");

    }

  };

  const counts = {

    all: requests.length,

    processing: requests.filter(
      r => r.status === "PROCESSING"
    ).length,

    waiting: requests.filter(
      r => r.status === "WAITING_USER"
    ).length,

    approved: requests.filter(
      r => r.status === "APPROVED"
    ).length,

    rejected: requests.filter(
      r => r.status === "REJECTED"
    ).length,

  };


  return (

<div className="space-y-6">

    {/* Heading */}

    <div>

        <h2 className="text-2xl font-bold text-slate-800">

            Booking Requests

        </h2>

        <p className="text-slate-500 mt-1">

            Manage Smart Room Booking Requests

        </p>

    </div>


    {/* Summary Cards */}

    <div className="grid grid-cols-2 lg:grid-cols-5 gap-4">

        {[
            {
                label:"Total",
                count:counts.all,
                color:"#6366f1",
                bg:"#eef2ff"
            },

            {
                label:"Processing",
                count:counts.processing,
                color:"#2563eb",
                bg:"#dbeafe"
            },

            {
                label:"Waiting",
                count:counts.waiting,
                color:"#d97706",
                bg:"#fef3c7"
            },

            {
                label:"Approved",
                count:counts.approved,
                color:"#16a34a",
                bg:"#dcfce7"
            },

            {
                label:"Rejected",
                count:counts.rejected,
                color:"#dc2626",
                bg:"#fee2e2"
            }

        ].map(card=>(

            <div

                key={card.label}

                className="bg-white rounded-xl p-4"

                style={{

                    border:"1px solid #e5eaf2",

                    boxShadow:"0 2px 5px rgba(0,0,0,.04)"

                }}

            >

                <p
                    className="text-sm font-medium"
                    style={{color:card.color}}
                >

                    {card.label}

                </p>

                <h2
                    className="text-3xl font-bold mt-2"
                    style={{color:card.color}}
                >

                    {card.count}

                </h2>

            </div>

        ))}

    </div>


    {/* Toolbar */}

    <div

        className="bg-white rounded-xl"

        style={{

            border:"1px solid #e5eaf2",

            boxShadow:"0 2px 5px rgba(0,0,0,.04)"

        }}

    >

        <div

            className="flex flex-wrap justify-between items-center gap-4 p-5"

        >

            {/* Search */}

            <div

                className="flex items-center gap-2 px-3 py-2 rounded-lg"

                style={{

                    border:"1px solid #e5eaf2",

                    background:"#f8fafc"

                }}

            >

                <Search

                    size={16}

                    className="text-slate-400"

                />

                <input

                    value={search}

                    onChange={(e)=>setSearch(e.target.value)}

                    placeholder="Search Student or Room..."

                    className="outline-none bg-transparent text-sm"

                />

            </div>


            {/* Filters */}

            <div className="flex gap-2 flex-wrap">

                {[
                    "all",

                    "processing",

                    "waiting_user",

                    "approved",

                    "rejected"

                ].map(item=>(

                    <button

                        key={item}

                        onClick={()=>setFilterStatus(item)}

                        className="px-3 py-1 rounded-lg text-sm font-medium"

                        style={{

                            background:

                                filterStatus===item

                                ? "#071224"

                                : "#f1f5f9",

                            color:

                                filterStatus===item

                                ? "#fff"

                                : "#475569"

                        }}

                    >

                        {item.replace("_"," ")}

                    </button>

                ))}

            </div>

        </div>


        {/* Table */}

        <div className="overflow-x-auto">

            <table className="w-full">

                <thead>

                    <tr

                        style={{

                            background:"#f8fafc"

                        }}

                    >

                        {[
                            "#",

                            "Student",

                            "Room",

                            "Day",

                            "Time",

                            "Purpose",

                            "Smart Engine",

                            "Status",

                            "Actions"

                        ].map(head=>(

                            <th

                                key={head}

                                className="px-4 py-3 text-left text-xs uppercase text-slate-500"

                            >

                                {head}

                            </th>

                        ))}

                    </tr>

                </thead>

                <tbody>
                  {filtered.length === 0 ? (

  <tr>
    <td
      colSpan={9}
      className="text-center py-10 text-slate-400"
    >
      No Booking Requests Found
    </td>
  </tr>

) : (

  filtered.map((r, index) => (

    <tr
      key={r.id}
      className="border-t hover:bg-slate-50"
    >

      <td className="px-4 py-3">
        {index + 1}
      </td>

      <td className="px-4 py-3 font-semibold">
        {r.studentName}
      </td>

      <td className="px-4 py-3">
        {r.roomNo}
      </td>

      <td className="px-4 py-3">
        {r.day}
      </td>

      <td className="px-4 py-3">
        {r.timeSlot}
      </td>

      <td className="px-4 py-3">
        {r.purpose}
      </td>

      {/* Smart Engine */}

      <td className="px-4 py-3">

        {smartEngineBadge(r.smartEngineStage)}

      </td>

      {/* Status */}

      <td className="px-4 py-3">

        {statusBadge(r.status)}

      </td>

      {/* Actions */}

      <td className="px-4 py-3">

        {r.status === "WAITING_USER" ? (

          <button

            className="flex items-center gap-2 px-3 py-2 rounded-lg text-white text-xs font-semibold"

            style={{

              background:"#7c3aed"

            }}

          >

            <ShieldAlert size={15}/>

            Override

          </button>

        )

        : r.status==="PROCESSING" ? (

          <div
            className="flex items-center gap-2 text-blue-600"
          >

            <Clock3 size={15}/>

            Processing

          </div>

        )

        : r.status==="APPROVED" ? (

          <div
            className="flex items-center gap-2 text-green-600"
          >

            <CheckCircle2 size={16}/>

            Approved

          </div>

        )

        : (

          <div
            className="flex items-center gap-2 text-red-600"
          >

            <XCircle size={16}/>

            Rejected

          </div>

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
