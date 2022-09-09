class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file
  process resize_to_fit: [800, 800]

  version :thumb do
    process :resize_to_fit => [100, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
