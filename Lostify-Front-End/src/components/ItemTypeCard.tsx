
import React from 'react';
import { Link } from 'react-router-dom';
import { cn } from '@/lib/utils';

interface ItemTypeCardProps {
  icon: React.ReactNode;
  name: string;
  count: number;
  className?: string;
}

const ItemTypeCard: React.FC<ItemTypeCardProps> = ({ icon, name, count, className }) => {
  return (
    <Link 
      to={`/search?type=${name.toLowerCase()}`} 
      className={cn(
        "group flex flex-col items-center p-4 rounded-xl transition-smooth hover-lift hover:bg-white hover:shadow-xl border border-transparent hover:border-gray-100",
        className
      )}
    >
      <div className="w-16 h-16 flex items-center justify-center rounded-full bg-fienlost-100 group-hover:bg-fienlost-200 mb-3 transition-smooth group-hover:scale-110">
        {icon}
      </div>
      <h3 className="font-medium text-gray-900 group-hover:text-fienlost-600 transition-smooth">{name}</h3>
      <p className="text-sm text-gray-500">{count} items</p>
    </Link>
  );
};

export default ItemTypeCard;
