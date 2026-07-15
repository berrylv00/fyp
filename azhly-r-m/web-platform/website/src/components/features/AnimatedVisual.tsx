import { useEffect, useState } from 'react';

// 1. Types & Data Definition
interface BubbleProps {
  label: string;
  icon: React.ReactNode;
  className: string; // Absolute positions matching your exact layout
  bgColor: string;
  floatClass?: string;
}

const bubbleItems: BubbleProps[] = [
  {
    label: 'Cloud Based',
    icon: (
      <svg viewBox="0 0 24 24" className="w-5 h-5" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M19 18H6a4 4 0 010-8c.6 0 1.15.14 1.65.37A6 6 0 1120 16h-1z" fill="white" opacity="0.95" />
      </svg>
    ),
    className: 'top-[8%] left-[28%]',
    bgColor: 'bg-brand-purple',
    floatClass: 'animate-float-a',
  },
  {
    label: 'Room Finding',
    icon: (
      <svg viewBox="0 0 24 24" className="w-5 h-5" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7z" fill="white" opacity="0.95" />
        <circle cx="12" cy="9" r="2.5" fill="white" />
      </svg>
    ),
    className: 'top-[8%] right-[28%]',
    bgColor: 'bg-sky-500',
    floatClass: 'animate-float-b',
  },
  {
    label: 'Timetable',
    icon: (
      <svg viewBox="0 0 24 24" className="w-5 h-5" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect x="4" y="5" width="16" height="15" rx="3" stroke="white" strokeWidth="1.7" fill="rgba(255,255,255,0.12)" />
        <path d="M8 3V7" stroke="white" strokeWidth="1.8" strokeLinecap="round" />
        <path d="M16 3V7" stroke="white" strokeWidth="1.8" strokeLinecap="round" />
        <path d="M8.5 12H15.5" stroke="#ffffff" strokeWidth="1.6" strokeLinecap="round" />
        <path d="M8.5 16H15.5" stroke="#ffffff" strokeWidth="1.6" strokeLinecap="round" />
      </svg>
    ),
    className: 'left-[8%] top-[50%] -translate-y-1/2',
    bgColor: 'bg-orange-500',
    floatClass: 'animate-float-c',
  },
  {
    label: 'Calendar',
    icon: (
      <svg viewBox="0 0 24 24" className="w-5 h-5" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M6 4H18C19.1046 4 20 4.89543 20 6V18C20 19.1046 19.1046 20 18 20H6C4.89543 20 4 19.1046 4 18V6C4 4.89543 4.89543 4 6 4Z" stroke="white" strokeWidth="1.7" fill="rgba(255,255,255,0.12)" />
        <path d="M8 2V6" stroke="white" strokeWidth="1.8" strokeLinecap="round" />
        <path d="M16 2V6" stroke="white" strokeWidth="1.8" strokeLinecap="round" />
        <path d="M8.5 12H15.5" stroke="#ffffff" strokeWidth="1.6" strokeLinecap="round" />
      </svg>
    ),
    className: 'right-[8%] top-[50%] -translate-y-1/2',
    bgColor: 'bg-emerald-500',
    floatClass: 'animate-float-d',
  },
  {
    label: 'Notifications',
    icon: (
      <svg viewBox="0 0 24 24" className="w-5 h-5" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 22c1.1 0 2-.9 2-2h-4c0 1.1.9 2 2 2z" fill="white" opacity="0.95" />
        <path d="M18 16v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 10-3 0v.68C7.63 5.36 6 7.92 6 11v5l-1 1v1h14v-1l-1-1z" fill="#ffffff" />
      </svg>
    ),
    className: 'bottom-[4%] left-[50%] -translate-x-1/2',
    bgColor: 'bg-pink-500',
    floatClass: 'animate-float-b',
  },
];

export default function AnimatedVisual({ laptopImg }: { laptopImg: string }) {
  return (
    <div className="relative w-full max-w-[650px] h-[550px] mx-auto flex items-center justify-center overflow-visible select-none">
      
      {/* ─── 1. BACKGROUND GLOW EFFECT ─── */}
      <div className="absolute w-[300px] h-[300px] rounded-full bg-[radial-gradient(circle,_rgba(124,58,237,0.22),_transparent_65%)] blur-3xl pointer-events-none" />

      {/* ─── 2. THE MAIN ORBIT CIRCLE (subtle solid & blurred) ─── */}
      <div className="absolute w-[440px] h-[440px] rounded-full border border-purple-500/20 flex items-center justify-center pointer-events-none blur-sm opacity-60">
        
        {/* ─── 3. ROTATING DOT CONTROLLER ─── */}
        {/* Is div ko hum pure 360deg spin karwa rahe hain taake iske andar wale dots orbit par ghaumein */}
        <div className="absolute inset-0 animate-[spin_20s_linear_infinite]">
          
          {/* Moving Glowing Dot 1 (Top) */}
          <span className="absolute w-2.5 h-2.5 rounded-full bg-indigo-300 shadow-[0_0_15px_#a5b4fc,0_0_5px_#a5b4fc] left-1/2 top-0 -translate-x-1/2" />
          
          {/* Moving Glowing Dot 2 (Bottom) */}
          <span className="absolute w-2.5 h-2.5 rounded-full bg-indigo-300 shadow-[0_0_15px_#a5b4fc,0_0_5px_#a5b4fc] left-1/2 bottom-0 -translate-x-1/2" />
          
          {/* Moving Glowing Dot 3 (Right Center - exact as your image) */}
          <span className="absolute w-2.5 h-2.5 rounded-full bg-indigo-400 shadow-[0_0_15px_#818cf8,0_0_5px_#818cf8] right-0 top-1/2 -translate-y-1/2" />
        </div>
      </div>

      {/* ─── 4. CENTRAL LAPTOP PREVIEW (With Float Animation) ─── */}
      <div className="absolute z-20 w-[280px] sm:w-[320px] pointer-events-auto transition-transform duration-300 hover:scale-105">
        <img
          src={laptopImg}
          alt="Dashboard preview"
          className="w-full h-auto object-contain drop-shadow-[0_35px_50px_rgba(79,70,229,0.3)] animate-[float_4s_ease-in-out_infinite]"
        />
      </div>

      {/* ─── 5. FLOATING BUBBLES AND LABELS ─── */}
      {bubbleItems.map((item) => (
        <div 
          key={item.label} 
          className={`absolute ${item.className} z-30 flex flex-col items-center group cursor-pointer ${item.floatClass ?? ''}`}
        >
          {/* Bubble Icon Shell - solid accent color, subtle shadow, no glow */}
          <div className={`w-14 h-14 sm:w-16 sm:h-16 flex items-center justify-center rounded-full ${item.bgColor} text-white shadow-sm border border-white/10 transition-transform duration-300 group-hover:scale-105`}>
            {item.icon}
          </div>
          
          {/* Label Text below the bubble */}
          <div className="mt-2.5 w-max text-[11px] font-semibold text-white/70 tracking-widest uppercase transition-colors duration-200 group-hover:text-white">
            {item.label}
          </div>
        </div>
      ))}

      {/* ─── EXTRA CSS FOR FLOATING LAPTOP EFFECT ─── */}
      <style>{`
        @keyframes float {
          0%, 100% { transform: translateY(0px); }
          50% { transform: translateY(-12px); }
        }
      `}</style>

    </div>
  );
}