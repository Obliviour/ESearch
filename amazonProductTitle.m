function productTitle = amazonProductTitle(url)
%% making url readable
if ~strcmp(url(1:4),'http')
    url = ['http://' url];
end
search = webread(url);

%% finding the names of the product
nameLoc = strfind(search,'productTitle');

if ~isempty(nameLoc)
    nameLoc1 = search(nameLoc(1):end);
    if length(nameLoc)>300
        nameLoc1 = search(nameLoc(1):nameLoc(1)+300);
    end
    nameLoc = nameLoc1;
    [~,rest] = strtok(nameLoc,'>');
    rest = rest(2:end);
    [productTitle,~] = strtok(rest,'<');
else
    productTitle = '';  % if product is returns as empty that means that the url was read improperly due to amazon api issues
end
