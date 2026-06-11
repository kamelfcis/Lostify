import React, { useState, useEffect } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import { toast } from "@/components/ui/use-toast";
import { apiUrl } from '@/lib/api';

const PostAd = () => {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const initialAdType = searchParams.get('type') || 'lost';
  const [adType, setAdType] = useState(initialAdType);
  const [postingKind, setPostingKind] = useState<'item' | 'card'>('item');

  const [itemTypes, setItemTypes] = useState<any[]>([]);
  const [cardTypes, setCardTypes] = useState<any[]>([]);
  const [formData, setFormData] = useState({
    title: '',
    item_type_id: '',
    card_type_id: '',
    card_number: '',
    location_description: '',
    exact_address: '',
    transportation_type: '',
    date_time: '',
    comments: '',
    reward: '',
    image: null, // Here to store the image file
    is_resolved: false,
  });

  const [loading, setLoading] = useState(false);
  
  const selectedCardType = cardTypes.find(
    (type) => type.id.toString() === formData.card_type_id
  );
  const isCardPost = postingKind === 'card';
  const isVisaCard =
    selectedCardType?.name?.toLowerCase() === 'visa';

  useEffect(() => {
    const fetchTypes = async () => {
      try {
        const [itemTypesRes, cardTypesRes] = await Promise.all([
          fetch(apiUrl('item-types')),
          fetch(apiUrl('card-types')),
        ]);
        const [itemTypesData, cardTypesData] = await Promise.all([
          itemTypesRes.json(),
          cardTypesRes.json(),
        ]);
        setItemTypes(itemTypesData);
        setCardTypes(cardTypesData);
      } catch (error) {
        console.error('Error fetching types:', error);
      }
    };

    fetchTypes();
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    setLoading(true);
    try {
      const formDataObj = new FormData();
      
      // Determine which endpoint to use
      const isCard = isCardPost;
      const endpoint = isCard ? apiUrl('card-ads/') : apiUrl('ads/');
      
      // Add all the form fields to FormData
      Object.keys(formData).forEach((key) => {
        if (key === 'image' && formData[key]) {
          formDataObj.append('image', formData[key]);
        } else if (isCard) {
          // For card ads, use card_type_id instead of item_type_id
          if (key === 'item_type_id') {
            // Skip item_type_id for card ads
            return;
          }
          if (key === 'card_type_id' && formData[key]) {
            formDataObj.append('card_type_id', formData[key]);
          } else if (key === 'card_number' && formData[key]) {
            formDataObj.append('card_number', formData[key]);
          } else if (key === 'reward' && formData[key]) {
            formDataObj.append('reward', formData[key]);
          } else if (formData[key] && key !== 'card_type_id' && key !== 'card_number' && key !== 'reward') {
            formDataObj.append(key, formData[key]);
          }
        } else {
          // For regular ads, skip card-specific fields
          if (key === 'card_type_id' || key === 'card_number') {
            return;
          }
          if (key === 'reward' && formData[key]) {
            formDataObj.append('reward', formData[key]);
          } else if (formData[key] && key !== 'reward') {
            formDataObj.append(key, formData[key]);
          }
        }
      });

      formDataObj.append('status', adType);  // 'lost' or 'found' depending on tab

      // Get accessToken from localStorage
      const accessToken = localStorage.getItem('accessToken');

      const res = await fetch(endpoint, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${accessToken}`,
        },
        body: formDataObj,
      });

      if (!res.ok) {
        const errorData = await res.json().catch(() => ({}));
        throw new Error(errorData.detail || 'Failed to post ad');
      }

      const response = await res.json();
      
      // Show success toast
      toast({
        title: "✅ Ad Posted Successfully!",
        description: `Your ${adType === 'lost' ? 'lost' : 'found'} item ad has been posted successfully. You'll be notified when someone responds.`,
        duration: 5000,
      });
      
      // Reset form
      setPostingKind('item');
      setFormData({
        title: '',
        item_type_id: '',
        card_type_id: '',
        card_number: '',
        location_description: '',
        exact_address: '',
        transportation_type: '',
        date_time: '',
        comments: '',
        reward: '',
        image: null,
        is_resolved: false,
      });
      
      // Navigate to profile page after a short delay to see the toast
      setTimeout(() => {
        navigate('/profile');
      }, 2000);
    } catch (error: any) {
      toast({
        title: "❌ Error Posting Ad",
        description: error.message || "Something went wrong. Please check your information and try again.",
        variant: 'destructive',
        duration: 5000,
      });
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      setFormData((prevData) => ({
        ...prevData,
        image: e.target.files[0],  // Set the image file here
      }));
    }
  };

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
          <div className="max-w-3xl mx-auto">
            <h1 className="text-3xl font-bold mb-6 text-center text-white drop-shadow-lg">Post an Ad</h1>

            <Tabs value={adType} onValueChange={setAdType} className="w-full mb-8">
              <TabsList className="grid w-full grid-cols-2 bg-white/10 backdrop-blur-md border border-white/20">
                <TabsTrigger value="lost" className="text-base text-white data-[state=active]:bg-white/20">I Lost Something</TabsTrigger>
                <TabsTrigger value="found" className="text-base text-white data-[state=active]:bg-white/20">I Found Something</TabsTrigger>
              </TabsList>
            </Tabs>

            <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6 md:p-8">
              <form onSubmit={handleSubmit} className="space-y-6">
                <div className="space-y-2">
                  <Label htmlFor="title" className="text-white">Title</Label>
                  <Input
                    id="title"
                    name="title"
                    placeholder={adType === 'lost' ? "Ex: Lost iPhone 13 Pro at Central Park" : "Ex: Found Car Keys near Starbucks"}
                    value={formData.title}
                    onChange={handleChange}
                    required
                    className="bg-white/10 border-white/20 text-white placeholder:text-gray-400 focus:border-cyan-400"
                  />
                  <p className="text-xs text-gray-300">Be specific to help others identify the item</p>
                </div>

                <div className="space-y-2">
                  <Label className="text-white">What are you posting?</Label>
                  <RadioGroup
                    value={postingKind}
                    onValueChange={(value) => {
                      setPostingKind(value as 'item' | 'card');
                      setFormData((prev) => ({
                        ...prev,
                        item_type_id: '',
                        card_type_id: '',
                        card_number: '',
                      }));
                    }}
                    className="grid grid-cols-2 gap-4"
                  >
                    <div className="flex items-center space-x-2 rounded-md border border-white/20 p-3">
                      <RadioGroupItem value="item" id="posting-item" />
                      <Label htmlFor="posting-item" className="text-white cursor-pointer">
                        Physical item
                      </Label>
                    </div>
                    <div className="flex items-center space-x-2 rounded-md border border-white/20 p-3">
                      <RadioGroupItem value="card" id="posting-card" />
                      <Label htmlFor="posting-card" className="text-white cursor-pointer">
                        Card (Visa, ID, etc.)
                      </Label>
                    </div>
                  </RadioGroup>
                </div>

                {!isCardPost && (
                  <div className="space-y-2">
                    <Label className="text-white">Item Type</Label>
                    <select
                      name="item_type_id"
                      className="w-full border border-white/20 rounded-md px-3 py-2 bg-white/10 text-white focus:border-cyan-400 focus:outline-none"
                      value={formData.item_type_id}
                      onChange={handleChange}
                      required
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

                {isCardPost && (
                  <>
                    <div className="space-y-2">
                      <Label htmlFor="card_type_id" className="text-white">Card Type</Label>
                      <select
                        id="card_type_id"
                        name="card_type_id"
                        className="w-full border border-white/20 rounded-md px-3 py-2 bg-white/10 text-white focus:border-cyan-400 focus:outline-none"
                        value={formData.card_type_id}
                        onChange={handleChange}
                        required
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
                      <Label htmlFor="card_number" className="text-white">
                        {isVisaCard ? 'Card ID' : 'Card Number'}
                      </Label>
                      <Input
                        id="card_number"
                        name="card_number"
                        placeholder={isVisaCard ? 'Enter Visa card ID' : 'Enter card number'}
                        value={formData.card_number}
                        onChange={handleChange}
                        required
                        className="bg-white/10 border-white/20 text-white placeholder:text-gray-400 focus:border-cyan-400"
                      />
                      <p className="text-xs text-gray-300">
                        {isVisaCard
                          ? 'Enter the card ID (last digits) to help identify the Visa card'
                          : 'Enter the card number to help identify the card'}
                      </p>
                    </div>
                  </>
                )}

                <div className="space-y-2">
                  <Label htmlFor="location_description" className="text-white">Location Description</Label>
                  <Textarea
                    id="location_description"
                    name="location_description"
                    placeholder="Be as specific as possible about where the item was lost/found"
                    value={formData.location_description}
                    onChange={handleChange}
                    required
                    className="bg-white/10 border-white/20 text-white placeholder:text-gray-400 focus:border-cyan-400"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="exact_address" className="text-white">Exact Address</Label>
                  <Input
                    id="exact_address"
                    name="exact_address"
                    placeholder="Street name, building number, etc."
                    value={formData.exact_address}
                    onChange={handleChange}
                    className="bg-white/10 border-white/20 text-white placeholder:text-gray-400 focus:border-cyan-400"
                  />
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-2">
                    <Label htmlFor="date_time" className="text-white">Date and Time</Label>
                    <Input
                      id="date_time"
                      name="date_time"
                      type="datetime-local"
                      value={formData.date_time}
                      onChange={handleChange}
                      required
                      className="bg-white/10 border-white/20 text-white focus:border-cyan-400"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="transportation_type" className="text-white">Transportation Type</Label>
                    <Input
                      id="transportation_type"
                      name="transportation_type"
                      placeholder="e.g., Bus, Train"
                      value={formData.transportation_type}
                      onChange={handleChange}
                      className="bg-white/10 border-white/20 text-white placeholder:text-gray-400 focus:border-cyan-400"
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="reward" className="text-white">Reward (Optional)</Label>
                  <div className="relative">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-white/70 text-lg">💰</span>
                    <Input
                      id="reward"
                      name="reward"
                      type="number"
                      min="0"
                      step="0.01"
                      placeholder="0.00"
                      value={formData.reward}
                      onChange={handleChange}
                      className="bg-white/10 border-white/20 text-white placeholder:text-gray-400 focus:border-cyan-400 pl-10"
                    />
                  </div>
                  <p className="text-xs text-gray-300">Enter the reward amount in EGP (optional)</p>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="comments" className="text-white">Additional Comments</Label>
                  <Textarea
                    id="comments"
                    name="comments"
                    placeholder="Any additional information to help identify the item"
                    value={formData.comments}
                    onChange={handleChange}
                    className="bg-white/10 border-white/20 text-white placeholder:text-gray-400 focus:border-cyan-400"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="image" className="text-white">Upload Image</Label>
                  <Input
                    id="image"
                    name="image"
                    type="file"
                    onChange={handleImageChange}
                    accept="image/*"
                    className="bg-white/10 border-white/20 text-white file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:font-semibold file:bg-cyan-500/50 file:text-white hover:file:bg-cyan-500/70"
                  />
                </div>

                <Button 
                  type="submit" 
                  className="w-full bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-600 hover:to-blue-700 text-white shadow-lg shadow-cyan-500/50 transition-all duration-300" 
                  disabled={loading}
                >
                  {loading ? 'Posting...' : adType === 'lost' ? 'Post Lost Item' : 'Post Found Item'}
                </Button>
              </form>
            </div>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
};

export default PostAd;
