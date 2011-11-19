#!/bin/bash

# Set up options so that (e)jekyll does not publish future posts to the website.
jekyll_opts='--no-future'

# Check that certain binaries are available and in $PATH.

binaries_required=(gfind jekyll yuicompressor htmlcompressor rsync)

# Check that all the binaries we need are available and in $PATH. Use the `type` bash builtin rather than `which` for portability.
for binary in ${binaries_required[@]}; do
  type -P $binary > /dev/null || {
    echo "ERROR: The site deploy job cannot find the ${binary} executable. Please put it into \$PATH before calling this job."
    exit 1
  }
done

# Get to work.
echo 'Generating site.'
(type -P ejekyll > /dev/null && ejekyll $jekyll_opts || jekyll $jekyll_opts) || {
  echo 'ERROR: Could not find (e)jekyll in $PATH.'
  exit 1
}

echo 'Compressing HTML.'
gfind _site -type f -name *.html -exec htmlcompressor {} -o {} \;

echo 'Minifying CSS and JS.'
gfind _site -type f -name *.css -print0 | xargs -0 yuicompressor -o '.css$:.css'
gfind _site -type f -name *.js -print0 | xargs -0 yuicompressor -o '.js$:.js'

# Why not .woff? It's already compressed.
gzip_types="css js html xml eot ttf svg"

for file_extension in $gzip_types; do
  echo "Compressing all .${file_extension} files."
  gfind _site -type f -name *.$file_extension -exec bash -c "gzip -9 -c '{}' > '{}.gz'" \;
done

echo 'Deploying site.'
rsync -avq --delete-after _site/ workhorse:/var/www/vhosts/grenadesandwich.com || {
  echo 'ERROR: Could not deploy the site.'
  exit 1
}

echo 'Site deployed. Have a nice day.'

