import React, { useEffect, useState } from 'react';
import { adminGet, adminDelete } from '@/lib/adminApi';
import { mediaUrl } from '@/lib/api';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
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
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { toast } from 'react-toastify';
import { Search, Trash2, Eye, FileText, ImageOff } from 'lucide-react';

interface Ad {
  id: number;
  title: string;
  item_type?: { id: number; name: string } | null;
  status: string;
  user: { id: number; username: string };
  date_time: string;
  image?: string | null;
  location_description: string;
  is_resolved: boolean;
  reward?: number | null;
}

const statusColor: Record<string, string> = {
  lost: 'bg-red-100 text-red-700 border-red-200',
  found: 'bg-green-100 text-green-700 border-green-200',
};

const Ads = () => {
  const [ads, setAds] = useState<Ad[]>([]);
  const [filtered, setFiltered] = useState<Ad[]>([]);
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(true);
  const [deleteId, setDeleteId] = useState<number | null>(null);
  const [deleting, setDeleting] = useState(false);
  const [viewAd, setViewAd] = useState<Ad | null>(null);

  const load = async () => {
    setLoading(true);
    try {
      const data = await adminGet<Ad[]>('ads/');
      setAds(data);
      setFiltered(data);
    } catch {
      toast.error('Failed to load ads');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); }, []);

  useEffect(() => {
    const q = search.toLowerCase();
    setFiltered(ads.filter(a => a.title.toLowerCase().includes(q)));
  }, [search, ads]);

  const handleDelete = async () => {
    if (deleteId === null) return;
    setDeleting(true);
    try {
      await adminDelete(`ads/${deleteId}/`);
      toast.success('Ad deleted successfully');
      setDeleteId(null);
      load();
    } catch {
      toast.error('Failed to delete ad');
    } finally {
      setDeleting(false);
    }
  };

  return (
    <div>
      <div className="flex items-center gap-3 mb-6">
        <div className="p-2 rounded-lg bg-emerald-50">
          <FileText size={20} className="text-emerald-600" />
        </div>
        <div>
          <h2 className="text-2xl font-bold text-gray-900">Ads</h2>
          <p className="text-gray-500 text-sm">{ads.length} total ads</p>
        </div>
      </div>

      <Card className="border border-gray-100 shadow-sm">
        <CardHeader className="pb-4">
          <div className="flex items-center gap-3">
            <div className="relative flex-1 max-w-sm">
              <Search size={15} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
              <Input
                placeholder="Search by title..."
                value={search}
                onChange={e => setSearch(e.target.value)}
                className="pl-9"
              />
            </div>
            <CardTitle className="text-sm text-gray-500 ml-auto">{filtered.length} results</CardTitle>
          </div>
        </CardHeader>
        <CardContent className="p-0">
          {loading ? (
            <div className="flex items-center justify-center py-16">
              <div className="w-8 h-8 border-4 border-emerald-600 border-t-transparent rounded-full animate-spin" />
            </div>
          ) : (
            <div className="overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow className="bg-gray-50/80">
                    <TableHead className="font-semibold text-gray-700">ID</TableHead>
                    <TableHead className="font-semibold text-gray-700">Image</TableHead>
                    <TableHead className="font-semibold text-gray-700">Title</TableHead>
                    <TableHead className="font-semibold text-gray-700">Item Type</TableHead>
                    <TableHead className="font-semibold text-gray-700">Status</TableHead>
                    <TableHead className="font-semibold text-gray-700">User</TableHead>
                    <TableHead className="font-semibold text-gray-700">Created</TableHead>
                    <TableHead className="font-semibold text-gray-700 text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filtered.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={8} className="text-center py-12 text-gray-400">
                        No ads found
                      </TableCell>
                    </TableRow>
                  ) : (
                    filtered.map(ad => (
                      <TableRow key={ad.id} className="hover:bg-emerald-50/40 transition-colors">
                        <TableCell className="font-mono text-gray-500 text-sm">#{ad.id}</TableCell>
                        <TableCell>
                          {ad.image ? (
                            <img
                              src={mediaUrl(ad.image)}
                              alt={ad.title}
                              className="w-10 h-10 object-cover rounded-lg border border-gray-200"
                            />
                          ) : (
                            <div className="w-10 h-10 rounded-lg bg-gray-100 flex items-center justify-center">
                              <ImageOff size={14} className="text-gray-400" />
                            </div>
                          )}
                        </TableCell>
                        <TableCell>
                          <p className="font-medium text-gray-900 line-clamp-1 max-w-[180px]">{ad.title}</p>
                          {ad.is_resolved && (
                            <span className="text-xs text-green-600">✓ Resolved</span>
                          )}
                        </TableCell>
                        <TableCell className="text-gray-500 text-sm">{ad.item_type?.name ?? '—'}</TableCell>
                        <TableCell>
                          <Badge className={`capitalize text-xs ${statusColor[ad.status] ?? 'bg-gray-100 text-gray-600 border-gray-200'}`}>
                            {ad.status}
                          </Badge>
                        </TableCell>
                        <TableCell className="text-gray-600 text-sm">{ad.user.username}</TableCell>
                        <TableCell className="text-gray-500 text-sm">
                          {new Date(ad.date_time).toLocaleDateString()}
                        </TableCell>
                        <TableCell className="text-right">
                          <div className="flex items-center justify-end gap-2">
                            <Button
                              size="sm"
                              variant="ghost"
                              onClick={() => setViewAd(ad)}
                              className="h-8 w-8 p-0 text-gray-500 hover:text-emerald-600 hover:bg-emerald-50"
                            >
                              <Eye size={15} />
                            </Button>
                            <Button
                              size="sm"
                              variant="ghost"
                              onClick={() => setDeleteId(ad.id)}
                              className="h-8 w-8 p-0 text-gray-500 hover:text-red-600 hover:bg-red-50"
                            >
                              <Trash2 size={15} />
                            </Button>
                          </div>
                        </TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </div>
          )}
        </CardContent>
      </Card>

      {/* View Ad Dialog */}
      <Dialog open={!!viewAd} onOpenChange={() => setViewAd(null)}>
        <DialogContent className="max-w-lg">
          <DialogHeader>
            <DialogTitle>Ad Details</DialogTitle>
          </DialogHeader>
          {viewAd && (
            <div className="space-y-4">
              {viewAd.image ? (
                <img
                  src={mediaUrl(viewAd.image)}
                  alt={viewAd.title}
                  className="w-full h-48 object-cover rounded-lg border border-gray-200"
                />
              ) : (
                <div className="w-full h-32 rounded-lg bg-gray-100 flex items-center justify-center">
                  <ImageOff size={32} className="text-gray-300" />
                </div>
              )}
              <div className="space-y-2 text-sm">
                {[
                  ['ID', `#${viewAd.id}`],
                  ['Title', viewAd.title],
                  ['Status', viewAd.status],
                  ['Item Type', viewAd.item_type?.name ?? '—'],
                  ['User', viewAd.user.username],
                  ['Date', new Date(viewAd.date_time).toLocaleString()],
                  ['Location', viewAd.location_description],
                  ['Resolved', viewAd.is_resolved ? 'Yes' : 'No'],
                  ['Reward', viewAd.reward ? `${viewAd.reward} EGP` : '—'],
                ].map(([label, value]) => (
                  <div key={label} className="flex justify-between py-2 border-b border-gray-100">
                    <span className="text-gray-500 shrink-0">{label}</span>
                    <span className="font-medium text-gray-800 text-right ml-4">{value}</span>
                  </div>
                ))}
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* Delete Confirmation */}
      <AlertDialog open={deleteId !== null} onOpenChange={() => setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Delete Ad</AlertDialogTitle>
            <AlertDialogDescription>
              Are you sure you want to delete this ad? This action cannot be undone.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction
              onClick={handleDelete}
              disabled={deleting}
              className="bg-red-600 hover:bg-red-700 text-white"
            >
              {deleting ? 'Deleting...' : 'Delete'}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
};

export default Ads;
