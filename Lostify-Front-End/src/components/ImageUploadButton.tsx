
import React, { useState } from 'react';
import { Button } from '@/components/ui/button';
import { Image, X } from 'lucide-react';

interface ImageUploadButtonProps {
  onImageSelected?: (file: File) => void;
}

const ImageUploadButton: React.FC<ImageUploadButtonProps> = ({ onImageSelected }) => {
  const [preview, setPreview] = useState<string | null>(null);
  const [isDragging, setIsDragging] = useState(false);

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    if (onImageSelected) {
      onImageSelected(file);
    }

    const reader = new FileReader();
    reader.onload = () => {
      setPreview(reader.result as string);
    };
    reader.readAsDataURL(file);
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setIsDragging(true);
  };

  const handleDragLeave = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setIsDragging(false);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setIsDragging(false);

    const file = e.dataTransfer.files?.[0];
    if (!file) return;

    if (onImageSelected) {
      onImageSelected(file);
    }

    const reader = new FileReader();
    reader.onload = () => {
      setPreview(reader.result as string);
    };
    reader.readAsDataURL(file);
  };

  const removeImage = () => {
    setPreview(null);
  };

  return (
    <div className="space-y-2">
      <label className="block text-sm font-medium text-gray-700">Item Photo</label>
      {!preview ? (
        <div
          className={`border-2 ${
            isDragging ? 'border-fienlost-400' : 'border-gray-300'
          } border-dashed rounded-lg p-6 transition-colors duration-200`}
          onDragOver={handleDragOver}
          onDragLeave={handleDragLeave}
          onDrop={handleDrop}
        >
          <div className="text-center">
            <Image className="mx-auto h-12 w-12 text-gray-400" />
            <div className="mt-2">
              <p className="text-sm text-gray-600">
                Drag and drop an image here, or click to select
              </p>
            </div>
            <input
              id="image-upload"
              name="image"
              type="file"
              accept="image/*"
              className="hidden"
              onChange={handleImageChange}
            />
            <Button
              type="button"
              variant="outline"
              className="mt-2"
              onClick={() => document.getElementById('image-upload')?.click()}
            >
              Upload Image
            </Button>
          </div>
        </div>
      ) : (
        <div className="relative rounded-lg overflow-hidden">
          <img src={preview} alt="Preview" className="w-full h-auto max-h-64 object-cover rounded-lg" />
          <Button
            type="button"
            size="icon"
            variant="destructive"
            className="absolute top-2 right-2 h-8 w-8 rounded-full"
            onClick={removeImage}
          >
            <X size={16} />
          </Button>
        </div>
      )}
    </div>
  );
};

export default ImageUploadButton;
