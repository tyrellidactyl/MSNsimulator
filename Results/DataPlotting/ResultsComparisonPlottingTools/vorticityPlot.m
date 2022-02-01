vorData = dataVor(:,:,end);
vorData(1,:,:) = [init(1),init(2),1]; 
vorData(end,:,:) = [init(1),init(2),1]; 



vM = max(max(vorData(:))); % Maximum wind speed
vM2 = max(setdiff(vorData(:),vM));     
[row1,col1] = find(vorData==vM);
[row2,col2] = find(vorData==vM2);

for i=1:(finalPoint)
    vorData(i,:,:) = vorData(i,:,:) - [init(1),init(2),0];
end

maxData = [vorData(row1,:);vorData(row2,:)];


f5 = figure
set(f5,'Position',[73 1359 906 667]);
clf;
x = vorData(:,1);
y = vorData(:,2);
sz = vorData(:,3);

scatter(x,y,sz,'LineWidth',2)
hold on
mx = maxData(:,1);
my = maxData(:,2);
msz = maxData(:,3);

scatter(mx,my,msz,'filled')

line(mx,my,'Color','blue','LineWidth',1.5)

grid on
title('Vorticity Data Measurements')
ylabel('Y')
xlabel('X')