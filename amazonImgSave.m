function [imgUrl] = amazonImgSave(url,productTitle) %IMPORTANT: NOW ONLY RETURNS URL OF IMAGE, DOES -NOT- SAVE IMAGE ONTO COMPUTER
%% searches locations of 'img alt'
if ~strcmp(url(1:4),'http')
    url = ['http://' url];
end
% search = webread(url);
imgLoc = [];
while isempty(imgLoc)
    search = webread(url);
    imgLoc = strfind(search,'img alt');%searches all locations of 'img alt'
end
%% takes that location array and sorts them into imgUrls
realImgStr = [];
for i = 1:length(imgLoc)
    imgLocTemp = search(imgLoc(i):imgLoc(i)+300);
    realImgLoc = strfind(imgLocTemp,productTitle); %does not account for if the next chars are not a url
    
    if realImgLoc~=-1 %quit when it finds correct location
        temp = search((imgLoc(i) + 7 + realImgLoc):(imgLoc(i) + 7 + realImgLoc + 300));
        [~,temp] = strtok(temp,productTitle);
        if strfind(temp,' src="http')==1
            realImgStr = temp;
            break;
        end
    end
end


[~,rest] = strtok(realImgStr,'src="');
rest = rest(6:end);
[imgUrl,~] = strtok(rest,'"');

%imgFile = websave([productTitle '.jpg'],imgUrl);
end