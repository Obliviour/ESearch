function [nameCell,priceCell,linkUrlCell,imgUrlCell] = costco(userInput)

%returns the html to the searchURL
[~,html] = costcoSearcher(userInput);
                                                                           disp('1 Costco_html found');
%% FIDING THE LINKS TO EACH ITEM
linkLoc = strfind(html,'product-tile-image-container');
linkUrlCell = {};
for i = 1:length(linkLoc)
    link = html(linkLoc(i):linkLoc(i)+222);
    [link,rem] = strtok(link,'>');
    [misc,rem2] = strtok(rem,'"');
    rem2 = rem2(2:end);
    [rem2,~] = strtok(rem2,'"');
    linkUrlCell{end+1} = rem2;
end
                                                                            disp('2 Costco_links found');
%% FINDING THE URLS FOR THE IMAGES
imgLoc = strfind(html,'product-image');
imgUrlCell = {};
for i = 1:length(imgLoc)
    imgLink = html(imgLoc(i)+110:imgLoc(i)+200);
    [imgLink,rem] = strtok(imgLink,'"');
    imgUrlCell{end+1}= imgLink;
end
                                                                            disp('3 Costco_Urls found');
%% FINDING PRICES FOR THE ITEMS
priceLoc = strfind(html,'regionNav="DEF');
priceCell = {};
for i = 2:length(priceLoc)
    price = html(priceLoc(i)+20:priceLoc(i)+30);
    [price,rem] = strtok(price,'<');
    priceCell{end+1} = price;
end
                                                                            disp('4 Costco_Prices found');
%% FINDING THE NAMES OF EACH ITEM
nameLoc = strfind(html,'short-desc');
nameCell = {};
for i = 1:length(nameLoc)
    name = html(nameLoc(i):nameLoc(i)+100);
    [~,name] = strtok(name,'>');
    name = name(2:end);
    [name,~] = strtok(name,'<');
    nameCell{end+1} = name;
end
                                                                            disp('5 Costco_Names found');
%% ROTATING the cell arrays to be vertical
for i = 1: numel(priceCell)
  thingy= (priceCell{i});
  priceCell{i} = str2double(thingy(2:end));

end
% for i = 1: numel(priceCell)
% priceCell{i} = min(priceCell{i});
% priceCell{i} = double(priceCell{i});
% end

linkUrlCell = linkUrlCell';
imgUrlCell = imgUrlCell';
priceCell = priceCell';
nameCell = nameCell';
                                                                            disp('6 Costco_search done');
end