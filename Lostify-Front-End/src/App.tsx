import { Toaster } from "@/components/ui/toaster";   // optional, remove if not needed
import { Toaster as Sonner } from "@/components/ui/sonner"; // optional, remove if not needed
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import 'react-toastify/dist/ReactToastify.css';

import Index from "./pages/Index";
import Login from "./pages/Login";
import Register from "./pages/Register";
import PostAd from "./pages/PostAd";
import Search from "./pages/Search";
import Profile from "./pages/Profile";
import Listing from "./pages/Listing";
import Settings from "./pages/Settings";
import NotFound from "./pages/NotFound";

// Admin
import AdminGuard from "./pages/admin/AdminGuard";
import AdminLayout from "./pages/admin/AdminLayout";
import Dashboard from "./pages/admin/Dashboard";
import Users from "./pages/admin/Users";
import Ads from "./pages/admin/Ads";
import CardAds from "./pages/admin/CardAds";
import ItemTypes from "./pages/admin/ItemTypes";
import CardTypes from "./pages/admin/CardTypes";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      {/* Remove these if you ONLY want react-toastify */}
      {/* <Toaster /> */}
      {/* <Sonner /> */}

      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Index />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/post-ad" element={<PostAd />} />
          <Route path="/search" element={<Search />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/settings" element={<Settings />} />
          <Route path="/listing/:id" element={<Listing />} />

          {/* Admin routes — protected by AdminGuard */}
          <Route
            path="/admin"
            element={
              <AdminGuard>
                <AdminLayout />
              </AdminGuard>
            }
          >
            <Route index element={<Dashboard />} />
            <Route path="users" element={<Users />} />
            <Route path="ads" element={<Ads />} />
            <Route path="card-ads" element={<CardAds />} />
            <Route path="item-types" element={<ItemTypes />} />
            <Route path="card-types" element={<CardTypes />} />
          </Route>

          <Route path="*" element={<NotFound />} />
        </Routes>
      </BrowserRouter>

      {/* React Toastify ToastContainer */}
      <ToastContainer
        position="top-right"
        autoClose={4000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
        theme="colored"
      />
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;
