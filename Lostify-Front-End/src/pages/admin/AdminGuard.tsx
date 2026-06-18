import React from 'react';
import { Navigate } from 'react-router-dom';
import { isAdminUser } from '@/lib/adminApi';

interface AdminGuardProps {
  children: React.ReactNode;
}

const AdminGuard = ({ children }: AdminGuardProps) => {
  const token = localStorage.getItem('accessToken');
  if (!token) return <Navigate to="/login" replace />;
  if (!isAdminUser()) return <Navigate to="/" replace />;
  return <>{children}</>;
};

export default AdminGuard;
