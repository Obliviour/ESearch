function [] = plotImages(nameCell,imgUrlCell)
figure('units','normalized','outerposition',[0 0 1 1])
%imgUrlCell = imgUrlCell(1:15);
row = length(imgUrlCell)/5;

plotted = 1;
    for i = 1:length(imgUrlCell) %takes first 5 entries
        if ~isempty(imgUrlCell{i})
            if ischar(imgUrlCell{i})

            RGB = imread(imgUrlCell{i}); %imread works even if .jpg file isn't saved on your computer
            axis off
            subplot(row,5,plotted), subimage(RGB)
            axis off
            else
                plot(0,0)
            end
            if length(nameCell{i}) >=30 %cuts title off @ 30 characters
                title([num2str(i),': ',nameCell{i}(1:30)]);
            else
                title([num2str(i),': ',nameCell{i}])
            end
            plotted = plotted + 1;
        end
        if plotted == length(imgUrlCell) + 1
            break;
        end
    end
end