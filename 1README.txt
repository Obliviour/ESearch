This was a project created by Victor Barr, Justin Cheung, and Vikram Varadarajan in Fall 2015 CS 1371 of Georgia Institute of Technology. 

Overview: 

'eSearch'
better searching tomorrow, today.
-----
a program that searches multiple popular online outlets for the lowest prices
Wal-Mart
Amazon
Costco
-----
returns names, prices, images of the top 5 most popular results from each site
and a subplot of images for each searched item
-----

-End Overview-


Instructions:

1. This program comes with a GUI based searcher. Open the file gui.m and run it in matlab.
2. Based on the search locations that you checkoff, you can search different websites for different items.


GUIDE TO OTHER FILES IN FOLDER:

each website has .m files formatted similarally.

for example for the website amazon:

amazon.m - main file that compiles other amazon files together. This is the MAIN file that looks at the search engine of the amazon, takes producturls, finds prices, finds names of products, returns item jpeg urls. 

amazonImgSave.m - this file is from a older version of this program BUT it will save a image of the product based on the PRODUCTURL page.

amazonSearcher.m - this file uses amazon's website searcher and returns the URL of the search results (the one will all the products listed)  NOTE: specifically for amazon, amazonItemSearcher.m is used instead due to misc. bugs. 

amazonProductTitle.m - this file returns product titles based on inputted searchurl


NOTES AND ISSUES:

1. amazon has repeated flaws due to their website not always allowing the html to be read. Please note that due to this, the amazon search is VERY SLOW and does take a lot of time to finish 
2. IF the search you input is unable to find anything on the different websites, either 1. matlab will produce an error OR 2. the search returns will not return anything to that specific store.




