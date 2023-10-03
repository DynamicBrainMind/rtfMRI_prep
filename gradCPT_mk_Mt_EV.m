
% Load in behav data
display('Choose behavioral data');
uiopen

RT=response(:,5); % get RTs
RT(find(RT==0))=NaN;

CO_indices=find(response(:,1)==1 & response(:,2)==0);
CE_indices=find(response(:,1)==1 & response(:,2)~=0);
CC_indices=find(response(:,1)==2 & response(:,2)~=0);
OE_indices=find(response(:,1)==2 & response(:,2)==0);
CEs_total=length(CE_indices);
COs_total=length(CO_indices);

% Subtract start time from onset of each trial
for i=1:length(RT) 
    Stimulus_onset(i)=data(i,9)-starttime;
end

% Find onset times of stimuli with CEs and COs
CE_onsets=[];
CE_onsets=Stimulus_onset(CE_indices);
CO_onsets=[];
CO_onsets=Stimulus_onset(CO_indices);
RT(CE_indices)=NaN; % remove CE RTs

% Find mountain and city event onset times
mountain_ind=find(response(:,1)==1);
mountain_ind_all=mountain_ind;
mt_dif=diff(mountain_ind); % Find and delete repeating mountain events
mt_repeat_ind=find(mt_dif==1);
mountain_ind(mt_repeat_ind+1)=[];
        
Mt_onsets_noRepeat=Stimulus_onset(mountain_ind);
city_ind=find(response(:,1)==2);
city_onsets=Stimulus_onset(city_ind);

% Delete repeating mountain events from CO+CE lists
CE_list=[];
for i=1:length(CE_indices)
    include=find(mountain_ind==CE_indices(i));
    if isempty(include)==0
        CE_list=[CE_list CE_indices(i)];        
    end
end

CO_list=[];
for i=1:length(CO_indices)
    include=find(mountain_ind==CO_indices(i));
    if isempty(include)==0
        CO_list=[CO_list CO_indices(i)];
    end
end

% Calculate button press onsets
RT_onset=RT+Stimulus_onset; 

% concatenate all mountains
Mt_onsets=[CO_onsets';CE_onsets'];
Mt_onsets=sort(Mt_onsets);

% calculate total RTs (correct commission trials)
Total_RTs=sum(~isnan(RT_onset(:))); 

% Calculate mean and SD of trials with responses (correct commissions)
meanRT=nanmean(RT);
stdRT=nanstd(RT);

% convert RTs to z scores (deviance from mean) and absolute z scores
VTC=(RT-meanRT)/stdRT;
abs_VTC=abs(VTC); 

%interp to fill NaNs
% VTC_interp=inpaint_nans(abs_VTC);
% RT_onset_interp=inpaint_nans(RT_onset);

% save Mountain EV (with repeat mountains removed)
Mt_EV=[Mt_onsets_noRepeat' zeros(length(Mt_onsets_noRepeat),1) ones(length(Mt_onsets_noRepeat),1)];
dlmwrite('Mt_EV.txt', Mt_EV, '\t') ;
display(['Mt_EV.txt saved']);
