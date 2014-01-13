/*****************************************************************************
* TEST                                                                      *
* Test that tesseract is working correctly by running OCR on a few things.  *
*****************************************************************************/
# JPEG test
wget http://upload.wikimedia.org/wikipedia/commons/5/5f/Dr._Jekyll_and_Mr._Hyde_Text.jpg -O /tmp/jekyll.jpg
tesseract /tmp/jekyll.jpg /tmp/jekyll
diff /tmp/jekyll.txt /tmp/jekyll-correct.txt
# TODO: analyze $? here???

# TIFF test
wget https://sites.google.com/site/cff2doc/phototest.tif -O /tmp/lazydog.tiff
tesseract /tmp/lazydog.tiff /tmp/lazydog
diff /tmp/lazydog.txt /tmp/lazydog-correct.txt
# TODO: analyze $? here???

## TODO: png files don't work -- something to look into perhaps
## PNG test
# wget http://upload.wikimedia.org/wikipedia/commons/7/75/Dan%27l_Druce%2C_Blacksmith_-_Illustrated_London_News%2C_November_18%2C_1876_-_text.png -O /tmp/druce.png
# tesseract /tmp/druce.png /tmp/druce
# diff /tmp/druce.txt /tmp/druce-correct.txt
## TODO: analyze $? here???
