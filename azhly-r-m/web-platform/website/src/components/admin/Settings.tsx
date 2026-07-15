import { useEffect, useState } from 'react';
import { Lock, Eye, EyeOff, ShieldCheck, CheckCircle, Camera, UserRound } from 'lucide-react';
import { toast } from 'sonner';

const defaultProfile = {
  name: 'Admin',
  avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=120&q=80',
};

const Settings = () => {
  const [form, setForm] = useState({ current: '', next: '', confirm: '' });
  const [show, setShow] = useState({ current: false, next: false, confirm: false });
  const [saved, setSaved] = useState(false);
  const [profile, setProfile] = useState(defaultProfile);

  useEffect(() => {
    const savedProfile = localStorage.getItem('admin-profile');
    if (savedProfile) {
      try { setProfile({ ...defaultProfile, ...JSON.parse(savedProfile) }); } catch { /* ignore */ }
    }
  }, []);

  const handleProfileSave = (e: React.FormEvent) => {
    e.preventDefault();
    localStorage.setItem('admin-profile', JSON.stringify(profile));
    window.dispatchEvent(new Event('profile-updated'));
    toast.success('Profile updated successfully!');
  };

  const handleAvatarChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = () => {
      const result = typeof reader.result === 'string' ? reader.result : '';
      setProfile(prev => ({ ...prev, avatar: result || prev.avatar }));
    };
    reader.readAsDataURL(file);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!form.current) { toast.error('Please enter your current password.'); return; }
    if (form.next.length < 8) { toast.error('New password must be at least 8 characters.'); return; }
    if (form.next !== form.confirm) { toast.error('New passwords do not match.'); return; }
    setSaved(true);
    toast.success('Password updated successfully!');
    setTimeout(() => { setSaved(false); setForm({ current: '', next: '', confirm: '' }); }, 3000);
  };

  const PasswordInput = ({ field, label, placeholder }: { field: 'current' | 'next' | 'confirm'; label: string; placeholder: string }) => (
    <div>
      <label className="block text-sm font-semibold text-slate-600 mb-2">{label}</label>
      <div className="relative">
        <div className="absolute left-3 top-1/2 -translate-y-1/2">
          <Lock size={15} className="text-slate-400" />
        </div>
        <input
          type={show[field] ? 'text' : 'password'}
          value={form[field]}
          onChange={e => setForm(p => ({ ...p, [field]: e.target.value }))}
          placeholder={placeholder}
          className="w-full pl-9 pr-10 py-2.5 rounded-xl text-sm outline-none transition-all"
          style={{ border: '1.5px solid #e5eaf2', background: '#f8fafc', color: '#334155' }}
          onFocus={e => (e.target.style.border = '1.5px solid #3b82f6')}
          onBlur={e => (e.target.style.border = '1.5px solid #e5eaf2')}
        />
        <button type="button" onClick={() => setShow(p => ({ ...p, [field]: !p[field] }))} className="absolute right-3 top-1/2 -translate-y-1/2">
          {show[field] ? <EyeOff size={15} className="text-slate-400" /> : <Eye size={15} className="text-slate-400" />}
        </button>
      </div>
    </div>
  );

  return (
    <div className="space-y-6 max-w-2xl">
      <div>
        <h2 className="text-xl font-bold text-slate-800">Settings</h2>
        <p className="text-sm text-slate-500 mt-0.5">Manage your account security settings</p>
      </div>

      {/* Profile Update */}
      <div className="bg-white rounded-2xl" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
        <div className="px-6 py-4" style={{ borderBottom: '1px solid #f0f4f8' }}>
          <h3 className="font-bold text-slate-800">Profile Settings</h3>
          <p className="text-xs text-slate-500 mt-0.5">Update your display name and profile picture here.</p>
        </div>
        <form onSubmit={handleProfileSave} className="p-6 space-y-5">
          <div className="flex items-center gap-4">
            <div className="relative h-16 w-16 rounded-full overflow-hidden border border-slate-200 bg-slate-100">
              <img src={profile.avatar} alt="Profile preview" className="h-full w-full object-cover" />
            </div>
            <label className="flex cursor-pointer items-center gap-2 rounded-xl border border-dashed border-slate-300 bg-slate-50 px-3 py-2 text-sm text-slate-600 hover:bg-slate-100">
              <Camera size={14} />
              <span>Change photo</span>
              <input type="file" accept="image/*" className="hidden" onChange={handleAvatarChange} />
            </label>
          </div>

          <div>
            <label className="block text-sm font-semibold text-slate-600 mb-2">Display Name</label>
            <div className="relative">
              <div className="absolute left-3 top-1/2 -translate-y-1/2">
                <UserRound size={15} className="text-slate-400" />
              </div>
              <input
                type="text"
                value={profile.name}
                onChange={e => setProfile(prev => ({ ...prev, name: e.target.value }))}
                className="w-full pl-9 pr-3 py-2.5 rounded-xl text-sm outline-none transition-all"
                style={{ border: '1.5px solid #e5eaf2', background: '#f8fafc', color: '#334155' }}
                onFocus={e => (e.target.style.border = '1.5px solid #3b82f6')}
                onBlur={e => (e.target.style.border = '1.5px solid #e5eaf2')}
              />
            </div>
          </div>

          <button type="submit" className="w-full py-3 rounded-xl text-sm font-bold text-white transition-all hover:opacity-90 active:scale-95" style={{ background: 'linear-gradient(135deg, #071224 0%, #1d4ed8 100%)' }}>
            Save Profile
          </button>
        </form>
      </div>

      {/* Security Badge */}
      <div className="flex items-center gap-3 px-4 py-3 rounded-xl" style={{ background: '#f0f9ff', border: '1px solid #bae6fd' }}>
        <ShieldCheck size={20} style={{ color: '#0284c7' }} />
        <div>
          <p className="text-sm font-semibold" style={{ color: '#0369a1' }}>Account Security</p>
          <p className="text-xs" style={{ color: '#0284c7' }}>Keep your admin account secure by using a strong, unique password.</p>
        </div>
      </div>

      {/* Password Change Form */}
      <div className="bg-white rounded-2xl" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
        <div className="px-6 py-4" style={{ borderBottom: '1px solid #f0f4f8' }}>
          <h3 className="font-bold text-slate-800">Change Password</h3>
          <p className="text-xs text-slate-500 mt-0.5">Select your new password to update your account security settings.</p>
        </div>
        <form onSubmit={handleSubmit} className="p-6 space-y-5">
          <PasswordInput field="current" label="Current Password" placeholder="Enter current password" />
          <PasswordInput field="next" label="New Password" placeholder="Enter new password (min. 8 characters)" />
          <PasswordInput field="confirm" label="Confirm New Password" placeholder="Re-enter new password" />

          {/* Password strength hint */}
          {form.next && (
            <div className="space-y-1.5">
              <p className="text-xs font-semibold text-slate-500">Password strength</p>
              <div className="flex gap-1.5">
                {[8, 12, 16].map(len => (
                  <div key={len} className="h-1.5 flex-1 rounded-full" style={{ background: form.next.length >= len ? (len === 8 ? '#f59e0b' : len === 12 ? '#3b82f6' : '#22c55e') : '#e5eaf2' }} />
                ))}
              </div>
              <p className="text-xs" style={{ color: form.next.length >= 16 ? '#16a34a' : form.next.length >= 12 ? '#2563eb' : '#d97706' }}>
                {form.next.length >= 16 ? 'Strong' : form.next.length >= 12 ? 'Good' : form.next.length >= 8 ? 'Weak' : ''}
              </p>
            </div>
          )}

          {saved ? (
            <div className="flex items-center justify-center gap-2 py-3 rounded-xl text-sm font-semibold" style={{ background: '#dcfce7', color: '#16a34a', border: '1px solid #bbf7d0' }}>
              <CheckCircle size={16} /> Password Updated Successfully
            </div>
          ) : (
            <button type="submit" className="w-full py-3 rounded-xl text-sm font-bold text-white transition-all hover:opacity-90 active:scale-95" style={{ background: 'linear-gradient(135deg, #071224 0%, #1d4ed8 100%)' }}>
              Save Password
            </button>
          )}
        </form>
      </div>

      {/* Session Info */}
      <div className="bg-white rounded-2xl" style={{ border: '1px solid #e5eaf2', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
        <div className="px-6 py-4" style={{ borderBottom: '1px solid #f0f4f8' }}>
          <h3 className="font-bold text-slate-800">Active Session</h3>
        </div>
        <div className="px-6 py-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-xl flex items-center justify-center" style={{ background: '#f0f4ff' }}>
              <ShieldCheck size={16} style={{ color: '#3b82f6' }} />
            </div>
            <div>
              <p className="text-sm font-semibold text-slate-700">Current Session</p>
              <p className="text-xs text-slate-400">Super Administrator · AZHly Dashboard</p>
            </div>
          </div>
          <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ background: '#dcfce7', color: '#16a34a' }}>Active</span>
        </div>
      </div>
    </div>
  );
};

export default Settings;
