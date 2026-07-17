import { useEffect, useState } from "react";

import {
  Search,
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

    PENDING: {
      bg: "#FEF3C7",
      color: "#D97706",
      label: "Pending",
    },

    PROCESSING: {
      bg: "#DBEAFE",
      color: "#2563EB",
      label: "Processing",
    },

    WAITING_USER: {
      bg: "#F3E8D3",
      color: "#92400E",
      label: "Conflict Waiting",
    },

    APPROVED: {
      bg: "#DCFCE7",
      color: "#16A34A",
      label: "Approved",
    },

    REJECTED: {
      bg: "#FEE2E2",
      color: "#DC2626",
      label: "Rejected",
    },

  };

  const s = map[status] || map.PENDING;

  return (
    <span
      className="px-3 py-1 rounded-full text-xs font-semibold"
      style={{
        background:s.bg,
        color:s.color,
      }}
    >
      {s.label}
    </span>
  );
};
const smartEngineBadge = (stage: string) => {

  if (!stage) {

    return (
      <span className="text-slate-400 text-xs">
        —
      </span>
    );

  }

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
  const [filterStatus, setFilterStatus] = useState("all");
  const [search, setSearch] = useState("");

  const loadBookings = async () => {

    try {

      const data = await getAllBookings();

      setRequests(data);

    } catch {

      toast.error("Unable to load bookings.");

    }

  };

 useEffect(() => {

  // Load immediately
  loadBookings();

  // Refresh every 3 seconds
  const interval = setInterval(() => {
    loadBookings();
  }, 3000);

  // Cleanup
  return () => clearInterval(interval);

}, []);

  const filtered = requests.filter((r) => {

    const matchStatus =

      filterStatus === "all" ||

      r.status.toLowerCase() === filterStatus.toLowerCase();

    const matchSearch =

      r.studentName
        .toLowerCase()
        .includes(search.toLowerCase()) ||

      r.roomNo
        .toLowerCase()
        .includes(search.toLowerCase());

    return matchStatus && matchSearch;

  });

  const counts = {

    total: requests.length,

pending: requests.filter(
 r => r.status === "PENDING"
).length,

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

{/* =========================
        Heading
========================= */}

<div>

<h2 className="text-3xl font-bold text-slate-800">

Booking Requests

</h2>

<p className="text-slate-500 mt-2">

Monitor Smart Engine Room Allocation in Real Time

</p>

</div>

{/* =========================
      Summary Cards
========================= */}

<div className="grid grid-cols-2 lg:grid-cols-5 gap-4">

{[

{

title:"Total",

count:counts.total,

color:"#6366F1",

bg:"#EEF2FF"

},

{
title:"Pending",
count:counts.pending,
color:"#d5920c",
bg:"#f8f7ba"
},

{

title:"Processing",

count:counts.processing,

color:"#2563EB",

bg:"#DBEAFE"

},

{

title:"Waiting",

count:counts.waiting,

color:"#D97706",

bg:"#fee0c7"

},

{

title:"Approved",

count:counts.approved,

color:"#16A34A",

bg:"#DCFCE7"

},

{

title:"Rejected",

count:counts.rejected,

color:"#DC2626",

bg:"#FEE2E2"

}

].map(card=>(

<div

key={card.title}

className="rounded-3xl p-5 transition-all duration-300"

style={{

background:card.bg,

border:`2px solid ${card.color}`,

boxShadow:`0 10px 30px ${card.color}22`

}}

>

<p

className="text-sm font-semibold"

style={{

color:card.color

}}

>

{card.title}

</p>

<h2

className="text-3xl font-bold mt-2"

style={{

color:card.color

}}

>

{card.count}

</h2>

</div>

))}

</div>

{/* =========================
        Toolbar
========================= */}

<div

className="bg-white rounded-3xl p-5"

style={{

border:"1px solid #E2E8F0",

boxShadow:"0 10px 30px rgba(0,0,0,.05)"

}}

>

<div className="flex flex-wrap gap-4 justify-between">

{/* Search */}

<div

className="flex items-center gap-3 px-4 py-3 rounded-xl"

style={{

background:"#F8FAFC",

border:"1px solid #E2E8F0"

}}

>

<Search size={18}/>

<input

value={search}

onChange={(e)=>setSearch(e.target.value)}

placeholder="Search Student or Room..."

className="outline-none bg-transparent"

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

className="px-4 py-2 rounded-xl font-semibold transition-all"

style={{

background:

filterStatus===item

? "#071224"

: "#F1F5F9",

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

</div>
{/* Booking Cards */}

<div className="grid lg:grid-cols-2 gap-5 p-2">

{filtered.length===0 ? (

<div className="col-span-2 text-center py-20 text-slate-400">

No Booking Requests Found

</div>

) : (

filtered.map((r)=>{

const pending = r.status==="PENDING";
const processing = r.status==="PROCESSING";
const waiting = r.status==="WAITING_USER";
const approved = r.status==="APPROVED";
const rejected = r.status==="REJECTED";

return (

<div

key={r.id}

className="rounded-3xl p-6 transition-all duration-500"

style={{

background:

pending
? "#FFFBEB"

: processing
? "#EFF6FF"

: waiting
? "#F5EBDD"

: approved
? "#ECFDF5"

: "#FEF2F2",


border:

pending
? "2px solid #FACC15"

: processing
? "2px solid #60A5FA"

: waiting
? "2px solid #92400E"

: approved
? "2px solid #22C55E"

: "2px solid #EF4444",
}}

>

<div className="flex justify-between items-start">

<div>

<h3 className="text-xl font-bold text-slate-800">

{r.studentName}

</h3>

<p className="text-slate-500 mt-1">

📍 {r.roomNo}

</p>

</div>

{statusBadge(r.status)}

</div>

<div className="mt-5 space-y-2 text-sm text-slate-600">

<p>📅 {r.day}</p>

<p>🕒 {r.timeSlot}</p>

<p>📚 {r.purpose}</p>

</div>

<div className="mt-5">

<p className="text-xs font-bold text-slate-500 mb-2">

Smart Engine

</p>

{smartEngineBadge(r.smartEngineStage)}

{waiting && (
<div
className="mt-4 p-3 rounded-xl"
style={{
background:"#FEF3C7",
color:"#92400E"
}}
>

<p className="font-semibold text-sm">
⚠️ Conflict Detected
</p>

<p className="text-xs mt-1">
Room conflict with {r.conflictWith}
</p>

{r.alternateRoom && (
<p className="text-xs mt-1">
Suggested Room: {r.alternateRoom}
</p>
)}

</div>
)}

{(pending || processing || waiting) && (

<div className="mt-4">

<div

className="h-2 rounded-full overflow-hidden"

style={{

background:"#E2E8F0"

}}

>

<div

className="h-full rounded-full transition-all duration-700"

style={{

width:

pending
? "25%"

: processing

? "55%"

: "100%",

background:

processing

? "#3B82F6"

: "#F59E0B"

}}

>

</div>

</div>

</div>

)}

</div>

<div className="flex justify-end gap-3 mt-6">

{waiting && (

<button

className="px-5 py-2 rounded-xl text-white font-semibold"

style={{

background:"#7C3AED"

}}

>

Override

</button>

)}

{processing && (

<button

disabled

className="px-5 py-2 rounded-xl text-white"

style={{

background:"#3B82F6"

}}

>

Processing...

</button>

)}

{approved && (

<button

disabled

className="px-5 py-2 rounded-xl text-white"

style={{

background:"#22C55E"

}}

>

Approved

</button>

)}

{rejected && (

<button

disabled

className="px-5 py-2 rounded-xl text-white"

style={{

background:"#EF4444"

}}

>

Rejected

</button>

)}

</div>

</div>

);

})

)}

</div>

</div>
  )
};



export default BookingRequests;