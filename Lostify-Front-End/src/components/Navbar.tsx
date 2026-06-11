import React, { useState, useEffect } from 'react';
import { NavLink, useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Bell, Menu, Search, User, X, LogOut } from 'lucide-react';

const activeClass = "text-blue-600 px-3 py-2 text-sm font-medium";
const normalClass = "text-gray-700 hover:text-fienlost-600 px-3 py-2 text-sm font-medium";

const Navbar = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [user, setUser] = useState<{ username: string } | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    } else {
      setUser(null);
    }
  }, []);

  const handleLogout = () => {
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    localStorage.removeItem('user');
    setUser(null);
    navigate('/');
  };

  return (
    <header className="sticky top-0 z-50 w-full bg-white/80 backdrop-blur-md border-b border-gray-200">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between">
          {/* Logo */}
          <div className="flex-shrink-0 flex items-center">
            <NavLink to="/" className="flex items-center">
              <div className="h-12 w-24 rounded-full flex items-center justify-center mr-2" style={{ backgroundColor: 'rgb(56 189 248 / var(--tw-bg-opacity, 1))' }}>
                <img src="/lostifylogo.png" alt="Lostify Logo" />
              </div>
            </NavLink>
          </div>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center space-x-4">
            <NavLink to="/" className={({ isActive }) => (isActive ? activeClass : normalClass)}>
              Home
            </NavLink>
            <NavLink to="/search" className={({ isActive }) => (isActive ? activeClass : normalClass)}>
              Search
            </NavLink>
            <NavLink to="/post-ad" className={({ isActive }) => (isActive ? activeClass : normalClass)}>
              Post Ad
            </NavLink>
          </nav>

          {/* Desktop Right Navigation */}
          <div className="hidden md:flex items-center space-x-2">
            <Button variant="ghost" size="icon" className="relative">
              <Bell size={20} />
              <span className="absolute top-0 right-0 h-2 w-2 rounded-full bg-fienlost-600"></span>
            </Button>
            <NavLink to="/search">
              <Button variant="ghost" size="icon">
                <Search size={20} />
              </Button>
            </NavLink>

            {user ? (
              <>
                <NavLink to="/profile" className="flex items-center space-x-1">
                  <User size={20} />
                  <span className="hidden sm:inline text-sm">{user.username}</span>
                </NavLink>
                <Button variant="ghost" size="icon" onClick={handleLogout} title="Logout">
                  <LogOut size={20} />
                </Button>
              </>
            ) : (
              <>
                <NavLink to="/login">
                  <Button variant="ghost" className="ml-2">
                    Login
                  </Button>
                </NavLink>
                <NavLink to="/register">
                  <Button className="bg-fienlost-600 hover:bg-fienlost-700">Sign Up</Button>
                </NavLink>
              </>
            )}
          </div>

          {/* Mobile menu button */}
          <div className="flex md:hidden">
            <button
              onClick={() => setIsMenuOpen(!isMenuOpen)}
              className="inline-flex items-center justify-center p-2 rounded-md text-gray-700 hover:text-fienlost-600 focus:outline-none"
            >
              {isMenuOpen ? <X size={24} /> : <Menu size={24} />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu */}
      {isMenuOpen && (
        <div className="md:hidden">
          <div className="px-2 pt-2 pb-3 space-y-1 sm:px-3">
            <NavLink
              to="/"
              className={({ isActive }) =>
                isActive
                  ? "block px-3 py-2 rounded-md text-base font-medium text-blue-600 bg-gray-100"
                  : "block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-fienlost-600 hover:bg-gray-50"
              }
              onClick={() => setIsMenuOpen(false)}
            >
              Home
            </NavLink>
            <NavLink
              to="/search"
              className={({ isActive }) =>
                isActive
                  ? "block px-3 py-2 rounded-md text-base font-medium text-blue-600 bg-gray-100"
                  : "block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-fienlost-600 hover:bg-gray-50"
              }
              onClick={() => setIsMenuOpen(false)}
            >
              Search
            </NavLink>
            <NavLink
              to="/post-ad"
              className={({ isActive }) =>
                isActive
                  ? "block px-3 py-2 rounded-md text-base font-medium text-blue-600 bg-gray-100"
                  : "block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-fienlost-600 hover:bg-gray-50"
              }
              onClick={() => setIsMenuOpen(false)}
            >
              Post Ad
            </NavLink>

            {user ? (
              <>
                <NavLink
                  to="/profile"
                  className={({ isActive }) =>
                    isActive
                      ? "block px-3 py-2 rounded-md text-base font-medium text-blue-600 bg-gray-100"
                      : "block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-fienlost-600 hover:bg-gray-50"
                  }
                  onClick={() => setIsMenuOpen(false)}
                >
                  Profile
                </NavLink>
                <button
                  onClick={() => {
                    handleLogout();
                    setIsMenuOpen(false);
                  }}
                  className="block w-full text-left px-3 py-2 rounded-md text-base font-medium text-red-600 hover:bg-gray-100"
                >
                  Logout
                </button>
              </>
            ) : (
              <>
                <NavLink
                  to="/login"
                  className={({ isActive }) =>
                    isActive
                      ? "block px-3 py-2 rounded-md text-base font-medium text-blue-600 bg-gray-100"
                      : "block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-fienlost-600 hover:bg-gray-50"
                  }
                  onClick={() => setIsMenuOpen(false)}
                >
                  Login
                </NavLink>
                <NavLink
                  to="/register"
                  className={({ isActive }) =>
                    isActive
                      ? "block px-3 py-2 rounded-md text-base font-medium text-blue-600 bg-gray-100"
                      : "block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-fienlost-600 hover:bg-gray-50"
                  }
                  onClick={() => setIsMenuOpen(false)}
                >
                  Sign Up
                </NavLink>
              </>
            )}
          </div>
        </div>
      )}
    </header>
  );
};

export default Navbar;
