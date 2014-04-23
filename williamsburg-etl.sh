#!/bin/bash

#####
# 
# Steps Taken By This Script
#
# 1. Grab the web page that lists (links to) the resourses - requires curl
# 2. Download the resources (one at a time) - requires curl
# 3. Unpack the resource (ZIPs of shapefiles) - requires unzip
# 4. Convert and re-project the shapefiles into GeoJSON and EPSG:4326 (WGS 84) - requires ogr2ogr (GDAL)
# 5. Clean up
# 
#####

# Base URL
baseurl=https://www.williamsburgva.gov/

# Direct URL for the list of layers available
gisurl=https://www.williamsburgva.gov/Index.aspx?page=793

curl $gisurl 2>&1 | grep -o -E 'href="([^"#]+)"' | cut -d'"' -f2 | grep documentid | while read line
do
  zipurl=$baseurl$line

  curl $zipurl > download.zip

  unzip download.zip

  echo ls *.shp

# ogr2ogr -t_srs EPSG:4326 -f "GeoJSON" corporate-boundary.json CorpBndry.shp

done
