#!/bin/sh
#/*****************************************************************************
#* TEST                                                                      *
#* Test that tesseract is working correctly by running OCR on a few things.  *
#* The final digit in the exit code counts the number of tests where the     *
#*tesseract output failed to match the expected output. If there are two     *
#* digits in the exit code, the first digit counts the number of tests where *
#* tesseract failed to run correctly or produce output.                      *
#*****************************************************************************/
EXIT_CODE=0

# JPEG test
echo "******************* JPEG TEST *******************"
wget http://upload.wikimedia.org/wikipedia/commons/5/5f/Dr._Jekyll_and_Mr._Hyde_Text.jpg -O /tmp/jekyll.jpg
tesseract /tmp/jekyll.jpg /tmp/jekyll
if [ $? -ne 0 ]; then
  let EXIT_CODE+=10
fi
diff /tmp/jekyll.txt /tmp/jekyll-correct.txt
if [ $? -ne 0 ]; then
  let EXIT_CODE+=1
fi
echo
echo

# TIFF test
echo "******************* TIFF TEST *******************"
wget https://sites.google.com/site/cff2doc/phototest.tif -O /tmp/lazydog.tiff
tesseract /tmp/lazydog.tiff /tmp/lazydog
if [ $? -ne 0 ]; then
  let EXIT_CODE+=10
fi
diff /tmp/lazydog.txt /tmp/lazydog-correct.txt
if [ $? -ne 0 ]; then
  let EXIT_CODE+=1
fi
echo
echo

## TODO: png files don't work -- something to look into perhaps
## PNG test
# echo "******************* PNG  TEST *******************"
# wget http://upload.wikimedia.org/wikipedia/commons/7/75/Dan%27l_Druce%2C_Blacksmith_-_Illustrated_London_News%2C_November_18%2C_1876_-_text.png -O /tmp/druce.png
# tesseract /tmp/druce.png /tmp/druce
# if [ $? -ne 0 ]; then
#   let EXIT_CODE+=10
# fi
# diff /tmp/druce.txt /tmp/druce-correct.txt
# if [ $? -ne 0 ]; then
#   let EXIT_CODE+=1
# fi
# echo
# echo

exit $EXIT_CODE
