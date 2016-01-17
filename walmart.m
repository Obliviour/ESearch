%returns the names, prices, links, and image links for every product on the
%first page of a walmart search
function [nameCell,priceCell,linkUrlCell,imgUrlCell] = walmart(userInput)

[~,html] = walmartSearcher(userInput);
                                                                            disp('1 Walmart_html found');
%% FINDS THE NAMES OF THE PRODUCTS
%finds all of the names - they are in a certain position in the html and
%the code finds them. It stroks away the other bits of the name that are
%not relevant
nameLoc = strfind(html,'js-product-title');

nameCell = {};
for i = 1:length(nameLoc)
    currentName = html(nameLoc(i)+27:nameLoc(i) + 150);
    
    thing = html(nameLoc(i)+100:nameLoc(i) + 300);
    strfind(thing,'In stores only');
    
    if isempty(strfind(thing,'In stores only'))
        [currentName,~] = strtok(currentName,'/');
        currentName(currentName == '-') = ' ';
        nameCell{end+1} = currentName;
    end
end

initPriceLoc = strfind(html,'currency-delimiter');

%sometimes, there are 2 prices for an item, low and high prices, so we
%remove those by making sure the difference between their locations in the
%html is more than 200

priceDiff = [201,diff(initPriceLoc)];
priceLoc = initPriceLoc(priceDiff > 200);
priceCell = {};

%problem, only grabs the dollar amount, not cents. So an item that is 8.99
%is 8 dollars
for i = 1:length(priceLoc)
    currentPrice = double(html(priceLoc(i)-16:priceLoc(i)-11));    
    mask = currentPrice >=48 & currentPrice <=57;
    currentPrice = str2num(char(currentPrice(mask)));    
    priceCell{end+1} = currentPrice;
end
                                                                            disp('2 Walmart_prices found');

                                                                            disp('3 Walmart_names found');
%% FINDING THE URLS FOR THE PRODUCT LINKS
linkLoc = strfind(html,'product-image');
linkUrlCell = {};
for i = 1:length(linkLoc)
    
    tempLinkUrl = html(linkLoc(i) + 14:linkLoc(i) + 200);
    if strcmp(tempLinkUrl(1:4),'href')
        [beg,~] = strtok(tempLinkUrl,'>');
        linkUrl = ['http://walmart.com',beg(7:end)];
        linkUrlCell{end+1} = linkUrl;
    end
    
end
                                                                            disp('4 Walmart_links to product page urls found');
%% FINDING THE URLS FOR THE IMAGES
%imgLoc is an array of almost the locations of the urls
imgLoc = strfind(html,'data-default-image');

imgUrlCell = {};
for i = 1:length(imgLoc)
    tempImgUrl = html(imgLoc(i)+20:imgLoc(i) + 200);
    [tempImgUrl,~] = strtok(tempImgUrl,'"');
    imgUrlCell{end+1} = tempImgUrl;
end
                                                                            disp('5 Walmart_link to images found');
%% ROTATING the cell arrays to be vertical
for i = 1: numel(priceCell)
priceCell{i} = min(priceCell{i});
priceCell{i} = double(priceCell{i});
end

nameCell = nameCell';       %cell array of the names of the products
priceCell = priceCell';     %cell array of the prices of the products
linkUrlCell = linkUrlCell'; %cell array of the links of the products
imgUrlCell = imgUrlCell';   %cell array of the links to the images
end