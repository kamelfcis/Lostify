import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Badge } from '@/components/ui/badge';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import { toast } from '@/components/ui/use-toast';
import { apiUrl, mediaUrl } from '@/lib/api';
import {
  formatVisaInput,
  validateVisa,
  validateNationalCard,
  isNationalCardType,
  normalizeCardNumberForSubmit,
} from '@/lib/cardValidation';

interface Ad {
  id: number;
  user: { id: number; username: string };
  title: string;
  item_type?: { id: number; name: string };
  card_type?: { id: number; name: string };
  card_number?: string;
  status: string;
  location_description: string;
  exact_address?: string;
  date_time: string;
  image: string | null;
  reward?: number;
  is_resolved: boolean;
  isCardAd?: boolean;
}

interface User {
  id: number;
  username: string;
  email: string;
  location: string | null;
  average_rating: number | null;
}

const Profile = () => {
  const [activeTab, setActiveTab] = useState('ads');
  const [user, setUser] = useState<User | null>(null);
  const [myAds, setMyAds] = useState<Ad[]>([]);
  const [loading, setLoading] = useState(true);
  const [editDialogOpen, setEditDialogOpen] = useState(false);
  const [editingAd, setEditingAd] = useState<Ad | null>(null);
  const [editFormData, setEditFormData] = useState<any>({});
  const [itemTypes, setItemTypes] = useState<any[]>([]);
  const [cardTypes, setCardTypes] = useState<any[]>([]);
  const [updating, setUpdating] = useState(false);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [deletingAd, setDeletingAd] = useState<Ad | null>(null);
  const [deleting, setDeleting] = useState(false);
  const [markFoundDialogOpen, setMarkFoundDialogOpen] = useState(false);
  const [markingFoundAd, setMarkingFoundAd] = useState<Ad | null>(null);
  const [cardNumberError, setCardNumberError] = useState('');

  const editingCardType = cardTypes.find(
    (type) => type.id.toString() === String(editFormData.card_type_id)
  );
  const isEditVisaCard = editingCardType?.name?.toLowerCase() === 'visa';
  const isEditNationalCard = isNationalCardType(editingCardType?.name);

  // Read currentUser from localStorage once, stable reference
  const [currentUser] = useState(() => {
    const storedUser = localStorage.getItem('user');
    return storedUser ? JSON.parse(storedUser) : null;
  });

  // Fetch item types and card types
  useEffect(() => {
    const fetchTypes = async () => {
      try {
        const [itemTypesRes, cardTypesRes] = await Promise.all([
          fetch(apiUrl('item-types')),
          fetch(apiUrl('card-types'))
        ]);
        const itemTypesData = await itemTypesRes.json();
        const cardTypesData = await cardTypesRes.json();
        setItemTypes(itemTypesData);
        setCardTypes(cardTypesData);
      } catch (error) {
        console.error('Error fetching types:', error);
      }
    };
    fetchTypes();
  }, []);

  useEffect(() => {
    if (!currentUser?.id) {
      setLoading(false);
      return;
    }

    const fetchUserAndAds = async () => {
      setLoading(true);
      try {
        const accessToken = localStorage.getItem('accessToken');
        const headers: HeadersInit = {
          'Content-Type': 'application/json',
        };
        if (accessToken) {
          headers['Authorization'] = `Bearer ${accessToken}`;
        }

        // Fetch current user details
        const userRes = await fetch(apiUrl(`users/${currentUser.id}`), { headers });
        if (!userRes.ok) throw new Error('Failed to fetch user');
        const userData: User = await userRes.json();
        setUser(userData);

        // Fetch both regular ads and card ads
        const [adsRes, cardAdsRes] = await Promise.all([
          fetch(apiUrl('ads/'), { headers }),
          fetch(apiUrl('card-ads/'), { headers })
        ]);

        if (!adsRes.ok || !cardAdsRes.ok) throw new Error('Failed to fetch ads');

        const adsData: Ad[] = await adsRes.json();
        const cardAdsData: Ad[] = await cardAdsRes.json();

        // Filter ads for current user and mark card ads
        const filteredRegularAds = adsData
          .filter(ad => ad.user.id === currentUser.id)
          .map(ad => ({ ...ad, isCardAd: false }));
        
        const filteredCardAds = cardAdsData
          .filter(ad => ad.user.id === currentUser.id)
          .map(ad => ({ ...ad, isCardAd: true }));

        // Combine both types
        setMyAds([...filteredRegularAds, ...filteredCardAds]);
      } catch (error) {
        console.error('Error fetching data:', error);
        setUser(null);
        setMyAds([]);
      } finally {
        setLoading(false);
      }
    };

    fetchUserAndAds();
  }, [currentUser]);

  const openEditDialog = (ad: Ad) => {
    setEditingAd(ad);
    // Format date_time for datetime-local input
    const dateTime = ad.date_time ? new Date(ad.date_time).toISOString().slice(0, 16) : '';
    const cardTypeName = ad.card_type?.name;
    let cardNumber = ad.card_number || '';
    if (cardTypeName?.toLowerCase() === 'visa' && cardNumber) {
      cardNumber = formatVisaInput(cardNumber);
    }

    setCardNumberError('');
    setEditFormData({
      title: ad.title || '',
      location_description: ad.location_description || '',
      exact_address: ad.exact_address || '',
      transportation_type: ad.transportation_type || '',
      date_time: dateTime,
      comments: ad.comments || '',
      reward: ad.reward || '',
      item_type_id: ad.item_type?.id || '',
      card_type_id: ad.card_type?.id || '',
      card_number: cardNumber,
    });
    setEditDialogOpen(true);
  };

  const handleEditChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    const { name, value } = e.target;

    if (name === 'card_type_id') {
      setCardNumberError('');
      setEditFormData((prev: any) => ({
        ...prev,
        card_type_id: value,
        card_number: '',
      }));
      return;
    }

    if (name === 'card_number') {
      const cardType = cardTypes.find((type) => type.id.toString() === String(editFormData.card_type_id));
      const isVisa = cardType?.name?.toLowerCase() === 'visa';
      const isNational = isNationalCardType(cardType?.name);

      let nextValue = value;
      if (isVisa) {
        nextValue = formatVisaInput(value);
      } else if (isNational) {
        nextValue = value.replace(/\D/g, '').slice(0, 14);
      }

      setCardNumberError('');
      setEditFormData((prev: any) => ({
        ...prev,
        card_number: nextValue,
      }));
      return;
    }

    setEditFormData((prev: any) => ({
      ...prev,
      [name]: value,
    }));
  };

  const validateEditCardNumber = (): boolean => {
    if (!editingAd?.isCardAd) return true;

    if (isEditVisaCard) {
      const error = validateVisa(editFormData.card_number || '');
      setCardNumberError(error ?? '');
      return !error;
    }
    if (isEditNationalCard) {
      const error = validateNationalCard(editFormData.card_number || '');
      setCardNumberError(error ?? '');
      return !error;
    }
    setCardNumberError('');
    return true;
  };

  const handleUpdateAd = async () => {
    if (!editingAd) return;

    if (!validateEditCardNumber()) {
      return;
    }

    setUpdating(true);
    try {
      const accessToken = localStorage.getItem('accessToken');
      const endpoint = editingAd.isCardAd
        ? apiUrl(`card-ads/${editingAd.id}/`)
        : apiUrl(`ads/${editingAd.id}/`);

      const formDataObj = new FormData();
      
      // Add fields based on ad type
      if (editingAd.isCardAd) {
        if (editFormData.card_type_id) formDataObj.append('card_type_id', editFormData.card_type_id);
        if (editFormData.card_number) {
          formDataObj.append(
            'card_number',
            normalizeCardNumberForSubmit(editFormData.card_number, editingCardType?.name)
          );
        }
      } else {
        if (editFormData.item_type_id) formDataObj.append('item_type_id', editFormData.item_type_id);
      }

      // Common fields
      formDataObj.append('title', editFormData.title);
      formDataObj.append('location_description', editFormData.location_description);
      if (editFormData.exact_address) formDataObj.append('exact_address', editFormData.exact_address);
      if (editFormData.transportation_type) formDataObj.append('transportation_type', editFormData.transportation_type);
      formDataObj.append('date_time', editFormData.date_time);
      if (editFormData.comments) formDataObj.append('comments', editFormData.comments);
      if (editFormData.reward) formDataObj.append('reward', editFormData.reward);
      formDataObj.append('status', editingAd.status);
      formDataObj.append('is_resolved', editingAd.is_resolved.toString());

      const response = await fetch(endpoint, {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${accessToken}`,
        },
        body: formDataObj,
      });

      if (!response.ok) {
        throw new Error('Failed to update ad');
      }

      toast({
        title: "Ad Updated Successfully!",
        description: "Your ad has been updated.",
      });

      // Refresh ads list
      const fetchUserAndAds = async () => {
        const accessToken = localStorage.getItem('accessToken');
        const headers: HeadersInit = {
          'Content-Type': 'application/json',
        };
        if (accessToken) {
          headers['Authorization'] = `Bearer ${accessToken}`;
        }

        const [adsRes, cardAdsRes] = await Promise.all([
          fetch(apiUrl('ads/'), { headers }),
          fetch(apiUrl('card-ads/'), { headers })
        ]);

        const adsData: Ad[] = await adsRes.json();
        const cardAdsData: Ad[] = await cardAdsRes.json();

        const filteredRegularAds = adsData
          .filter(ad => ad.user.id === currentUser.id)
          .map(ad => ({ ...ad, isCardAd: false }));
        
        const filteredCardAds = cardAdsData
          .filter(ad => ad.user.id === currentUser.id)
          .map(ad => ({ ...ad, isCardAd: true }));

        setMyAds([...filteredRegularAds, ...filteredCardAds]);
      };

      await fetchUserAndAds();
      setEditDialogOpen(false);
      setEditingAd(null);
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to update ad. Please try again.",
        variant: 'destructive',
      });
      console.error(error);
    } finally {
      setUpdating(false);
    }
  };

  const openMarkFoundDialog = (ad: Ad) => {
    setMarkingFoundAd(ad);
    setMarkFoundDialogOpen(true);
  };

  const handleMarkAsFound = async () => {
    if (!markingFoundAd) return;

    setUpdating(true);
    try {
      const accessToken = localStorage.getItem('accessToken');
      const endpoint = markingFoundAd.isCardAd
        ? apiUrl(`card-ads/${markingFoundAd.id}/`)
        : apiUrl(`ads/${markingFoundAd.id}/`);

      const formDataObj = new FormData();
      
      // Keep all existing fields
      formDataObj.append('title', markingFoundAd.title);
      formDataObj.append('location_description', markingFoundAd.location_description);
      if (markingFoundAd.exact_address) formDataObj.append('exact_address', markingFoundAd.exact_address);
      if (markingFoundAd.transportation_type) formDataObj.append('transportation_type', markingFoundAd.transportation_type);
      formDataObj.append('date_time', markingFoundAd.date_time);
      if (markingFoundAd.comments) formDataObj.append('comments', markingFoundAd.comments);
      if (markingFoundAd.reward) formDataObj.append('reward', markingFoundAd.reward.toString());
      formDataObj.append('status', markingFoundAd.status);
      formDataObj.append('is_resolved', 'true'); // Mark as resolved

      if (markingFoundAd.isCardAd) {
        if (markingFoundAd.card_type?.id) formDataObj.append('card_type_id', markingFoundAd.card_type.id.toString());
        if (markingFoundAd.card_number) formDataObj.append('card_number', markingFoundAd.card_number);
      } else {
        if (markingFoundAd.item_type?.id) formDataObj.append('item_type_id', markingFoundAd.item_type.id.toString());
      }

      const response = await fetch(endpoint, {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${accessToken}`,
        },
        body: formDataObj,
      });

      if (!response.ok) {
        throw new Error('Failed to update ad');
      }

      toast({
        title: "Ad Marked as Resolved!",
        description: "Your ad has been marked as found/resolved.",
      });

      // Refresh ads list
      const fetchUserAndAds = async () => {
        const accessToken = localStorage.getItem('accessToken');
        const headers: HeadersInit = {
          'Content-Type': 'application/json',
        };
        if (accessToken) {
          headers['Authorization'] = `Bearer ${accessToken}`;
        }

        const [adsRes, cardAdsRes] = await Promise.all([
          fetch(apiUrl('ads/'), { headers }),
          fetch(apiUrl('card-ads/'), { headers })
        ]);

        const adsData: Ad[] = await adsRes.json();
        const cardAdsData: Ad[] = await cardAdsRes.json();

        const filteredRegularAds = adsData
          .filter(ad => ad.user.id === currentUser.id)
          .map(ad => ({ ...ad, isCardAd: false }));
        
        const filteredCardAds = cardAdsData
          .filter(ad => ad.user.id === currentUser.id)
          .map(ad => ({ ...ad, isCardAd: true }));

        setMyAds([...filteredRegularAds, ...filteredCardAds]);
      };

      await fetchUserAndAds();
      setMarkFoundDialogOpen(false);
      setMarkingFoundAd(null);
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to update ad. Please try again.",
        variant: 'destructive',
      });
      console.error(error);
    } finally {
      setUpdating(false);
    }
  };

  const openDeleteDialog = (ad: Ad) => {
    setDeletingAd(ad);
    setDeleteDialogOpen(true);
  };

  const handleDeleteAd = async () => {
    if (!deletingAd) return;

    setDeleting(true);
    try {
      const accessToken = localStorage.getItem('accessToken');
      const endpoint = deletingAd.isCardAd
        ? apiUrl(`card-ads/${deletingAd.id}/`)
        : apiUrl(`ads/${deletingAd.id}/`);

      const response = await fetch(endpoint, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${accessToken}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to delete ad');
      }

      toast({
        title: "✅ Ad Deleted Successfully!",
        description: "Your ad has been permanently deleted.",
      });

      // Refresh ads list
      const fetchUserAndAds = async () => {
        const accessToken = localStorage.getItem('accessToken');
        const headers: HeadersInit = {
          'Content-Type': 'application/json',
        };
        if (accessToken) {
          headers['Authorization'] = `Bearer ${accessToken}`;
        }

        const [adsRes, cardAdsRes] = await Promise.all([
          fetch(apiUrl('ads/'), { headers }),
          fetch(apiUrl('card-ads/'), { headers })
        ]);

        const adsData: Ad[] = await adsRes.json();
        const cardAdsData: Ad[] = await cardAdsRes.json();

        const filteredRegularAds = adsData
          .filter(ad => ad.user.id === currentUser.id)
          .map(ad => ({ ...ad, isCardAd: false }));
        
        const filteredCardAds = cardAdsData
          .filter(ad => ad.user.id === currentUser.id)
          .map(ad => ({ ...ad, isCardAd: true }));

        setMyAds([...filteredRegularAds, ...filteredCardAds]);
      };

      await fetchUserAndAds();
      setDeleteDialogOpen(false);
      setDeletingAd(null);
    } catch (error) {
      toast({
        title: "❌ Error",
        description: "Failed to delete ad. Please try again.",
        variant: 'destructive',
      });
      console.error(error);
    } finally {
      setDeleting(false);
    }
  };

  if (loading) {
    return (
      <div className="flex flex-col min-h-screen relative overflow-hidden">
        {/* Futuristic Background */}
        <div className="fixed inset-0 -z-10">
          <div className="absolute inset-0 bg-gradient-to-br from-slate-900 via-blue-900 to-purple-900 animate-gradient"></div>
          <div className="absolute inset-0 bg-[linear-gradient(rgba(56,189,248,0.1)_1px,transparent_1px),linear-gradient(90deg,rgba(56,189,248,0.1)_1px,transparent_1px)] bg-[size:50px_50px] animate-pulse"></div>
          <div className="absolute top-20 left-10 w-72 h-72 bg-blue-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-float"></div>
          <div className="absolute top-40 right-10 w-72 h-72 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-float" style={{ animationDelay: '2s' }}></div>
          <div className="absolute -bottom-32 left-1/2 w-72 h-72 bg-cyan-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-float" style={{ animationDelay: '4s' }}></div>
        </div>
        <Navbar />
        <main className="flex-grow py-12 relative z-10">
          <div className="container mx-auto px-4">
            <div className="max-w-5xl mx-auto">
              {/* Profile Header Skeleton */}
              <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6 md:p-8 mb-8">
                <div className="flex flex-col sm:flex-row items-center gap-6">
                  {/* Avatar Skeleton */}
                  <div className="h-24 w-24 rounded-full bg-white/10 animate-pulse"></div>
                  <div className="text-center sm:text-left flex-1 space-y-3">
                    {/* Name Skeleton */}
                    <div className="h-7 w-48 bg-white/10 rounded animate-pulse mx-auto sm:mx-0"></div>
                    {/* Email Skeleton */}
                    <div className="h-4 w-64 bg-white/10 rounded animate-pulse mx-auto sm:mx-0"></div>
                    {/* Location Skeleton */}
                    <div className="h-4 w-40 bg-white/10 rounded animate-pulse mx-auto sm:mx-0"></div>
                    {/* Badges Skeleton */}
                    <div className="flex gap-2 justify-center sm:justify-start">
                      <div className="h-6 w-20 bg-white/10 rounded animate-pulse"></div>
                      <div className="h-6 w-24 bg-white/10 rounded animate-pulse"></div>
                    </div>
                  </div>
                </div>
              </div>

              {/* Tabs Skeleton */}
              <div className="bg-white/10 backdrop-blur-md rounded-xl border border-white/20 p-2 mb-8">
                <div className="grid grid-cols-3 gap-2">
                  <div className="h-10 bg-white/10 rounded animate-pulse"></div>
                  <div className="h-10 bg-white/10 rounded animate-pulse"></div>
                  <div className="h-10 bg-white/10 rounded animate-pulse"></div>
                </div>
              </div>

              {/* Posts Skeleton */}
              <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6">
                <div className="h-6 w-32 bg-white/10 rounded mb-6 animate-pulse"></div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  {[...Array(4)].map((_, index) => (
                    <div
                      key={index}
                      className="bg-white/10 backdrop-blur-md rounded-xl overflow-hidden shadow-lg border border-white/20 relative overflow-hidden"
                    >
                      {/* Shimmer Effect */}
                      <div className="absolute inset-0 -translate-x-full animate-shimmer bg-gradient-to-r from-transparent via-white/10 to-transparent"></div>
                      
                      {/* Image Skeleton */}
                      <div className="relative h-48 bg-gradient-to-br from-white/10 to-white/5">
                        <div className="absolute top-3 left-3 w-16 h-6 bg-white/20 rounded-full"></div>
                      </div>
                      
                      {/* Content Skeleton */}
                      <div className="p-4 space-y-3 relative">
                        <div className="h-5 bg-white/10 rounded w-3/4"></div>
                        <div className="space-y-2">
                          <div className="h-3 bg-white/10 rounded w-full"></div>
                          <div className="h-3 bg-white/10 rounded w-5/6"></div>
                        </div>
                        <div className="space-y-2 pt-2">
                          <div className="h-3 bg-white/10 rounded w-1/2"></div>
                          <div className="h-3 bg-white/10 rounded w-2/3"></div>
                        </div>
                        <div className="flex gap-2 pt-2">
                          <div className="h-8 flex-1 bg-white/10 rounded"></div>
                          <div className="h-8 flex-1 bg-white/10 rounded"></div>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  if (!user) {
    return (
      <div className="flex flex-col min-h-screen relative overflow-hidden">
        {/* Futuristic Background */}
        <div className="fixed inset-0 -z-10">
          <div className="absolute inset-0 bg-gradient-to-br from-slate-900 via-blue-900 to-purple-900 animate-gradient"></div>
          <div className="absolute inset-0 bg-[linear-gradient(rgba(56,189,248,0.1)_1px,transparent_1px),linear-gradient(90deg,rgba(56,189,248,0.1)_1px,transparent_1px)] bg-[size:50px_50px] animate-pulse"></div>
        </div>
        <Navbar />
        <main className="flex-grow py-12 relative z-10">
          <div className="container mx-auto px-4 text-center">
            <p className="text-lg text-white mb-4">User not found or not logged in.</p>
            <Link to="/login">
              <Button className="bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-600 hover:to-blue-700 text-white shadow-lg shadow-cyan-500/50">
                Go to Login
              </Button>
            </Link>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  return (
    <div className="flex flex-col min-h-screen relative overflow-hidden">
      {/* Futuristic Background */}
      <div className="fixed inset-0 -z-10">
        {/* Animated Gradient Background */}
        <div className="absolute inset-0 bg-gradient-to-br from-slate-900 via-blue-900 to-purple-900 animate-gradient"></div>
        
        {/* Animated Grid Pattern */}
        <div className="absolute inset-0 bg-[linear-gradient(rgba(56,189,248,0.1)_1px,transparent_1px),linear-gradient(90deg,rgba(56,189,248,0.1)_1px,transparent_1px)] bg-[size:50px_50px] animate-pulse"></div>
        
        {/* Floating Orbs */}
        <div className="absolute top-20 left-10 w-72 h-72 bg-blue-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-float"></div>
        <div className="absolute top-40 right-10 w-72 h-72 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-float" style={{ animationDelay: '2s' }}></div>
        <div className="absolute -bottom-32 left-1/2 w-72 h-72 bg-cyan-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-float" style={{ animationDelay: '4s' }}></div>
        
        {/* Animated Lines */}
        <div className="absolute inset-0">
          <div className="absolute top-1/4 left-0 w-full h-px bg-gradient-to-r from-transparent via-cyan-400 to-transparent opacity-30 animate-pulse"></div>
          <div className="absolute top-1/2 left-0 w-full h-px bg-gradient-to-r from-transparent via-blue-400 to-transparent opacity-30 animate-pulse" style={{ animationDelay: '1s' }}></div>
          <div className="absolute top-3/4 left-0 w-full h-px bg-gradient-to-r from-transparent via-purple-400 to-transparent opacity-30 animate-pulse" style={{ animationDelay: '2s' }}></div>
        </div>
        
        {/* Shimmer Effect */}
        <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/5 to-transparent animate-shimmer"></div>
      </div>

      <Navbar />

      <main className="flex-grow py-12 relative z-10">
        <div className="container mx-auto px-4">
          <div className="max-w-5xl mx-auto">
            {/* Profile Header */}
            <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6 md:p-8 mb-8">
              <div className="flex flex-col sm:flex-row items-center gap-6">
                <div className="h-24 w-24 rounded-full bg-gradient-to-br from-cyan-400 to-blue-500 flex items-center justify-center text-white font-bold text-4xl shadow-lg shadow-cyan-500/50">
                  {user.username.charAt(0).toUpperCase()}
                </div>
                <div className="text-center sm:text-left">
                  <h1 className="text-2xl font-bold text-white">{user.username}</h1>
                  <p className="text-gray-300">{user.email}</p>
                  <p className="text-gray-300">{user.location || 'Location not set'}</p>
                  <div className="flex flex-wrap gap-2 mt-2 justify-center sm:justify-start">
                    <Badge className="bg-green-500/20 text-green-300 border border-green-400/30 hover:bg-green-500/30">
                      {myAds.length} {myAds.length === 1 ? 'Post' : 'Posts'}
                    </Badge>
                    <Badge className="bg-blue-500/20 text-blue-300 border border-blue-400/30 hover:bg-blue-500/30">
                      Rating: {user.average_rating ?? 'N/A'}
                    </Badge>
                  </div>
                </div>
                <div className="ml-auto hidden sm:block">
                  <Link to="/settings">
                    <Button variant="outline" className="bg-white/10 border-white/20 text-white hover:bg-white/20">
                      Edit Profile
                    </Button>
                  </Link>
                </div>
              </div>
              <div className="sm:hidden mt-4 flex justify-center">
                <Link to="/settings">
                  <Button variant="outline" className="bg-white/10 border-white/20 text-white hover:bg-white/20">
                    Edit Profile
                  </Button>
                </Link>
              </div>
            </div>

            {/* Profile Tabs */}
            <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
              <TabsList className="grid grid-cols-3 mb-8 bg-white/10 backdrop-blur-md border border-white/20">
                <TabsTrigger value="ads" className="text-base text-white data-[state=active]:bg-white/20">My Posts</TabsTrigger>
                <TabsTrigger value="messages" className="text-base text-white data-[state=active]:bg-white/20">Messages</TabsTrigger>
                <TabsTrigger value="notifications" className="text-base text-white data-[state=active]:bg-white/20">Notifications</TabsTrigger>
              </TabsList>

              <TabsContent value="ads">
                <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6">
                  <h2 className="text-xl font-medium mb-6 text-white">My Posts</h2>

                  {myAds.length > 0 ? (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                      {myAds.map((ad, index) => (
                        <div
                          key={ad.id}
                          className="bg-white/10 backdrop-blur-md rounded-xl overflow-hidden shadow-lg border border-white/20 hover:shadow-2xl transition-all duration-300 hover:scale-105 hover:-translate-y-2 animate-fade-in-up"
                          style={{ 
                            animationDelay: `${index * 0.1}s`,
                            animationFillMode: 'both'
                          }}
                        >
                          <div className="relative h-48 overflow-hidden">
                            {ad.image ? (
                              <img
                                src={mediaUrl(ad.image)}
                                alt={ad.title}
                                className="w-full h-full object-cover transition-transform duration-500 hover:scale-110"
                              />
                            ) : (
                              <div className="flex justify-center items-center h-full bg-gray-800/50 text-gray-400">
                                No Image
                              </div>
                            )}
                            <div
                              className={`absolute top-3 left-3 py-1 px-3 rounded-full text-xs font-medium backdrop-blur-sm ${
                                ad.status === 'lost'
                                  ? 'bg-red-500/80 text-white shadow-lg shadow-red-500/50'
                                  : 'bg-green-500/80 text-white shadow-lg shadow-green-500/50'
                              }`}
                            >
                              {ad.status.charAt(0).toUpperCase() + ad.status.slice(1)}
                            </div>
                            {ad.reward && (
                              <div className="absolute top-3 right-3 px-3 py-1 bg-gradient-to-r from-yellow-500/90 to-orange-500/90 rounded-lg border border-yellow-400/50 shadow-lg shadow-yellow-500/50 backdrop-blur-sm">
                                <div className="flex items-center gap-1">
                                  <span className="text-sm">💰</span>
                                  <span className="text-xs font-bold text-white">{ad.reward} EGP</span>
                                </div>
                              </div>
                            )}
                          </div>
                          <div className="p-4">
                            <h3 className="font-medium text-white mb-2 line-clamp-1">{ad.title}</h3>
                            <p className="text-sm text-gray-200 line-clamp-2 mb-3">{ad.location_description}</p>
                            
                            {/* Show card type and card number for card ads */}
                            {ad.isCardAd && (
                              <div className="mb-3 space-y-1">
                                {ad.card_type && (
                                  <div className="flex items-center text-sm text-cyan-200">
                                    <span className="font-medium mr-2">Card Type:</span>
                                    <span>{ad.card_type.name}</span>
                                  </div>
                                )}
                                {ad.card_number && (
                                  <div className="flex items-center text-sm text-cyan-200">
                                    <span className="font-medium mr-2">Card Number:</span>
                                    <span>{ad.card_number}</span>
                                  </div>
                                )}
                              </div>
                            )}
                            
                            {/* Show item type for regular ads */}
                            {!ad.isCardAd && ad.item_type && (
                              <div className="mb-3">
                                <span className="px-2 py-1 bg-blue-500/20 rounded text-xs text-blue-200 border border-blue-400/30">
                                  {ad.item_type.name}
                                </span>
                              </div>
                            )}
                            
                            <div className="flex items-center text-xs text-gray-300 mb-4">
                              <span>Posted: {new Date(ad.date_time).toLocaleDateString()}</span>
                              {ad.is_resolved && (
                                <span className="ml-2 px-2 py-1 bg-green-500/20 rounded text-green-300 border border-green-400/30">
                                  Resolved
                                </span>
                              )}
                            </div>
                            
                            <div className="flex flex-wrap gap-2">
                              <Link to={`/listing/${ad.id}`} className="flex-1">
                                <Button 
                                  variant="outline" 
                                  size="sm" 
                                  className="w-full bg-white/10 border-white/20 text-white hover:bg-white/20"
                                >
                                  View
                                </Button>
                              </Link>
                              <Button 
                                variant="outline" 
                                size="sm" 
                                className="flex-1 bg-white/10 border-white/20 text-white hover:bg-white/20"
                                onClick={() => openEditDialog(ad)}
                                disabled={updating}
                              >
                                Edit
                              </Button>
                              {!ad.is_resolved && (
                                <Button 
                                  variant="outline" 
                                  size="sm" 
                                  className="flex-1 bg-green-500/20 border-green-400/30 text-green-300 hover:bg-green-500/30"
                                  onClick={() => openMarkFoundDialog(ad)}
                                  disabled={updating || deleting}
                                >
                                  Mark Found
                                </Button>
                              )}
                              <Button 
                                variant="outline" 
                                size="sm" 
                                className="flex-1 bg-red-500/20 border-red-400/30 text-red-300 hover:bg-red-500/30"
                                onClick={() => openDeleteDialog(ad)}
                                disabled={deleting || updating}
                              >
                                Delete
                              </Button>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div className="text-center py-12">
                      <p className="text-gray-300 mb-4">You haven't posted any ads yet.</p>
                      <Link to="/post-ad">
                        <Button className="bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-600 hover:to-blue-700 text-white shadow-lg shadow-cyan-500/50">
                          Post New Ad
                        </Button>
                      </Link>
                    </div>
                  )}

                </div>
              </TabsContent>

              <TabsContent value="messages">
                <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6">
                  <h2 className="text-xl font-medium mb-6 text-white">Messages</h2>
                  {/* Messages content can be added here */}
                  <p className="text-gray-300">No messages yet.</p>
                </div>
              </TabsContent>

              <TabsContent value="notifications">
                <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6">
                  <h2 className="text-xl font-medium mb-6 text-white">Notifications</h2>
                  {/* Notifications content can be added here */}
                  <p className="text-gray-300">No notifications yet.</p>
                </div>
              </TabsContent>
            </Tabs>
          </div>
        </div>
      </main>

      {/* Edit Dialog */}
      <Dialog open={editDialogOpen} onOpenChange={setEditDialogOpen}>
        <DialogContent className="bg-slate-900 border-white/20 text-white max-w-2xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="text-white">Edit Post</DialogTitle>
            <DialogDescription className="text-gray-300">
              Update your post information below.
            </DialogDescription>
          </DialogHeader>
          
          {editingAd && (
            <div className="space-y-4 py-4">
              <div className="space-y-2">
                <Label htmlFor="edit-title" className="text-white">Title</Label>
                <Input
                  id="edit-title"
                  name="title"
                  value={editFormData.title}
                  onChange={handleEditChange}
                  className="bg-white/10 border-white/20 text-white"
                  required
                />
              </div>

              {editingAd.isCardAd ? (
                <>
                  <div className="space-y-2">
                    <Label htmlFor="edit-card-type" className="text-white">Card Type</Label>
                    <select
                      id="edit-card-type"
                      name="card_type_id"
                      value={editFormData.card_type_id}
                      onChange={handleEditChange}
                      className="w-full border border-white/20 rounded-md px-3 py-2 bg-white/10 text-white focus:border-cyan-400 focus:outline-none"
                    >
                      <option value="" className="bg-slate-900">Select Card Type</option>
                      {cardTypes.map((type) => (
                        <option key={type.id} value={type.id} className="bg-slate-900">
                          {type.name}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="edit-card-number" className="text-white">
                      {isEditVisaCard ? 'Card ID' : 'Card Number'}
                    </Label>
                    <Input
                      id="edit-card-number"
                      name="card_number"
                      value={editFormData.card_number}
                      onChange={handleEditChange}
                      inputMode="numeric"
                      maxLength={isEditVisaCard ? 19 : isEditNationalCard ? 14 : 30}
                      placeholder={
                        isEditVisaCard
                          ? 'XXXX-XXXX-XXXX-XXXX'
                          : isEditNationalCard
                            ? '14-digit national ID'
                            : 'Enter card number'
                      }
                      className="bg-white/10 border-white/20 text-white"
                    />
                    {cardNumberError && (
                      <p className="text-xs text-red-400">{cardNumberError}</p>
                    )}
                  </div>
                </>
              ) : (
                <div className="space-y-2">
                  <Label htmlFor="edit-item-type" className="text-white">Item Type</Label>
                  <select
                    id="edit-item-type"
                    name="item_type_id"
                    value={editFormData.item_type_id}
                    onChange={handleEditChange}
                    className="w-full border border-white/20 rounded-md px-3 py-2 bg-white/10 text-white focus:border-cyan-400 focus:outline-none"
                  >
                    <option value="" className="bg-slate-900">Select Item Type</option>
                    {itemTypes.map((type) => (
                      <option key={type.id} value={type.id} className="bg-slate-900">
                        {type.name}
                      </option>
                    ))}
                  </select>
                </div>
              )}

              <div className="space-y-2">
                <Label htmlFor="edit-location" className="text-white">Location Description</Label>
                <Textarea
                  id="edit-location"
                  name="location_description"
                  value={editFormData.location_description}
                  onChange={handleEditChange}
                  className="bg-white/10 border-white/20 text-white"
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="edit-address" className="text-white">Exact Address</Label>
                <Input
                  id="edit-address"
                  name="exact_address"
                  value={editFormData.exact_address}
                  onChange={handleEditChange}
                  className="bg-white/10 border-white/20 text-white"
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="edit-date" className="text-white">Date and Time</Label>
                  <Input
                    id="edit-date"
                    name="date_time"
                    type="datetime-local"
                    value={editFormData.date_time}
                    onChange={handleEditChange}
                    className="bg-white/10 border-white/20 text-white"
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="edit-transport" className="text-white">Transportation Type</Label>
                  <Input
                    id="edit-transport"
                    name="transportation_type"
                    value={editFormData.transportation_type}
                    onChange={handleEditChange}
                    className="bg-white/10 border-white/20 text-white"
                  />
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="edit-comments" className="text-white">Additional Comments</Label>
                <Textarea
                  id="edit-comments"
                  name="comments"
                  value={editFormData.comments}
                  onChange={handleEditChange}
                  className="bg-white/10 border-white/20 text-white"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="edit-reward" className="text-white">Reward (Optional)</Label>
                <div className="relative">
                  <span className="absolute left-3 top-1/2 -translate-y-1/2 text-white/70 text-lg">💰</span>
                  <Input
                    id="edit-reward"
                    name="reward"
                    type="number"
                    min="0"
                    step="0.01"
                    value={editFormData.reward}
                    onChange={handleEditChange}
                    className="bg-white/10 border-white/20 text-white pl-10"
                  />
                </div>
              </div>
            </div>
          )}

          <DialogFooter>
            <Button
              variant="outline"
              onClick={() => setEditDialogOpen(false)}
              className="bg-white/10 border-white/20 text-white hover:bg-white/20"
            >
              Cancel
            </Button>
            <Button
              onClick={handleUpdateAd}
              disabled={updating}
              className="bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-600 hover:to-blue-700 text-white shadow-lg shadow-cyan-500/50"
            >
              {updating ? 'Updating...' : 'Update Post'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Mark as Found Confirmation Dialog */}
      <AlertDialog open={markFoundDialogOpen} onOpenChange={setMarkFoundDialogOpen}>
        <AlertDialogContent className="bg-slate-900 border-white/20 text-white">
          <AlertDialogHeader>
            <AlertDialogTitle className="text-white">Mark as Found/Resolved</AlertDialogTitle>
            <AlertDialogDescription className="text-gray-300">
              Are you sure you want to mark "{markingFoundAd?.title}" as found/resolved? This will indicate that the item has been recovered or returned.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel className="bg-white/10 border-white/20 text-white hover:bg-white/20">
              Cancel
            </AlertDialogCancel>
            <AlertDialogAction
              onClick={handleMarkAsFound}
              disabled={updating}
              className="bg-green-600 hover:bg-green-700 text-white"
            >
              {updating ? 'Updating...' : 'Mark as Found'}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>

      {/* Delete Confirmation Dialog */}
      <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
        <AlertDialogContent className="bg-slate-900 border-white/20 text-white">
          <AlertDialogHeader>
            <AlertDialogTitle className="text-white">Delete Post</AlertDialogTitle>
            <AlertDialogDescription className="text-gray-300">
              Are you sure you want to delete "{deletingAd?.title}"? This action cannot be undone and the post will be permanently removed.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel className="bg-white/10 border-white/20 text-white hover:bg-white/20">
              Cancel
            </AlertDialogCancel>
            <AlertDialogAction
              onClick={handleDeleteAd}
              disabled={deleting}
              className="bg-red-600 hover:bg-red-700 text-white"
            >
              {deleting ? 'Deleting...' : 'Delete'}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>

      <Footer />
    </div>
  );
};

export default Profile;
