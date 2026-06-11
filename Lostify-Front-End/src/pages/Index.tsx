
import React, { useEffect, useRef } from 'react';
import Hero from '@/components/Hero';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import SearchBar from '@/components/SearchBar';
import ItemTypeCard from '@/components/ItemTypeCard';
import { Button } from '@/components/ui/button';
import { Link } from 'react-router-dom';

const Index = () => {
  const [searchQuery, setSearchQuery] = React.useState('');
  const [location, setLocation] = React.useState('');
  const [dateFrom, setDateFrom] = React.useState('');
  const [dateTo, setDateTo] = React.useState('');
  const [condition, setCondition] = React.useState('');

  // Scroll animation observer
  useEffect(() => {
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
        }
      });
    }, observerOptions);

    const elements = document.querySelectorAll('.scroll-fade-in');
    elements.forEach(el => observer.observe(el));

    return () => {
      elements.forEach(el => observer.unobserve(el));
    };
  }, []);

  const handleSearch = () => {
    // Handle search logic
  };

  // Item categories
  const itemCategories = [
    { name: 'Electronics', count: 234, icon: '📱' },
    { name: 'Wallets', count: 167, icon: '👛' },
    { name: 'Keys', count: 325, icon: '🔑' },
    { name: 'Documents', count: 189, icon: '📄' },
    { name: 'Jewelry', count: 78, icon: '💍' },
    { name: 'Bags', count: 112, icon: '🎒' },
    { name: 'Pets', count: 45, icon: '🐶' },
    { name: 'Others', count: 203, icon: '📦' },
  ];

  // Recent listings
  const recentListings = [
    {
      id: '1',
      type: 'lost',
      title: 'Lost iPhone 13 Pro',
      location: 'Central Park, New York',
      date: '2023-05-10',
      image: 'https://images.unsplash.com/photo-1616348436168-de43ad0db179?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aXBob25lJTIwMTMlMjBwcm98ZW58MHx8MHx8fDA%3D',
    },
    {
      id: '2',
      type: 'found',
      title: 'Found Car Keys',
      location: 'Starbucks on Main St.',
      date: '2023-05-09',
      image: 'https://images.unsplash.com/photo-1514316703755-dca7d7d9d882?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FyJTIwa2V5c3xlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      id: '3',
      type: 'lost',
      title: 'Blue Wallet with ID',
      location: 'City Mall Food Court',
      date: '2023-05-08',
      image: 'https://images.unsplash.com/photo-1627123424574-724758594e93?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Ymx1ZSUyMHdhbGxldHxlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      id: '4',
      type: 'found',
      title: 'Found Prescription Glasses',
      location: 'Bus #42 Downtown Line',
      date: '2023-05-07',
      image: 'https://images.unsplash.com/photo-1574258495973-f010dfbb5371?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2xhc3Nlc3xlbnwwfHwwfHx8MA%3D%3D',
    },
  ];

  return (
    <div className="flex flex-col min-h-screen">
      <Navbar />
      
      <main className="flex-grow">
        <Hero />
        
        {/* Search Section */}
        <section className="py-12 bg-gray-50 scroll-fade-in">
          <div className="container mx-auto px-4">
            <h2 className="text-center text-3xl font-bold text-gray-900 mb-8 animate-fade-in-up">Find What You're Looking For</h2>
            <div className="animate-fade-in-up stagger-1">
              <SearchBar
                searchQuery={searchQuery}
                setSearchQuery={setSearchQuery}
                location={location}
                setLocation={setLocation}
                dateFrom={dateFrom}
                setDateFrom={setDateFrom}
                dateTo={dateTo}
                setDateTo={setDateTo}
                condition={condition}
                setCondition={setCondition}
                onSearch={handleSearch}
              />
            </div>
          </div>
        </section>
        
        {/* Item Categories */}
        <section className="py-16 scroll-fade-in">
          <div className="container mx-auto px-4">
            <h2 className="text-2xl md:text-3xl font-bold text-center mb-10 animate-fade-in-up">Browse by Category</h2>
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4 md:gap-6">
              {itemCategories.map((category, index) => (
                <div key={index} className={`animate-fade-in-up stagger-${index + 1}`}>
                  <ItemTypeCard
                    icon={<span className="text-2xl">{category.icon}</span>}
                    name={category.name}
                    count={category.count}
                  />
                </div>
              ))}
            </div>
          </div>
        </section>
        
        {/* Recent Listings */}
        <section className="py-16 bg-gray-50 scroll-fade-in">
          <div className="container mx-auto px-4">
            <div className="flex justify-between items-center mb-10 animate-fade-in-up">
              <h2 className="text-2xl md:text-3xl font-bold">Recent Listings</h2>
              <Link to="/search">
                <Button variant="ghost" className="text-fienlost-600 hover:text-fienlost-700 hover:bg-fienlost-50 transition-smooth hover-scale">
                  View All
                </Button>
              </Link>
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              {recentListings.map((listing, index) => (
                <Link to={`/listing/${listing.id}`} key={listing.id} className={`group animate-fade-in-up stagger-${index + 1}`}>
                  <div className="bg-white rounded-xl overflow-hidden shadow-md hover-lift transition-smooth">
                    <div className="relative h-48 overflow-hidden">
                      <img 
                        src={listing.image} 
                        alt={listing.title}
                        className="w-full h-full object-cover transition-smooth group-hover:scale-110"
                      />
                      <div className={`absolute top-3 left-3 py-1 px-3 rounded-full text-xs font-medium ${
                        listing.type === 'lost' 
                          ? 'bg-red-100 text-red-800' 
                          : 'bg-green-100 text-green-800'
                      }`}>
                        {listing.type === 'lost' ? 'Lost' : 'Found'}
                      </div>
                    </div>
                    <div className="p-4">
                      <h3 className="font-medium text-gray-900 group-hover:text-fienlost-600 mb-2">{listing.title}</h3>
                      <div className="flex items-center text-sm text-gray-600 mb-1">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                        {listing.location}
                      </div>
                      <div className="flex items-center text-sm text-gray-600">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                        </svg>
                        {new Date(listing.date).toLocaleDateString()}
                      </div>
                    </div>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        </section>
        
        {/* How It Works */}
        <section className="py-16 scroll-fade-in">
          <div className="container mx-auto px-4">
            <h2 className="text-2xl md:text-3xl font-bold text-center mb-12 animate-fade-in-up">How Lostify Works</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <div className="text-center animate-fade-in-up stagger-1 hover-lift transition-smooth">
                <div className="bg-fienlost-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4 transition-smooth hover:scale-110 hover:bg-fienlost-200">
                  <span className="text-2xl">📝</span>
                </div>
                <h3 className="text-xl font-medium mb-2">Post an Ad</h3>
                <p className="text-gray-600">
                  Create a detailed listing with photos about your lost or found item.
                </p>
              </div>
              
              <div className="text-center animate-fade-in-up stagger-2 hover-lift transition-smooth">
                <div className="bg-fienlost-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4 transition-smooth hover:scale-110 hover:bg-fienlost-200">
                  <span className="text-2xl">🔎</span>
                </div>
                <h3 className="text-xl font-medium mb-2">Connect & Chat</h3>
                <p className="text-gray-600">
                  Get notified when someone posts about your item or claims your found item.
                </p>
              </div>
              
              <div className="text-center animate-fade-in-up stagger-3 hover-lift transition-smooth">
                <div className="bg-fienlost-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4 transition-smooth hover:scale-110 hover:bg-fienlost-200">
                  <span className="text-2xl">🤝</span>
                </div>
                <h3 className="text-xl font-medium mb-2">Arrange Return</h3>
                <p className="text-gray-600">
                  Meet safely to return the item or use our secure delivery option.
                </p>
              </div>
            </div>
            
            <div className="mt-12 text-center animate-fade-in-up stagger-4">
              <Link to="/register">
                <Button size="lg" className="bg-fienlost-600 hover:bg-fienlost-700 shadow-button transition-smooth hover-scale animate-pulse-glow">
                  Get Started
                </Button>
              </Link>
            </div>
          </div>
        </section>
        
        {/* Testimonials */}
        <section className="py-16 bg-gray-50 scroll-fade-in">
          <div className="container mx-auto px-4">
            <h2 className="text-2xl md:text-3xl font-bold text-center mb-12 animate-fade-in-up">Success Stories</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <blockquote className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 animate-fade-in-up stagger-1 hover-lift transition-smooth">
                <div className="flex items-center mb-4">
                  <div className="mr-4">
                    <div className="bg-blue-100 rounded-full w-10 h-10 flex items-center justify-center">
                      <span className="text-blue-600 font-medium">JD</span>
                    </div>
                  </div>
                  <div>
                    <div className="font-medium">John Doe</div>
                    <div className="text-sm text-gray-500">New York</div>
                  </div>
                </div>
                <p className="text-gray-600 italic">
                  "I lost my wallet with all my IDs at a concert. Within 24 hours, someone had found it and contacted me through Lostify. Saved me so much hassle!"
                </p>
              </blockquote>
              
              <blockquote className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 animate-fade-in-up stagger-2 hover-lift transition-smooth">
                <div className="flex items-center mb-4">
                  <div className="mr-4">
                    <div className="bg-green-100 rounded-full w-10 h-10 flex items-center justify-center">
                      <span className="text-green-600 font-medium">AS</span>
                    </div>
                  </div>
                  <div>
                    <div className="font-medium">Alice Smith</div>
                    <div className="text-sm text-gray-500">Chicago</div>
                  </div>
                </div>
                <p className="text-gray-600 italic">
                  "Found a lost phone on the subway and used Lostify to locate the owner. The platform made it easy to connect safely and return the device."
                </p>
              </blockquote>
              
              <blockquote className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 animate-fade-in-up stagger-3 hover-lift transition-smooth">
                <div className="flex items-center mb-4">
                  <div className="mr-4">
                    <div className="bg-purple-100 rounded-full w-10 h-10 flex items-center justify-center">
                      <span className="text-purple-600 font-medium">MJ</span>
                    </div>
                  </div>
                  <div>
                    <div className="font-medium">Mike Johnson</div>
                    <div className="text-sm text-gray-500">San Francisco</div>
                  </div>
                </div>
                <p className="text-gray-600 italic">
                  "My pet dog ran away during a storm. I posted on Lostify with his photo, and someone found him just 2 miles away! Eternally grateful for this service."
                </p>
              </blockquote>
            </div>
          </div>
        </section>
        
        {/* CTA Section */}
        <section className="py-20 bg-gradient-to-r from-fienlost-600 to-fienlost-800 text-white scroll-fade-in animate-gradient">
          <div className="container mx-auto px-4 text-center">
            <h2 className="text-3xl md:text-4xl font-bold mb-6 animate-fade-in-up">Ready to Find What You Lost?</h2>
            <p className="text-lg mb-8 max-w-2xl mx-auto opacity-90 animate-fade-in-up stagger-1">
              Join thousands of users who have successfully reunited with their belongings through Lostify.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center animate-fade-in-up stagger-2">
              <Link to="/register">
                <Button size="lg" variant="secondary" className="text-fienlost-700 hover:text-fienlost-800 transition-smooth hover-scale">
                  Sign Up Free
                </Button>
              </Link>
              <Link to="/search">
                <Button size="lg" variant="outline" className="text-white border-white hover:bg-white/10 transition-smooth hover-scale">
                  Browse Listings
                </Button>
              </Link>
            </div>
          </div>
        </section>
      </main>
      
      <Footer />
    </div>
  );
};

export default Index;
