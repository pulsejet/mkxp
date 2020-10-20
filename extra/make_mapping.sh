#!/bin/bash

echo "var mapping = {" > mapping.js
echo "var bitmapSizeMapping = {" > bitmap-map.js

for file in {*,*/*,*/**/*}
do

filename="${file%.*}"
fl="$(echo "$filename" | tr '[:upper:]' '[:lower:]')"

if [ -f $file ]
then
    md5=`md5sum "${file}" | awk '{ print $1 }'`
else
    md5=''
fi

echo "\"$fl\": \"${file}?h=${md5}\"," >> mapping.js

if [ -f $file ]
then
    sz=`identify -format "%w,%h" "${file}" 2>/dev/null`
    if [ $? -eq 0 ]; then
        convert "$file" -resize 64x64\> "conv.png"
        mimetype=$(file -bN --mime-type "conv.png")
        content=$(base64 -w0 < "conv.png")
        duri="data:$mimetype;base64,$content"
        rm "conv.png"

        echo "\"$fl\": [${sz},\"${duri}\"]," >> bitmap-map.js
    fi
fi

done

echo "};" >> mapping.js
echo "};" >> bitmap-map.js

