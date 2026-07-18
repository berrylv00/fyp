import { useNavigate } from "react-router-dom";
import { login } from "@/services/authService";
import { useState } from "react";
import { Eye, EyeOff, Lock, User } from "lucide-react";
import azhlyLogo from "@/assets/logo.png";

export default function LoginCard() {
  const [showPassword, setShowPassword] = useState(false);
  const [rememberMe, setRememberMe] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

 async function handleLogin(e: React.FormEvent) {
    e.preventDefault();

    try {
        setLoading(true);

        const response = await login({
            email,
            password,
        });

        console.log(response);

        localStorage.setItem("token", response.token);
        localStorage.setItem("admin", JSON.stringify({id: response.adminId, adminName: response.adminName, email: response.email, designation: response.designation}));
        console.log(response);
        console.log(JSON.parse(localStorage.getItem("admin")!));
        if (!localStorage.getItem("profileImage")) {
  localStorage.setItem(
    "profileImage",
    "https://i.pravatar.cc/150?img=12"
  );
}
        navigate("/admin");

    } catch (error: any) {

        alert(
            error?.response?.data?.message ||
            "Invalid username or password."
        );

    } finally {

        setLoading(false);

    }
}

  return (
    <div
      className="glass-card rounded-3xl p-8 w-full max-w-[420px] shadow-2xl"
      style={{
        background: "rgba(10, 7, 28, 0.92)",
        border: "1px solid rgba(255,255,255,0.08)",
        boxShadow: "0 40px 90px rgba(0, 0, 0, 0.32), 0 0 0 1px rgba(168, 85, 247, 0.08)",
      }}
    >
      {/* Logo */}
      <div className="flex items-center mb-6">
        <img
          src={azhlyLogo}
          alt="AZHly Logo"
          className="h-16 w-auto object-contain"
          style={{ filter: "drop-shadow(0 0 12px rgba(139,92,246,0.5))" }}
        />
      </div>

      {/* Heading */}
      <h2 className="text-white text-2xl font-bold mb-1">Welcome Back!</h2>
      <p className="text-white/50 text-sm mb-7">Sign in to continue to your dashboard</p>

      <form onSubmit={handleLogin} className="flex flex-col gap-4">
        {/* Username */}
        <div className="relative">
          <User className="absolute left-4 top-1/2 -translate-y-1/2 text-white/40 w-5 h-5" />
          <input
            type="text"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="input-dark w-full rounded-xl py-4 pl-12 pr-4 text-white placeholder-white/35 text-sm"
          />
        </div>

        {/* Password */}
        <div className="relative">
          <Lock className="absolute left-4 top-1/2 -translate-y-1/2 text-white/40 w-5 h-5" />
          <input
            type={showPassword ? "text" : "password"}
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="input-dark w-full rounded-xl py-4 pl-12 pr-12 text-white placeholder-white/35 text-sm"
          />
          <button
            type="button"
            onClick={() => setShowPassword(!showPassword)}
            className="absolute right-4 top-1/2 -translate-y-1/2 text-white/40 hover:text-white/70 transition-colors"
          >
            {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
          </button>
        </div>

        {/* Remember + Forgot */}
        <div className="flex items-center justify-between mt-1">
          <label className="flex items-center gap-2.5 cursor-pointer select-none">
            <div
              onClick={() => setRememberMe(!rememberMe)}
              className="w-5 h-5 rounded border flex items-center justify-center transition-all cursor-pointer"
              style={{
                border: "1.5px solid rgba(139,92,246,0.5)",
                background: rememberMe ? "linear-gradient(135deg,#7c3aed,#4f46e5)" : "rgba(255,255,255,0.05)",
              }}
            >
              {rememberMe && (
                <svg className="w-3 h-3 text-white" viewBox="0 0 12 12" fill="none">
                  <polyline points="2,6 5,9 10,3" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              )}
            </div>
            <span className="text-white/60 text-sm">Remember me</span>
          </label>
          <button type="button" className="text-purple-400 text-sm hover:text-purple-300 transition-colors font-medium">
            Forgot Password?
          </button>
        </div>

        {/* Login button */}
        <button
          type="submit"
          disabled={loading}
          className="w-full rounded-xl py-4 text-white font-bold text-base tracking-wider uppercase mt-2 transition-all duration-200 hover:opacity-90 hover:scale-[1.02] active:scale-[0.98] disabled:opacity-70"
          style={{
            background: "#a855f7",
            boxShadow: "0 4px 8px rgba(168, 85, 247, 0.2)"
          }}
        >
          {loading ? (
            <span className="flex items-center justify-center gap-2">
              <svg className="animate-spin w-5 h-5" viewBox="0 0 24 24" fill="none">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"/>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              Signing In…
            </span>
          ) : "LOGIN"}
        </button>

        {/* OR divider */}
        <div className="flex items-center gap-4 my-1">
          <div className="flex-1 h-px bg-white/10" />
          <span className="text-white/40 text-sm font-medium">OR</span>
          <div className="flex-1 h-px bg-white/10" />
        </div>

        
        {/* Sign up */}
        <p className="text-center text-white/50 text-sm mt-1">
          Don't have an account?{" "}
          <button type="button" className="text-purple-400 font-semibold hover:text-purple-300 transition-colors">
            Sign up
          </button>
        </p>
      </form>
    </div>
  );
}

function GoogleIcon() {
  return (
    <svg viewBox="0 0 24 24" className="w-5 h-5">
      <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
      <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
      <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
      <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
    </svg>
  );
}
