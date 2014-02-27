#!/bin/sh
#/****************************************************************************
# * TEST                                                                     *
# * Test that tesseract is working correctly by running OCR on a few things. *
# * The final digit in the exit code counts the number of tests where the    *
# * tesseract output failed to match the expected output. If there are two   *
# * digits in the exit code, the first digit counts the number of tests      *
# * where tesseract failed to run correctly or produce output.               *
# ****************************************************************************/
EXIT_CODE=0
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo
echo

# JPEG test
echo "************************ JPEG TEST ************************"
tesseract $DIR/files/Dr._Jekyll_and_Mr._Hyde_Text.jpg /tmp/jekyll
if [ $? -ne 0 ]; then
  let EXIT_CODE+=10
fi
diff /tmp/jekyll.txt /tmp/jekyll-correct.txt
if [ $? -ne 0 ]; then
  let EXIT_CODE+=1
else
  echo "PASS"
fi
echo
echo

# TIFF test
echo "************************ TIFF TEST ************************"
tesseract $DIR/files/lazydog.tiff /tmp/lazydog
if [ $? -ne 0 ]; then
  let EXIT_CODE+=10
fi
diff /tmp/lazydog.txt /tmp/lazydog-correct.txt
if [ $? -ne 0 ]; then
  let EXIT_CODE+=1
else
  echo "PASS"
fi
echo
echo

## TODO: png files don't work -- something to look into perhaps
## PNG test
# echo "************************ PNG  TEST ************************"
# tesseract $DIR/files/Dan'l_Druce,_Blacksmith_-_Illustrated_London_News,_November_18,_1876_-_text.png /tmp/druce
# if [ $? -ne 0 ]; then
#   let EXIT_CODE+=10
# fi
# diff /tmp/druce.txt /tmp/druce-correct.txt
# if [ $? -ne 0 ]; then
#   let EXIT_CODE+=1
#else
#  echo "PASS"
# fi
# echo
# echo

exit $EXIT_CODE
