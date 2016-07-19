# encoding: utf-8

class MediaUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  #include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :file
  process :fix_exif_rotation

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
     "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [150,150]
  end

  version :medium do
    process resize_to_fill: [600,600]
  end

  version :large do
    process resize_to_fill: [1024,1024]
  end

  def fix_exif_rotation #this is my attempted solution
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

  def extension_white_list
    %w(jpg jpeg png)
  end



end
