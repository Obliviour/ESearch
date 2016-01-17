function imgFile = costcoImgSave(url)
if ~strcmp(url(1:4),'http')
    url = ['http://' url];
end
imgLoc = [];
while isempty(imgLoc)
    search = webread(url);
    imgLoc = strfind(search,'img itemprop');%searches all locations of 'img itemprop'
end

realImgStr = search(imgLoc:imgLoc + 300);
[~,rest] = strtok(realImgStr,'src="');
rest = rest(18:end);
[imgUrl,~] = strtok(rest,'"');

productTitle = costcoProductTitle(url);

imgFile = websave([productTitle,'.jpg'],imgUrl);
end