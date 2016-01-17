function productTitle = walmartProductTitle(url)
if ~strcmp(url(1:4),'http')
    url = ['http://' url];
end

nameLoc = [];
while isempty(nameLoc)
search = webread(url);

nameLoc = strfind(search,'product-heading');
end

nameLoc = nameLoc(2);
nameLoc = search(nameLoc(1):nameLoc(1)+200);
nameLoc = nameLoc(21:end);
[~,rest] = strtok(nameLoc);
rest = rest(9:end);
[productTitle,~] = strtok(rest,'<');
end