#!/usr/bin/ruby
# Create display override file to at custom HiDPI modes for current Display
#

# Usage: Open Terminal and enter "ruby createOverride.rb"
# This should give you an override file for your display.

# Add the scale-resolutions to an existing override file
# or copy the folder to
# /System/Library/Displays/Contents/Resources/Overrides

# Then restart your system...

require 'base64'

data=`ioreg -l -w0 -d0 -r -c AppleDisplay`

vendorid=data.match(/DisplayVendorID.*?([0-9]+)/i)[1].to_i
productid=data.match(/DisplayProductID.*?([0-9]+)/i)[1].to_i

puts "found display: vendorid #{vendorid}, productid #{productid}"


Dir.mkdir("DisplayVendorID-%x" % vendorid) rescue nil
f = File.open("DisplayVendorID-%x/DisplayProductID-%x" % [vendorid, productid], 'w')
f.write '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">'
f.write "
<dict>
  <key>DisplayProductName</key>
  <string>Display with custom HiDPI modes</string>
  <key>DisplayVendorID</key>
  <integer>#{vendorid}</integer>
  <key>DisplayProductID</key>
  <integer>#{productid}</integer>
  <key>scale-resolutions</key>
  <array>
    <data>AAAPAAAACHAAAAAB</data> <!-- 3840x2160 to get 1920x1080 HiDPI -->
    <data>AAAMgAAABwgAAAAB</data> <!-- 3200x1800 to get 1600x900 HiDPI -->
    <data>AAALQAAABlQAAAAB</data> <!-- 2880x1620 to get 1440x810 HiDPI -->
  </array>
</dict>
</plist>"
f.close
