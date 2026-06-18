import React, { useEffect, useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { adminGet } from '@/lib/adminApi';
import { Users, FileText, CreditCard, Tag, Layers, TrendingUp } from 'lucide-react';

interface StatCard {
  label: string;
  count: number | null;
  icon: React.ElementType;
  color: string;
  bg: string;
  border: string;
}

const Dashboard = () => {
  const [stats, setStats] = useState({
    users: null as number | null,
    ads: null as number | null,
    cardAds: null as number | null,
    itemTypes: null as number | null,
    cardTypes: null as number | null,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const load = async () => {
      setLoading(true);
      try {
        const [users, ads, cardAds, itemTypes, cardTypes] = await Promise.allSettled([
          adminGet<unknown[]>('users/'),
          adminGet<unknown[]>('ads/'),
          adminGet<unknown[]>('card-ads/'),
          adminGet<unknown[]>('item-types/'),
          adminGet<unknown[]>('card-types/'),
        ]);

        setStats({
          users: users.status === 'fulfilled' ? users.value.length : null,
          ads: ads.status === 'fulfilled' ? ads.value.length : null,
          cardAds: cardAds.status === 'fulfilled' ? cardAds.value.length : null,
          itemTypes: itemTypes.status === 'fulfilled' ? itemTypes.value.length : null,
          cardTypes: cardTypes.status === 'fulfilled' ? cardTypes.value.length : null,
        });
      } finally {
        setLoading(false);
      }
    };
    load();
  }, []);

  const cards: StatCard[] = [
    {
      label: 'Total Users',
      count: stats.users,
      icon: Users,
      color: 'text-blue-600',
      bg: 'bg-blue-50',
      border: 'border-blue-100',
    },
    {
      label: 'Total Ads',
      count: stats.ads,
      icon: FileText,
      color: 'text-emerald-600',
      bg: 'bg-emerald-50',
      border: 'border-emerald-100',
    },
    {
      label: 'Total Card Ads',
      count: stats.cardAds,
      icon: CreditCard,
      color: 'text-purple-600',
      bg: 'bg-purple-50',
      border: 'border-purple-100',
    },
    {
      label: 'Item Types',
      count: stats.itemTypes,
      icon: Tag,
      color: 'text-orange-600',
      bg: 'bg-orange-50',
      border: 'border-orange-100',
    },
    {
      label: 'Card Types',
      count: stats.cardTypes,
      icon: Layers,
      color: 'text-rose-600',
      bg: 'bg-rose-50',
      border: 'border-rose-100',
    },
  ];

  return (
    <div>
      <div className="mb-8">
        <h2 className="text-2xl font-bold text-gray-900">Overview</h2>
        <p className="text-gray-500 mt-1">Welcome to the Lostify admin dashboard.</p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 2xl:grid-cols-5 gap-5">
        {cards.map(({ label, count, icon: Icon, color, bg, border }) => (
          <Card key={label} className={`border ${border} shadow-sm hover:shadow-md transition-shadow`}>
            <CardHeader className="flex flex-row items-center justify-between pb-2 space-y-0">
              <CardTitle className="text-sm font-medium text-gray-600">{label}</CardTitle>
              <div className={`p-2 rounded-lg ${bg}`}>
                <Icon size={18} className={color} />
              </div>
            </CardHeader>
            <CardContent>
              {loading ? (
                <div className="h-8 w-16 bg-gray-200 animate-pulse rounded" />
              ) : (
                <p className="text-3xl font-bold text-gray-900">{count ?? '—'}</p>
              )}
              <div className="flex items-center gap-1 mt-2">
                <TrendingUp size={13} className="text-gray-400" />
                <span className="text-xs text-gray-400">Live count</span>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="mt-10 grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card className="border border-gray-100 shadow-sm">
          <CardHeader>
            <CardTitle className="text-base font-semibold text-gray-800">Quick Actions</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            {[
              { label: 'Manage Users', path: '/admin/users', color: 'bg-blue-600 hover:bg-blue-700' },
              { label: 'Manage Ads', path: '/admin/ads', color: 'bg-emerald-600 hover:bg-emerald-700' },
              { label: 'Manage Card Ads', path: '/admin/card-ads', color: 'bg-purple-600 hover:bg-purple-700' },
              { label: 'Manage Item Types', path: '/admin/item-types', color: 'bg-orange-600 hover:bg-orange-700' },
            ].map(({ label, path, color }) => (
              <a
                key={label}
                href={path}
                className={`flex items-center justify-between px-4 py-3 rounded-lg text-white text-sm font-medium transition-colors ${color}`}
              >
                {label}
                <span>→</span>
              </a>
            ))}
          </CardContent>
        </Card>

        <Card className="border border-gray-100 shadow-sm">
          <CardHeader>
            <CardTitle className="text-base font-semibold text-gray-800">System Info</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex items-center justify-between py-2 border-b border-gray-100">
              <span className="text-sm text-gray-500">API Endpoint</span>
              <span className="text-sm font-mono text-gray-800 truncate max-w-[180px]">lostify-ruddy.vercel.app</span>
            </div>
            <div className="flex items-center justify-between py-2 border-b border-gray-100">
              <span className="text-sm text-gray-500">Auth</span>
              <span className="text-sm text-gray-800">JWT Bearer</span>
            </div>
            <div className="flex items-center justify-between py-2 border-b border-gray-100">
              <span className="text-sm text-gray-500">Role</span>
              <span className="inline-flex items-center gap-1 text-xs font-medium px-2 py-1 rounded-full bg-blue-50 text-blue-700 border border-blue-200">
                Super Admin
              </span>
            </div>
            <div className="flex items-center justify-between py-2">
              <span className="text-sm text-gray-500">Status</span>
              <span className="inline-flex items-center gap-1.5 text-xs font-medium px-2 py-1 rounded-full bg-green-50 text-green-700 border border-green-200">
                <span className="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse" />
                Online
              </span>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default Dashboard;
