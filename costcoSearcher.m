%searches costco and returns the url of the search and the html of the
%search page
function [url,html] = costcoSearcher(userInput)

subUrl = 'http://www.costco.com/CatalogSearch?storeId=10301&catalogId=10701&langId=-1&refine=&keyword=';
spaceMask = userInput == ' ';
userInput(spaceMask) = '+';

url = [subUrl,userInput];

html = webread(url);
%web(url,'-browser');

end