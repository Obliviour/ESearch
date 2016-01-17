function [out1,productsUrl,priceUrl,itemPriceCell,itemNameCell,imagesUrl] = amazon(userInput)
out1 = [];
while isempty(out1)
    userInput = [userInput ' '];
%% runs the main searcher for amazon

%accesses the amazonSearcher function for the website's html, the new url,
%the urls within the html, and the html from the search page from the
%uuser's input
[search,~,www,input] = amazonItemSearcher(userInput);
                                                                            disp('1 Amazon_Finished amazonItemSearcher');
%% making the keyword contain %2Ba
loc=strfind(input,'+');
for i = 1: length(loc)
    firsthalf = input(1:loc(i)-1);
    secondhalf = input(loc(i)+1 : end);
    input = [firsthalf '%2B' secondhalf];
    loc = loc + 2;
end
endterm = sprintf('keywords=%s',input);
%% for loop for finding the correct www
urlcellarrays = {};
for i = 1 : length(www)-1
    possible = search(www(i):www(i)+500);
    isright = strfind(possible,endterm);
    if ~isempty(isright)
        urlcellarrays{end+1} = possible(1:isright+length(endterm)-1);        
    end
end
out1 = urlcellarrays';

%% FINDING PRICES Below

%initializes two empty arrays. itemPageUrls is going to store the URLS of
%th
priceOffers = {};
itemPageUrls = {};
%% organizing urls to TWO important categories : 1. prices 2. names
for j = 2:length(out1)
    currentUrl = out1{j};
    prevUrl = out1{j-1};
    isOffer = strfind(currentUrl,'gp/offer-listing/');
    isBefore = strfind(prevUrl,'gp/offer-listing/');
    if ~isempty(isOffer) && isempty(isBefore)
        priceOffers{end+1} = currentUrl;
        itemPageUrls{end+1} = prevUrl;
    end
end
productsUrl = itemPageUrls';                                                 disp('2 Amazon_Finished organizing urls into priceOffers and itemPageUrls');
%% initilizing and reorganizing information

priceOffers = priceOffers';
itemPageUrls =  itemPageUrls';
%grabs all the urls of th gp offers page that are unique, and maintains the
%order from the original data I think
%out2 = unique(priceOffers','stable');
priceUrl = priceOffers;
%creates cell array in which we will store the items prices and another for
%the items' names
itemPriceCell = {};
itemNameCell  = {};
                                                                            disp('3 Amazon_Finished reorganizating information');
%% Finds the array of prices per each item url in the priceOffers

for i = 1:length(priceUrl)
    %need to add the http in order to read the website for some reason
    in = ['https://',priceUrl{i}];
    %grabs the html for the current gp/offer-listing page
    priceLoc = [];
    while isempty(priceLoc)
        pricePageHtml = webread(in);   
        %so, there are apparently 16 spaces before all of the prices on this
        %webpage, so this searches for sixteen spaces and a dollar sign
        priceLoc = strfind(pricePageHtml,'                $');
    end
    priceCell = {};    
    %grabs just the numbers for the price. Unfortunately, other garbage
    %info is included, which we will filter out in the next step
    for k = 1:length(priceLoc)-1
        priceCell{end+1} = {pricePageHtml(priceLoc(k)+17:priceLoc(k) + 22)};  
    end  
    %this is an array of the prices of the item in question
    priceArr = [];
    for m = 1:length(priceCell)   
        string = priceCell{m};
        string = string{1};
        string = double(string);
        if string(2) >= 48 && string(2) <= 57
            num = priceCell{m};
            num = num{1};
            num = str2num(num);
            priceArr = [priceArr, num];
        end
    end   
    itemPriceCell{end+1} = priceArr;    
end
                                                                            disp('4 Amazon_Finished Sorting prices into priceArr');
%% Sorts through itemPageurls to find the names of each item

  for i = 1:size(itemPageUrls)
      title = [];
      while isempty(title) %brute forcing to find titles
        title = amazonProductTitle(itemPageUrls{i});
      end
      itemNameCell{end+1} = title;
  end
  
  
  %% finding image urls
itemImgUrls = {};
for i = 1:length(itemPageUrls)
    itemImgUrls{end+1} = amazonImgSave(productsUrl{i},itemNameCell{i});
end
 imagesUrl =  itemImgUrls;                                                      disp('5 Amazon_Finished finding image urls');
                                                                            
%% rotate outputs

for i = 1: numel(itemPriceCell)
itemPriceCell{i} = min(itemPriceCell{i});
end



                                                                            disp('6 Amazon_Finish Code');



%% omitting empty cells
if ~isempty(itemPriceCell)
    mask = ~strcmp(imagesUrl,''); %mask of non-empty cells
    productsUrl = productsUrl(mask);
    priceUrl = priceUrl(mask);
    itemPriceCell = itemPriceCell(mask);
    itemNameCell = itemNameCell(mask);
    imagesUrl = imagesUrl(mask);
    
    
    mask = ~isempty(itemPriceCell{1});
    
    for i = 2 : length(itemPriceCell)
        mask = [mask ~isempty(itemPriceCell{i})];
    end
    productsUrl = productsUrl(mask);
    priceUrl = priceUrl(mask);
    itemNameCell = itemNameCell(mask);
    imagesUrl = imagesUrl(mask);
    itemPriceCell = itemPriceCell(mask);

    
     mask = ~isempty(itemPriceCell{1});
    
    for i = 2 : length(itemPriceCell)
        mask = [mask ~isempty(itemPriceCell{i})];
     end
    
    itemPriceCell = itemPriceCell(mask);
    
    
    if length(imagesUrl) < 5
        for i = 1:5-length(imagesUrl)
            productsUrl{end+1} = 'null';
            priceUrl{end+1} = 'null';
            itemPriceCell{end+1} = 0.00;
            itemNameCell{end+1} = 'null';
            imagesUrl{end+1} = 0;
        end
    end

end


imagesUrl = imagesUrl';
itemPriceCell = itemPriceCell';
itemNameCell = itemNameCell';
end
end

