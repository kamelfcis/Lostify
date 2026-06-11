
import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';

const Hero = () => {
  return (
    <div className="relative overflow-hidden bg-gradient-to-b from-blue-50 to-white">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row items-center justify-between py-16 md:py-24">
          <div className="md:w-1/2 mb-12 md:mb-0 animate-fade-in-left">
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold tracking-tight text-gray-900 mb-6">
              <span className="block animate-fade-in-up">Lost something?</span>
              <span className="block text-fienlost-600 animate-fade-in-up stagger-1">Find it with Lostify</span>
            </h1>
            
            <p className="text-lg md:text-xl text-gray-600 mb-8 max-w-lg animate-fade-in-up stagger-2">
              The fastest way to recover your lost items or help others find theirs. Join our community of finders and seekers today.
            </p>
            
            <div className="flex flex-col sm:flex-row gap-4 animate-fade-in-up stagger-3">
              <Link to="/post-ad?type=lost">
                <Button size="lg" className="bg-fienlost-600 hover:bg-fienlost-700 shadow-button w-full sm:w-auto">
                  I Lost Something
                </Button>
              </Link>
              <Link to="/post-ad?type=found">
                <Button size="lg" variant="outline" className="border-fienlost-600 text-fienlost-600 hover:bg-fienlost-50 w-full sm:w-auto">
                  I Found Something
                </Button>
              </Link>
            </div>
          </div>
          
          <div className="md:w-1/2 relative animate-fade-in-right">
            <div className="w-full h-64 md:h-96 relative">
              {/* Abstract illustration */}
              <div className="absolute inset-0 flex items-center justify-center">
                <div className="relative w-64 h-64 md:w-80 md:h-80 animate-scale-in">
                  <div className="absolute w-full h-full rounded-full bg-fienlost-200 animate-pulse-slow"></div>
                  <div className="absolute w-3/4 h-3/4 top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 rounded-full bg-fienlost-300 animate-pulse-slow" style={{ animationDelay: "0.5s" }}></div>
                  <div className="absolute w-1/2 h-1/2 top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 rounded-full bg-fienlost-400 animate-pulse-slow" style={{ animationDelay: "1s" }}></div>
                  
                  {/* Floating items */}
                  <div className="absolute top-10 right-8 bg-white p-2 rounded-xl shadow-lg transform rotate-3 animate-float hover-scale transition-smooth" style={{ animationDuration: "5s" }}>
                    <div className="w-10 h-10 bg-yellow-500 rounded-lg flex items-center justify-center">
                      <span className="text-white font-bold text-xs">🔑</span>
                    </div>
                  </div>
                  
                  <div className="absolute bottom-16 left-6 bg-white p-2 rounded-xl shadow-lg transform -rotate-6 animate-float hover-scale transition-smooth" style={{ animationDuration: "6s", animationDelay: "0.5s" }}>
                    <div className="w-10 h-10 bg-blue-500 rounded-lg flex items-center justify-center">
                      <span className="text-white font-bold text-xs">👛</span>
                    </div>
                  </div>
                  
                  <div className="absolute top-24 left-12 bg-white p-2 rounded-xl shadow-lg transform rotate-12 animate-float hover-scale transition-smooth" style={{ animationDuration: "7s", animationDelay: "1s" }}>
                    <div className="w-10 h-10 bg-green-500 rounded-lg flex items-center justify-center">
                      <span className="text-white font-bold text-xs">📱</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      {/* Stats section */}
      <div className="bg-white py-10 border-t border-gray-100">
        <div className="container mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
            <div className="animate-fade-in-up stagger-1 hover-scale transition-smooth">
              <p className="text-3xl font-bold text-fienlost-600 animate-count-up">10K+</p>
              <p className="text-gray-600">Items Found</p>
            </div>
            <div className="animate-fade-in-up stagger-2 hover-scale transition-smooth">
              <p className="text-3xl font-bold text-fienlost-600 animate-count-up">5K+</p>
              <p className="text-gray-600">Happy Users</p>
            </div>
            <div className="animate-fade-in-up stagger-3 hover-scale transition-smooth">
              <p className="text-3xl font-bold text-fienlost-600 animate-count-up">95%</p>
              <p className="text-gray-600">Success Rate</p>
            </div>
            <div className="animate-fade-in-up stagger-4 hover-scale transition-smooth">
              <p className="text-3xl font-bold text-fienlost-600 animate-count-up">24h</p>
              <p className="text-gray-600">Avg. Recovery</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Hero;
