#!/bin/bash

echo 'Generating site.'
(type -P ejekyll > /dev/null && ejekyll || jekyll) || {
  echo 'ERROR: Could not find (e)jekyll in $PATH.'
  exit 1
}

echo 'Minifying CSS and JS.'
gfind _site -type f -name *.css -print0 | xargs -0 yuicompressor -o '.css$:.css'
gfind _site -type f -name *.js -print0 | xargs -0 yuicompressor -o '.js$:.js'

gzip_types="css js html xml eot ttf"

for file_extension in $gzip_types; do
  echo "Compressing all .${file_extension} files."
  gfind _site -type f -name *.$file_extension -exec bash -c "gzip -9 -c '{}' > '{}.gz'" \;
done

echo 'Deploying site.'
rsync -avq _site/ workhorse:/var/www/vhosts/grenadesandwich.com || {
  echo 'ERROR: Could not deploy the site.'
  exit
}

echo 'Site deployed. Have a nice day.'

