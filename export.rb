require 'json'
require 'date'
require 'fileutils'
require 'optparse'

options = {}
opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-s", "--source FILE", "Source entries file") do |source_file|
    options[:source_file] = source_file
  end

  opts.on("-o", "--output DIR", "Output directory") do |output_dir|
    options[:output_dir] = output_dir
  end
end

opt_parser.parse!

if options[:source_file].nil? || options[:output_dir].nil?
  puts opt_parser
  exit
end

source_data = File.read(options[:source_file])
json_data = JSON.parse(source_data)
entries = json_data['entries'] || []

def embed_photo(photo_identifier, photos)
  photo = photos.find { |p| p['identifier'] == photo_identifier }
  if photo.nil?
    return "NO PHOTO FOUND"
  end

  photo_path = "#{photo['md5']}.#{photo['type']}"
  "![](#{photo_path})"
end


entries.each do |entry|
  date = DateTime.parse(entry['creationDate']).strftime('%Y-%m-%d')
  content = entry['text'] || 'NO CONTENT'
  photos = entry['photos'] || []

  filename = "#{date}.md"
  filepath = File.join(options[:output_dir], filename)
  File.open(filepath, 'w') do |file|
    lines = content.split("\n")
    lines.each do |line|
      if line =~ /!\[\]\(dayone-moment:\/\/(.+)\)/
        photo_identifier = $1
        file.puts embed_photo(photo_identifier, photos)
      else
        file.puts line
      end
    end
  end
end
