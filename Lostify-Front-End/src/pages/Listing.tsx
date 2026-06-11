import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import { MapPin, Calendar, Truck, MessageSquare, User, ArrowLeft } from 'lucide-react';
import { apiUrl, mediaUrl } from '@/lib/api';

interface ListingData {
  id: number;
  status: 'lost' | 'found';
  title: string;
  location_description: string;
  exact_address?: string;
  transportation_type?: string;
  date_time: string;
  comments?: string;
  image?: string;
  reward?: number;
  is_resolved: boolean;
  created_at: string;
  user: {
    id: number;
    username: string;
    email?: string;
    location?: string;
  };
  item_type?: { id: number; name: string };
  card_type?: { id: number; name: string };
  card_number?: string;
  isCardAd?: boolean;
}

const Listing = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [listing, setListing] = useState<ListingData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Scroll to top when component mounts or ID changes
  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }, [id]);

  useEffect(() => {
    const fetchListing = async () => {
      if (!id) {
        setError('Invalid listing ID');
        setLoading(false);
        return;
      }

      setLoading(true);
      setError(null);

      try {
        // Try to fetch from both endpoints in parallel
        const [regularAdResponse, cardAdResponse] = await Promise.allSettled([
          fetch(apiUrl(`ads/${id}/`)),
          fetch(apiUrl(`card-ads/${id}/`))
        ]);

        let data: any = null;
        let isCardAd = false;

        // Check regular ad first
        if (regularAdResponse.status === 'fulfilled' && regularAdResponse.value.ok) {
          data = await regularAdResponse.value.json();
          isCardAd = false;
        }
        // If regular ad not found, check card ad
        else if (cardAdResponse.status === 'fulfilled' && cardAdResponse.value.ok) {
          data = await cardAdResponse.value.json();
          isCardAd = true;
        } else {
          throw new Error('Listing not found');
        }

        setListing({
          ...data,
          isCardAd,
        });
      } catch (err: any) {
        setError(err.message || 'Failed to load listing');
      } finally {
        setLoading(false);
      }
    };

    fetchListing();
  }, [id]);

  if (loading) {
    return (
      <div className="flex flex-col min-h-screen relative overflow-hidden">
        {/* Futuristic Background */}
        <div className="fixed inset-0 -z-10">
          <div className="absolute inset-0 bg-gradient-to-br from-slate-900 via-blue-900 to-purple-900 animate-gradient"></div>
          <div className="absolute inset-0 bg-[linear-gradient(rgba(56,189,248,0.1)_1px,transparent_1px),linear-gradient(90deg,rgba(56,189,248,0.1)_1px,transparent_1px)] bg-[size:50px_50px] animate-pulse"></div>
        </div>
        <Navbar />
        <main className="flex-grow py-12 relative z-10">
          <div className="container mx-auto px-4">
            <div className="text-center text-white py-20">
              <div className="animate-pulse">Loading...</div>
            </div>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  if (error || !listing) {
    return (
      <div className="flex flex-col min-h-screen relative overflow-hidden">
        {/* Futuristic Background */}
        <div className="fixed inset-0 -z-10">
          <div className="absolute inset-0 bg-gradient-to-br from-slate-900 via-blue-900 to-purple-900 animate-gradient"></div>
          <div className="absolute inset-0 bg-[linear-gradient(rgba(56,189,248,0.1)_1px,transparent_1px),linear-gradient(90deg,rgba(56,189,248,0.1)_1px,transparent_1px)] bg-[size:50px_50px] animate-pulse"></div>
        </div>
        <Navbar />
        <main className="flex-grow py-12 relative z-10">
          <div className="container mx-auto px-4">
            <div className="text-center text-white py-20">
              <h1 className="text-2xl font-bold mb-4">Listing Not Found</h1>
              <p className="text-gray-300 mb-6">{error || 'The listing you are looking for does not exist.'}</p>
              <Button onClick={() => navigate('/search')} className="bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-600 hover:to-blue-700">
                Back to Search
              </Button>
            </div>
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
            {/* Back Button */}
            <Button
              onClick={() => navigate(-1)}
              variant="ghost"
              className="mb-6 text-white hover:bg-white/10"
            >
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back
            </Button>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
              {/* Main Content */}
              <div className="lg:col-span-2 space-y-6">
                {/* Image Section */}
                <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 overflow-hidden">
                  {listing.image ? (
                    <img
                      src={mediaUrl(listing.image)}
                      alt={listing.title}
                      className="w-full h-96 object-cover"
                    />
                  ) : (
                    <div className="w-full h-96 flex items-center justify-center bg-gray-800/50 text-gray-400">
                      No Image Available
                    </div>
                  )}
                </div>

                {/* Details Section */}
                <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6 md:p-8">
                  <div className="flex items-start justify-between mb-6">
                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-3 flex-wrap">
                        <h1 className="text-3xl font-bold text-white">{listing.title}</h1>
                        <span
                          className={`px-3 py-1 rounded-full text-xs font-medium backdrop-blur-sm ${
                            listing.status === 'lost'
                              ? 'bg-red-500/80 text-white shadow-lg shadow-red-500/50'
                              : 'bg-green-500/80 text-white shadow-lg shadow-green-500/50'
                          }`}
                        >
                          {listing.status.charAt(0).toUpperCase() + listing.status.slice(1)}
                        </span>
                        {listing.reward && (
                          <div className="px-4 py-2 bg-gradient-to-r from-yellow-500/90 to-orange-500/90 rounded-lg border border-yellow-400/50 shadow-lg shadow-yellow-500/50 backdrop-blur-sm">
                            <div className="flex items-center gap-2">
                              <span className="text-xl">💰</span>
                              <div>
                                <p className="text-xs text-yellow-100 font-medium">Reward</p>
                                <p className="text-lg font-bold text-white">{listing.reward} EGP</p>
                              </div>
                            </div>
                          </div>
                        )}
                      </div>
                      {listing.isCardAd && (
                        <div className="flex flex-wrap gap-4 mt-3">
                          {listing.card_type && (
                            <div className="px-4 py-2 bg-cyan-500/20 rounded-lg border border-cyan-400/30">
                              <span className="text-sm text-cyan-200 font-medium">Card Type: </span>
                              <span className="text-sm text-white">{listing.card_type.name}</span>
                            </div>
                          )}
                          {listing.card_number && (
                            <div className="px-4 py-2 bg-cyan-500/20 rounded-lg border border-cyan-400/30">
                              <span className="text-sm text-cyan-200 font-medium">Card Number: </span>
                              <span className="text-sm text-white">{listing.card_number}</span>
                            </div>
                          )}
                        </div>
                      )}
                      {!listing.isCardAd && listing.item_type && (
                        <div className="mt-3">
                          <span className="px-4 py-2 bg-blue-500/20 rounded-lg border border-blue-400/30 text-sm text-blue-200">
                            {listing.item_type.name}
                          </span>
                        </div>
                      )}
                    </div>
                  </div>

                  {/* Description */}
                  <div className="mb-6">
                    <h2 className="text-xl font-semibold text-white mb-3">Description</h2>
                    <p className="text-gray-200 leading-relaxed">{listing.location_description}</p>
                  </div>

                  {/* Additional Information */}
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                    {listing.exact_address && (
                      <div className="flex items-start gap-3">
                        <MapPin className="h-5 w-5 text-cyan-400 mt-1 flex-shrink-0" />
                        <div>
                          <p className="text-sm text-gray-300 mb-1">Exact Address</p>
                          <p className="text-white">{listing.exact_address}</p>
                        </div>
                      </div>
                    )}

                    <div className="flex items-start gap-3">
                      <Calendar className="h-5 w-5 text-cyan-400 mt-1 flex-shrink-0" />
                      <div>
                        <p className="text-sm text-gray-300 mb-1">Date & Time</p>
                        <p className="text-white">{new Date(listing.date_time).toLocaleString()}</p>
                      </div>
                    </div>

                    {listing.transportation_type && (
                      <div className="flex items-start gap-3">
                        <Truck className="h-5 w-5 text-cyan-400 mt-1 flex-shrink-0" />
                        <div>
                          <p className="text-sm text-gray-300 mb-1">Transportation</p>
                          <p className="text-white">{listing.transportation_type}</p>
                        </div>
                      </div>
                    )}

                  </div>

                  {/* Comments */}
                  {listing.comments && (
                    <div className="mb-6">
                      <h2 className="text-xl font-semibold text-white mb-3">Additional Comments</h2>
                      <p className="text-gray-200 leading-relaxed">{listing.comments}</p>
                    </div>
                  )}
                </div>
              </div>

              {/* Sidebar */}
              <div className="lg:col-span-1">
                <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-6 sticky top-24">
                  {/* User Info */}
                  <div className="mb-6">
                    <div className="flex items-center gap-3 mb-4">
                      <div className="h-12 w-12 rounded-full bg-gradient-to-br from-cyan-400 to-blue-500 flex items-center justify-center text-white font-bold">
                        <User className="h-6 w-6" />
                      </div>
                      <div>
                        <p className="text-white font-medium">{listing.user.username}</p>
                        {listing.user.location && (
                          <p className="text-sm text-gray-300">{listing.user.location}</p>
                        )}
                      </div>
                    </div>
                  </div>

                  {/* Reward Banner */}
                  {listing.reward && (
                    <div className="mb-6 p-4 bg-gradient-to-r from-yellow-500/20 to-orange-500/20 rounded-lg border border-yellow-400/30 backdrop-blur-sm">
                      <div className="flex items-center justify-between">
                        <div>
                          <p className="text-xs text-yellow-200 font-medium mb-1">Reward Offered</p>
                          <p className="text-2xl font-bold text-white">{listing.reward} EGP</p>
                        </div>
                        <span className="text-3xl">💰</span>
                      </div>
                    </div>
                  )}

                  {/* Contact Button */}
                  <Button
                    className="w-full bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-600 hover:to-blue-700 text-white shadow-lg shadow-cyan-500/50 mb-4"
                    onClick={() => {
                      // TODO: Implement contact functionality
                      alert('Contact functionality coming soon!');
                    }}
                  >
                    <MessageSquare className="mr-2 h-4 w-4" />
                    Contact Owner
                  </Button>

                  {/* Post Info */}
                  <div className="space-y-3 pt-4 border-t border-white/20">
                    <div className="flex justify-between text-sm">
                      <span className="text-gray-300">Posted</span>
                      <span className="text-white">
                        {new Date(listing.created_at).toLocaleDateString()}
                      </span>
                    </div>
                    <div className="flex justify-between text-sm">
                      <span className="text-gray-300">Status</span>
                      <span className={`font-medium ${
                        listing.is_resolved ? 'text-green-400' : 'text-yellow-400'
                      }`}>
                        {listing.is_resolved ? 'Resolved' : 'Active'}
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
};

export default Listing;

