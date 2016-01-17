% DO NOT USE THIS CODE - PLEASE USE amazonItemSearcher

function [html,url,www,newInput] = amazonSearcher(input)

%the suburl is the base amazon search. We will append the user's search
%term onto this and plug this into the web browser to return the Amazon
%search page for all of the items
suburl = 'http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=';

%turns the input into a double and replaces the space with a '+' sign,
%which is howw amazon searches
input = double(input);
spaceMask = input == ' ';
input(spaceMask) = '+';
newInput = input
url = [suburl,input];

%opens up the url in the browser
%web(url,'-browser')

%html is the html code for the website, which this function returns
html = webread(url);

%www is an array of the beginning indices of all of the items in html that
%start with 'www' - this finds all websites for us
www = strfind(html,'www');

end