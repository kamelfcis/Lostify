import React, { useEffect, useState } from 'react';
import { adminGet, adminDelete, adminPost } from '@/lib/adminApi';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
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
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from '@/components/ui/dialog';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { toast } from 'react-toastify';
import { Tag, Trash2, Plus } from 'lucide-react';

interface ItemType {
  id: number;
  name: string;
}

const ItemTypes = () => {
  const [itemTypes, setItemTypes] = useState<ItemType[]>([]);
  const [loading, setLoading] = useState(true);
  const [deleteId, setDeleteId] = useState<number | null>(null);
  const [deleting, setDeleting] = useState(false);
  const [addOpen, setAddOpen] = useState(false);
  const [newName, setNewName] = useState('');
  const [adding, setAdding] = useState(false);

  const load = async () => {
    setLoading(true);
    try {
      const data = await adminGet<ItemType[]>('item-types/');
      setItemTypes(data);
    } catch {
      toast.error('Failed to load item types');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); }, []);

  const handleDelete = async () => {
    if (deleteId === null) return;
    setDeleting(true);
    try {
      await adminDelete(`item-types/${deleteId}/`);
      toast.success('Item type deleted');
      setDeleteId(null);
      load();
    } catch {
      toast.error('Failed to delete item type');
    } finally {
      setDeleting(false);
    }
  };

  const handleAdd = async () => {
    if (!newName.trim()) return;
    setAdding(true);
    try {
      await adminPost('item-types/', { name: newName.trim() });
      toast.success('Item type added');
      setNewName('');
      setAddOpen(false);
      load();
    } catch {
      toast.error('Failed to add item type');
    } finally {
      setAdding(false);
    }
  };

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3">
          <div className="p-2 rounded-lg bg-orange-50">
            <Tag size={20} className="text-orange-600" />
          </div>
          <div>
            <h2 className="text-2xl font-bold text-gray-900">Item Types</h2>
            <p className="text-gray-500 text-sm">{itemTypes.length} types configured</p>
          </div>
        </div>
        <Button
          onClick={() => setAddOpen(true)}
          className="gap-2 bg-orange-600 hover:bg-orange-700 text-white"
        >
          <Plus size={15} />
          Add Item Type
        </Button>
      </div>

      <Card className="border border-gray-100 shadow-sm max-w-2xl">
        <CardHeader className="pb-2">
          <CardTitle className="text-sm text-gray-500">{itemTypes.length} item types</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {loading ? (
            <div className="flex items-center justify-center py-16">
              <div className="w-8 h-8 border-4 border-orange-600 border-t-transparent rounded-full animate-spin" />
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow className="bg-gray-50/80">
                  <TableHead className="font-semibold text-gray-700">ID</TableHead>
                  <TableHead className="font-semibold text-gray-700">Name</TableHead>
                  <TableHead className="font-semibold text-gray-700 text-right">Actions</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {itemTypes.length === 0 ? (
                  <TableRow>
                    <TableCell colSpan={3} className="text-center py-12 text-gray-400">
                      No item types found
                    </TableCell>
                  </TableRow>
                ) : (
                  itemTypes.map(type => (
                    <TableRow key={type.id} className="hover:bg-orange-50/40 transition-colors">
                      <TableCell className="font-mono text-gray-500 text-sm">#{type.id}</TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <div className="w-2 h-2 rounded-full bg-orange-400" />
                          <span className="font-medium text-gray-900">{type.name}</span>
                        </div>
                      </TableCell>
                      <TableCell className="text-right">
                        <Button
                          size="sm"
                          variant="ghost"
                          onClick={() => setDeleteId(type.id)}
                          className="h-8 w-8 p-0 text-gray-500 hover:text-red-600 hover:bg-red-50"
                        >
                          <Trash2 size={15} />
                        </Button>
                      </TableCell>
                    </TableRow>
                  ))
                )}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* Add Dialog */}
      <Dialog open={addOpen} onOpenChange={setAddOpen}>
        <DialogContent className="max-w-sm">
          <DialogHeader>
            <DialogTitle>Add Item Type</DialogTitle>
          </DialogHeader>
          <div className="space-y-3 py-2">
            <Label htmlFor="item-type-name">Name</Label>
            <Input
              id="item-type-name"
              placeholder="e.g. Wallet, Phone, Keys..."
              value={newName}
              onChange={e => setNewName(e.target.value)}
              onKeyDown={e => e.key === 'Enter' && handleAdd()}
            />
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setAddOpen(false)}>Cancel</Button>
            <Button
              onClick={handleAdd}
              disabled={adding || !newName.trim()}
              className="bg-orange-600 hover:bg-orange-700 text-white"
            >
              {adding ? 'Adding...' : 'Add'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Delete Confirmation */}
      <AlertDialog open={deleteId !== null} onOpenChange={() => setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Delete Item Type</AlertDialogTitle>
            <AlertDialogDescription>
              Are you sure you want to delete this item type? This may affect existing ads.
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

export default ItemTypes;
