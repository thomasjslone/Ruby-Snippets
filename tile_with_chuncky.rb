require 'chunky_png'
def tile(image_path, size)
  # Load the image from the file
  image = ChunkyPNG::Image.from_file(image_path)
  # Create a new image with the tiled size
  tiled_image = ChunkyPNG::Image.new(size, size, ChunkyPNG::Color::TRANSPARENT)
  # Tile the original image across the new image
  size.times do |y|
    size.times do |x|
      original_x = x % image.width
      original_y = y % image.height
      tiled_image[x, y] = image[original_x, original_y]
    end
  end
  # Save the tiled image to a new file
  output_path = File.join(File.dirname(image_path), "tiled_#{size}.png")
  tiled_image.save(output_path)
end
