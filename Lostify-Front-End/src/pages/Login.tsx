import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Checkbox } from '@/components/ui/checkbox';
import { Label } from '@/components/ui/label';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import { toast } from 'react-toastify';
import { Eye, EyeOff } from 'lucide-react';
import { apiUrl } from '@/lib/api';

const Login = () => {
  const navigate = useNavigate();

  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [errorMsg, setErrorMsg] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg('');

    try {
      const res = await fetch(apiUrl('login/'), {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password }),
      });

      if (!res.ok) {
        toast.error('Invalid username or password', {
          position: "top-right",
          autoClose: 5000,
          hideProgressBar: false,
          closeOnClick: true,
          pauseOnHover: true,
          draggable: true,
          progress: undefined,
        });
        throw new Error('Invalid credentials');
      }

      const data = await res.json();

      // Save tokens and user info in localStorage
      localStorage.setItem('accessToken', data.tokens.access);
      localStorage.setItem('refreshToken', data.tokens.refresh);
      localStorage.setItem('user', JSON.stringify(data.user));
      toast.success('Login successful! Welcome back.');
      // Redirect to home or profile page
      navigate('/profile');
    } catch (error: any) {
      setErrorMsg(error.message || 'Login failed');
    }
  };

  return (
    <div className="flex flex-col min-h-screen relative overflow-hidden">
      <Navbar />
      {/* Animated Background */}
      <div className="fixed inset-0 z-0">
        <div 
          className="absolute inset-0 bg-cover bg-center bg-no-repeat animate-zoom"
          style={{
            backgroundImage: 'url(/bglogin.jpg)',
            animation: 'zoom 20s ease-in-out infinite alternate',
          }}
        />
        <div className="absolute inset-0 bg-black/40 backdrop-blur-sm" />
      </div>
      
      <main className="flex-grow flex items-center justify-center py-12 relative z-10">
        <div className="container mx-auto px-4 md:px-6 flex justify-center">
          <div className="w-full max-w-md">
            <div className="text-center mb-8 animate-fade-in">
              <h1 className="text-3xl font-bold text-white drop-shadow-lg">Welcome Back</h1>
              <p className="text-white/90 mt-2 drop-shadow-md">Sign in to your Lostify account</p>
            </div>

            <div className="bg-white/95 backdrop-blur-md rounded-xl shadow-2xl p-6 border border-white/20 animate-slide-up">
              <form onSubmit={handleSubmit} className="space-y-4">
                {errorMsg && (
                  <div className="text-red-600 text-sm mb-2">{errorMsg}</div>
                )}
                <div className="space-y-2">
                  <Label htmlFor="username">Username</Label>
                  <Input
                    id="username"
                    type="text"
                    placeholder="Enter your username"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    required
                  />
                </div>

                <div className="space-y-2">
                  <div className="flex items-center justify-between">
                    <Label htmlFor="password">Password</Label>
                    <Link
                      to="/forgot-password"
                      className="text-sm text-fienlost-600 hover:underline"
                    >
                      Forgot password?
                    </Link>
                  </div>
                  <div className="relative">
                    <Input
                      id="password"
                      type={showPassword ? "text" : "password"}
                      placeholder="••••••••"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                      className="pr-10"
                    />
                    <button
                      type="button"
                      onClick={() => setShowPassword(!showPassword)}
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700 focus:outline-none"
                      aria-label={showPassword ? "Hide password" : "Show password"}
                    >
                      {showPassword ? (
                        <EyeOff size={20} />
                      ) : (
                        <Eye size={20} />
                      )}
                    </button>
                  </div>
                </div>

                <Button type="submit" className="w-full bg-fienlost-600 hover:bg-fienlost-700">
                  Sign In
                </Button>
              </form>

              {/* Social login buttons unchanged */}
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default Login;
