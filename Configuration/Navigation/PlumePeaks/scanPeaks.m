% obtain robot pose data where peak concentrations were collected
function [Peaks] = scanPeaks(PeakPose,RunningPose)

total = size(PeakPose,2);

PeakC = [PeakPose(4,:)];

Peaks = [];

n = 1;

for i=1:total
    
    if PeakC(i) > 0
        
        Peak = PeakPose(:,i);
        
        for m = 1:4
            
            Peaks{m,n} = Peak(m,:);
            
        end
        
        n = n + 1;
        
    end
    
end

end