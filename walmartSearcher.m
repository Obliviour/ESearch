%searches walmart and returns the url of the search and the html of the
%search page
function [url,html] = walmartSearcher(userInput)

subUrl = 'http://www.walmart.com/search/?query=';
spaceMask = userInput == ' ';
userInput(spaceMask) = '+';

url = [subUrl,userInput];

html = webread(url);
%web(url,'-browser');

end