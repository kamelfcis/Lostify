import React from 'react';
import { useNavigate } from 'react-router-dom';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Search, MapPin, Clock, Filter, Image } from 'lucide-react';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover';

interface SearchBarProps {
  searchQuery: string;
  setSearchQuery: (value: string) => void;

  location: string;
  setLocation: (value: string) => void;

  dateFrom: string;
  setDateFrom: (value: string) => void;

  dateTo: string;
  setDateTo: (value: string) => void;

  condition: string;
  setCondition: (value: string) => void;

  onSearch: () => void;
}

const SearchBar: React.FC<SearchBarProps> = ({
  searchQuery,
  setSearchQuery,
  location,
  setLocation,
  dateFrom,
  setDateFrom,
  dateTo,
  setDateTo,
  condition,
  setCondition,
  onSearch,
}) => {
  const navigate = useNavigate();

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSearch();
    navigate(`/search?q=${encodeURIComponent(searchQuery)}`);
  };

  return (
    <form onSubmit={handleSubmit} className="w-full max-w-3xl mx-auto">
      <div className="flex flex-col md:flex-row gap-2">
        <div className="relative flex-1">
          <Input
            type="text"
            placeholder="What are you looking for?"
            className="pl-10 py-6 rounded-xl text-base"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
          />
          <Search
            className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"
            size={18}
          />
        </div>
        <Button
          type="submit"
          className="bg-fienlost-600 hover:bg-fienlost-700 rounded-xl py-6 px-8"
        >
          Search
        </Button>
      </div>

      <div className="flex flex-wrap items-center justify-between mt-3 gap-2">
        <div className="flex flex-wrap items-center gap-2">
          <Popover>
            <PopoverTrigger asChild>
              <Button
                variant="outline"
                size="sm"
                className="flex items-center gap-1 text-gray-600"
              >
                <MapPin size={14} /> Location
              </Button>
            </PopoverTrigger>
            <PopoverContent className="w-80 p-3">
              <div className="space-y-2">
                <h4 className="font-medium">Select Location</h4>
                <Input
                  placeholder="Enter location or address"
                  value={location}
                  onChange={(e) => setLocation(e.target.value)}
                />
                <div className="grid grid-cols-2 gap-1">
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => {
                      if (navigator.geolocation) {
                        navigator.geolocation.getCurrentPosition((pos) => {
                          setLocation(`${pos.coords.latitude},${pos.coords.longitude}`);
                        });
                      }
                    }}
                  >
                    Current Location
                  </Button>
                  <Button variant="outline" size="sm">
                    Map View
                  </Button>
                </div>
              </div>
            </PopoverContent>
          </Popover>

          <Popover>
            <PopoverTrigger asChild>
              <Button
                variant="outline"
                size="sm"
                className="flex items-center gap-1 text-gray-600"
              >
                <Clock size={14} /> Date & Time
              </Button>
            </PopoverTrigger>
            <PopoverContent className="w-80 p-3">
              <div className="space-y-2">
                <h4 className="font-medium">Select Date Range</h4>
                <div className="grid gap-2">
                  <Input
                    type="date"
                    value={dateFrom}
                    onChange={(e) => setDateFrom(e.target.value)}
                  />
                  <Input
                    type="date"
                    value={dateTo}
                    onChange={(e) => setDateTo(e.target.value)}
                  />
                </div>
              </div>
            </PopoverContent>
          </Popover>

          <Popover>
            <PopoverTrigger asChild>
              <Button
                variant="outline"
                size="sm"
                className="flex items-center gap-1 text-gray-600"
              >
                <Filter size={14} /> More Filters
              </Button>
            </PopoverTrigger>
            <PopoverContent className="w-80 p-3">
              <div className="space-y-2">
                <h4 className="font-medium">Additional Filters</h4>
                <div className="space-y-2">
                  <label className="text-sm font-medium">Item Condition</label>
                  <select
                    className="w-full border border-gray-300 rounded-md p-2 text-sm"
                    value={condition}
                    onChange={(e) => setCondition(e.target.value)}
                  >
                    <option value="">Any Condition</option>
                    <option value="excellent">Excellent</option>
                    <option value="good">Good</option>
                    <option value="fair">Fair</option>
                    <option value="poor">Poor</option>
                  </select>
                </div>
              </div>
            </PopoverContent>
          </Popover>
        </div>

        <Popover>
          <PopoverTrigger asChild>
            <Button
              variant="secondary"
              size="sm"
              className="flex items-center gap-1"
            >
              <Image size={14} /> Search by Image
            </Button>
          </PopoverTrigger>
          <PopoverContent className="w-80 p-3">
            <div className="space-y-3">
              <h4 className="font-medium">Upload an image to search</h4>
              <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center">
                <p className="text-sm text-gray-500">Drag & drop or click to upload</p>
                <Input type="file" className="hidden" id="image-upload" accept="image/*" />
                <Button
                  variant="outline"
                  className="mt-2"
                  onClick={() => document.getElementById('image-upload')?.click()}
                >
                  Select Image
                </Button>
              </div>
            </div>
          </PopoverContent>
        </Popover>
      </div>
    </form>
  );
};

export default SearchBar;
