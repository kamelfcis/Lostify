import React, { useState, useEffect } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import SearchBar from '@/components/SearchBar';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import { apiUrl } from '@/lib/api';
import { toast } from '@/components/ui/use-toast';

interface AdItem {
  id: number;
  status: 'lost' | 'found';
  title: string;
  location: string | null;
  date_time: string;
  description: string;
  image: string | null;
  reward?: number;
  item_type?: { name: string };
  card_type?: { name: string };
  card_number?: string;
  isCardAd?: boolean;
}

const Search = () => {
  const [searchParams] = useSearchParams();
  const initialQuery = searchParams.get('q') || '';

  const [searchResults, setSearchResults] = useState<AdItem[]>([]);
  const [loading, setLoading] = useState(false);
  const [imageSearchLoading, setImageSearchLoading] = useState(false);

  // Lifted filter/search states
  const [searchQuery, setSearchQuery] = useState(initialQuery);
  const [filterStatus, setFilterStatus] = useState<'all' | 'lost' | 'found'>('all');
  const [filterType, setFilterType] = useState<string>('all');
  const [sortBy, setSortBy] = useState('date');

  useEffect(() => {
    setLoading(true);
    
    // Fetch both regular ads and card ads
    Promise.all([
      fetch(apiUrl('ads/')).then(res => res.json()),
      fetch(apiUrl('card-ads/')).then(res => res.json())
    ])
      .then(([adsData, cardAdsData]: [any[], any[]]) => {
        // Map regular ads
        const regularAds = adsData.map(ad => ({
          id: ad.id,
          status: ad.status,
          title: ad.title,
          location: ad.user?.location || 'Unknown',
          date_time: ad.date_time,
          description: ad.location_description || '',
          image: ad.image,
          reward: ad.reward,
          item_type: ad.item_type,
          isCardAd: false,
        }));
        
        // Map card ads
        const cardAds = cardAdsData.map(ad => ({
          id: ad.id,
          status: ad.status,
          title: ad.title,
          location: ad.user?.location || 'Unknown',
          date_time: ad.date_time,
          description: ad.location_description || '',
          image: ad.image,
          reward: ad.reward,
          card_type: ad.card_type,
          card_number: ad.card_number,
          isCardAd: true,
        }));
        
        // Combine both types of ads
        setSearchResults([...regularAds, ...cardAds]);
      })
      .catch(error => {
        console.error('Error fetching ads:', error);
      })
      .finally(() => setLoading(false));
  }, []);

  // Filter results based on search and filters
  const filteredResults = searchResults.filter(item => {
    if (filterStatus !== 'all' && item.status !== filterStatus) return false;

    if (filterType !== 'all') {
      if (item.isCardAd) {
        // For card ads, check card_type
        if (item.card_type?.name.toLowerCase() !== filterType.toLowerCase()) return false;
      } else {
        // For regular ads, check item_type
        if (item.item_type?.name.toLowerCase() !== filterType.toLowerCase()) return false;
      }
    }

    if (searchQuery.trim() !== '') {
      const queryLower = searchQuery.toLowerCase();
      const queryDigits = searchQuery.replace(/\D/g, '');
      const titleMatch = item.title.toLowerCase().includes(queryLower);
      const descMatch = item.description.toLowerCase().includes(queryLower);

      const isCardSearch =
        filterType === 'visa' ||
        filterType === 'national card' ||
        queryDigits.length >= 4;

      let cardMatch = false;
      if (item.isCardAd && queryDigits && isCardSearch) {
        const adDigits = (item.card_number || '').replace(/\D/g, '');
        cardMatch = adDigits.includes(queryDigits);
      }

      if (!titleMatch && !descMatch && !cardMatch) return false;
    }

    return true;
  });

  // Sort results
  const sortedResults = filteredResults.sort((a, b) => {
    if (sortBy === 'date') {
      return new Date(b.date_time).getTime() - new Date(a.date_time).getTime();
    }
    return 0;
  });

  // Extract unique item types and card types for filter dropdown
  const uniqueTypes = Array.from(new Set(
    searchResults.map(item => 
      item.isCardAd ? item.card_type?.name : item.item_type?.name
    ).filter(Boolean)
  )).sort();

  const handleImageSearch = async (file: File) => {
    setImageSearchLoading(true);
    try {
      const formData = new FormData();
      formData.append('image', file);

      const accessToken = localStorage.getItem('accessToken');
      const headers: HeadersInit = {};
      if (accessToken) {
        headers['Authorization'] = `Bearer ${accessToken}`;
      }

      const res = await fetch(apiUrl('search/by-image/'), {
        method: 'POST',
        headers,
        body: formData,
      });

      if (!res.ok) {
        const errorData = await res.json().catch(() => ({}));
        throw new Error(errorData.detail || errorData.error || 'Image classification failed');
      }

      const data = await res.json();
      const category = data.category as string;
      if (!category) {
        throw new Error('No category returned from image search');
      }

      setFilterType(category.toLowerCase());
      setSearchQuery(category);
      toast({
        title: 'Image classified',
        description: `Showing results for ${category}`,
      });
    } catch (error: unknown) {
      const message = error instanceof Error ? error.message : 'Image search failed';
      toast({
        title: 'Image search failed',
        description: message,
        variant: 'destructive',
      });
    } finally {
      setImageSearchLoading(false);
    }
  };

  const applyFilters = () => {
    // Filtering is reactive via state
  };

  // Clear all filters & search
  const clearFilters = () => {
    setFilterStatus('all');
    setFilterType('all');
    setSearchQuery('');
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
          <div className="mb-10">
            <h1 className="text-3xl font-bold mb-6 text-center text-white drop-shadow-lg">Search Lost & Found Items</h1>
            <SearchBar
              searchQuery={searchQuery}
              setSearchQuery={setSearchQuery}
              location={''} // Extend SearchBar & state if needed
              setLocation={() => {}}
              dateFrom={''}
              setDateFrom={() => {}}
              dateTo={''}
              setDateTo={() => {}}
              condition={''}
              setCondition={() => {}}
              onSearch={applyFilters}
              onImageSearch={handleImageSearch}
              imageSearchLoading={imageSearchLoading}
            />
          </div>

          <div className="flex flex-col md:flex-row gap-6">
            {/* Filters Sidebar */}
            <div className="md:w-64 flex-shrink-0">
              <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-5 sticky top-24">
                <h2 className="font-medium text-lg mb-4 text-white">Filters</h2>

                <div className="space-y-5">
                  <div>
                    <label className="text-sm font-medium block mb-2 text-white">Item Type</label>
                    <Select value={filterType} onValueChange={setFilterType}>
                      <SelectTrigger>
                        <SelectValue placeholder="All Types" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="all">All Types</SelectItem>
                        {uniqueTypes.map(type => (
                          <SelectItem key={type} value={type.toLowerCase()}>
                            {type}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>

                  <div>
                    <label className="text-sm font-medium block mb-2 text-white">Item Status</label>
                    <div className="space-y-1">
                      <div className="flex items-center gap-2">
                        <input
                          type="radio"
                          id="all-items"
                          name="status"
                          checked={filterStatus === 'all'}
                          onChange={() => setFilterStatus('all')}
                          className="h-4 w-4 rounded-full"
                        />
                        <label htmlFor="all-items" className="text-white">All Items</label>
                      </div>
                      <div className="flex items-center gap-2">
                        <input
                          type="radio"
                          id="lost-items"
                          name="status"
                          checked={filterStatus === 'lost'}
                          onChange={() => setFilterStatus('lost')}
                          className="h-4 w-4 rounded-full"
                        />
                        <label htmlFor="lost-items" className="text-white">Lost Items</label>
                      </div>
                      <div className="flex items-center gap-2">
                        <input
                          type="radio"
                          id="found-items"
                          name="status"
                          checked={filterStatus === 'found'}
                          onChange={() => setFilterStatus('found')}
                          className="h-4 w-4 rounded-full"
                        />
                        <label htmlFor="found-items" className="text-white">Found Items</label>
                      </div>
                    </div>
                  </div>

                  <Button className="w-full bg-fienlost-600 hover:bg-fienlost-700" onClick={applyFilters}>
                    Apply Filters
                  </Button>

                  <Button variant="outline" className="w-full" onClick={clearFilters}>
                    Clear Filters
                  </Button>
                </div>
              </div>
            </div>

            {/* Search Results */}
            <div className="flex-1">
              {loading ? (
                <>
                  {/* Skeleton Results Header */}
                  <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-5 mb-6">
                    <div className="h-6 w-48 bg-white/10 rounded animate-pulse"></div>
                  </div>
                  
                  {/* Skeleton Cards */}
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {[...Array(6)].map((_, index) => (
                      <div
                        key={index}
                        className="bg-white/10 backdrop-blur-md rounded-xl overflow-hidden shadow-lg border border-white/20 relative overflow-hidden"
                      >
                        {/* Shimmer Effect */}
                        <div className="absolute inset-0 -translate-x-full animate-shimmer bg-gradient-to-r from-transparent via-white/10 to-transparent"></div>
                        
                        {/* Skeleton Image */}
                        <div className="relative h-48 bg-gradient-to-br from-white/10 to-white/5">
                          <div className="absolute top-3 left-3 w-16 h-6 bg-white/20 rounded-full"></div>
                        </div>
                        
                        {/* Skeleton Content */}
                        <div className="p-4 space-y-3 relative">
                          {/* Skeleton Title */}
                          <div className="h-5 bg-white/10 rounded w-3/4"></div>
                          
                          {/* Skeleton Description Lines */}
                          <div className="space-y-2">
                            <div className="h-3 bg-white/10 rounded w-full"></div>
                            <div className="h-3 bg-white/10 rounded w-5/6"></div>
                          </div>
                          
                          {/* Skeleton Info Lines */}
                          <div className="space-y-2 pt-2">
                            <div className="h-3 bg-white/10 rounded w-1/2"></div>
                            <div className="h-3 bg-white/10 rounded w-2/3"></div>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </>
              ) : (
                <>
                  <div className="bg-white/10 backdrop-blur-md rounded-xl shadow-lg border border-white/20 p-5 mb-6">
                    <h2 className="font-medium text-white">{sortedResults.length} Results Found</h2>
                  </div>
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {sortedResults.length > 0 ? (
                      sortedResults.map((item, index) => (
                        <Link 
                          to={`/listing/${item.id}`} 
                          key={item.id} 
                          className="group animate-fade-in-up"
                          style={{ 
                            animationDelay: `${index * 0.1}s`,
                            animationFillMode: 'both'
                          }}
                        >
                          <div className="bg-white/10 backdrop-blur-md rounded-xl overflow-hidden shadow-lg hover:shadow-2xl border border-white/20 transition-all duration-300 hover:scale-105 hover:-translate-y-2 hover:bg-white/20">
                            <div className="relative h-48 overflow-hidden">
                              {item.image ? (
                                <img
                                  src={item.image}
                                  alt={item.title}
                                  className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                />
                              ) : (
                                <div className="flex justify-center items-center h-full bg-gray-100 text-gray-400">
                                  No Image
                                </div>
                              )}
                              <div
                                className={`absolute top-3 left-3 py-1 px-3 rounded-full text-xs font-medium backdrop-blur-sm ${
                                  item.status === 'lost' 
                                    ? 'bg-red-500/80 text-white shadow-lg shadow-red-500/50' 
                                    : 'bg-green-500/80 text-white shadow-lg shadow-green-500/50'
                                }`}
                              >
                                {item.status.charAt(0).toUpperCase() + item.status.slice(1)}
                              </div>
                              {item.reward && (
                                <div className="absolute top-3 right-3 px-3 py-1 bg-gradient-to-r from-yellow-500/90 to-orange-500/90 rounded-lg border border-yellow-400/50 shadow-lg shadow-yellow-500/50 backdrop-blur-sm">
                                  <div className="flex items-center gap-1">
                                    <span className="text-sm">💰</span>
                                    <span className="text-xs font-bold text-white">{item.reward} EGP</span>
                                  </div>
                                </div>
                              )}
                            </div>
                            <div className="p-4">
                              <h3 className="font-medium text-white group-hover:text-cyan-300 mb-2 transition-colors">{item.title}</h3>
                              <p className="text-sm text-gray-200 line-clamp-2 mb-3">{item.description}</p>
                              
                              {/* Show card type and card number for card ads */}
                              {item.isCardAd && (
                                <div className="mb-3 space-y-1">
                                  {item.card_type && (
                                    <div className="flex items-center text-sm text-cyan-200">
                                      <span className="font-medium mr-2">Card Type:</span>
                                      <span>{item.card_type.name}</span>
                                    </div>
                                  )}
                                  {item.card_number && (
                                    <div className="flex items-center text-sm text-cyan-200">
                                      <span className="font-medium mr-2">Card Number:</span>
                                      <span>{item.card_number}</span>
                                    </div>
                                  )}
                                </div>
                              )}
                              
                              <div className="flex items-center text-sm text-gray-300 mb-1">
                                <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                </svg>
                                {item.location}
                              </div>
                              <div className="flex items-center text-sm text-gray-300">
                                <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                </svg>
                                {new Date(item.date_time).toLocaleDateString()}
                              </div>
                            </div>
                          </div>
                        </Link>
                      ))
                    ) : (
                      <div className="col-span-full py-12 text-center">
                        <div className="text-5xl mb-4">🔍</div>
                        <h3 className="text-xl font-medium mb-2 text-white">No results found</h3>
                        <p className="text-gray-300 mb-6">Try adjusting your search or filter criteria</p>
                        <Button onClick={clearFilters} variant="outline">
                          Clear Filters
                        </Button>
                      </div>
                    )}
                  </div>
                </>
              )}
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default Search;
