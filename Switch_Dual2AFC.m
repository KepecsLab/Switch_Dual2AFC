function Switch_Dual2AFC
% 2-AFC olfactory and auditory discrimination task implented for Bpod fork https://github.com/KepecsLab/bpod
% This project is available on https://github.com/KepecsLab/BpodProtocols_Olf2AFC/

global BpodSystem
global nidaq

%% Task parameters
global TaskParameters
TaskParameters = BpodSystem.ProtocolSettings;
if isempty(fieldnames(TaskParameters))
    %% General
    TaskParameters.GUI.MaxSessionTime = 200;
    TaskParameters.GUI.CenterWaitMax = 200000; 
    TaskParameters.GUI.ITI = 1; 
    TaskParameters.GUI.PreITI = 0.3; 

    TaskParameters.GUI.DrinkingTime = .5;
    TaskParameters.GUI.DrinkingGrace = 0.3;
    TaskParameters.GUI.CenterGrace = 0.1;
    TaskParameters.GUI.ChoiceDeadLine = 3;
    TaskParameters.GUI.TimeOutIncorrectChoice = 0; % (s)
    TaskParameters.GUI.TimeOutBrokeFixation = 3; % (s)
    TaskParameters.GUI.TimeOutEarlyWithdrawal = 3; % (s)
    TaskParameters.GUI.TimeOutSkippedFeedback = 0; % (s)
    TaskParameters.GUI.PercentAuditory = 1;
    
    TaskParameters.GUI.AuditoryDiscretize=false;
    TaskParameters.GUIMeta.AuditoryDiscretize.Style = 'checkbox';
    
    TaskParameters.GUI.StartEasyTrials = 100;
    TaskParameters.GUI.Percent50Fifty = 0;
    TaskParameters.GUI.PercentCatch = 0;
    TaskParameters.GUI.CatchError = false;
    TaskParameters.GUIMeta.CatchError.Style = 'checkbox';
    
    TaskParameters.GUI.ErrorLoop = true;
    TaskParameters.GUIMeta.ErrorLoop.Style = 'checkbox';
    TaskParameters.GUI.ErrorLoopRate = 1;
    TaskParameters.GUI.ErrorLoopDiffBoundary = 0.15;  %boundary for omega difficulty that repeats
    TaskParameters.GUI.ErrorLoopReplace = 2; %preallocated trials
    TaskParameters.GUI.Ports_LMR = 123;
    TaskParameters.GUI.Ports_Switch = 4;
    TaskParameters.GUI.PortLEDs = true;
    TaskParameters.GUIMeta.PortLEDs.Style = 'checkbox';
    TaskParameters.GUIPanels.General = {'MaxSessionTime','CenterWaitMax','ITI','PreITI','DrinkingTime','DrinkingGrace', 'CenterGrace','ChoiceDeadLine','TimeOutIncorrectChoice','TimeOutBrokeFixation','TimeOutEarlyWithdrawal','TimeOutSkippedFeedback','PercentAuditory','AuditoryDiscretize','StartEasyTrials','Percent50Fifty','PercentCatch','CatchError','ErrorLoop','ErrorLoopRate', 'ErrorLoopDiffBoundary', 'ErrorLoopReplace','Ports_LMR','Ports_Switch','PortLEDs'};
    %% Reward&BlockGeneral
    TaskParameters.GUI.RewardAmount = 25; %low reward amount, high reward amount hardcoded as x1.66
    TaskParameters.GUI.SwitchRewardAmount = 30; 
    TaskParameters.GUI.HiMultiplier=1.8;
    TaskParameters.GUI.HiNoise=10;
    TaskParameters.GUI.LowNoise=3;
    
    TaskParameters.GUI.RewardMin=6;
    TaskParameters.GUI.RewardMax=100;
    TaskParameters.GUI.BlockMean=150;
    TaskParameters.GUI.BlockNoise=10; %noise re: block length
    TaskParameters.GUIPanels.Reward = {'RewardAmount','SwitchRewardAmount','HiMultiplier','HiNoise','LowNoise','RewardMin', 'RewardMax', 'BlockMean','BlockNoise'};
    
    %% BiasControl
    TaskParameters.GUI.TrialSelection = 3;
    TaskParameters.GUIMeta.TrialSelection.Style = 'popupmenu';
    TaskParameters.GUIMeta.TrialSelection.String = {'Flat','Manual','BiasCorrecting','Competitive'};
    TaskParameters.GUIPanels.BiasControl = {'TrialSelection'};
    %% StimDelay
    TaskParameters.GUI.StimDelayAutoincrement = 0;
    TaskParameters.GUIMeta.StimDelayAutoincrement.Style = 'checkbox';
    TaskParameters.GUIMeta.StimDelayAutoincrement.String = 'Auto';
    TaskParameters.GUI.StimDelayMin = 0.2;
    TaskParameters.GUI.StimDelayMax = 0.4;
    TaskParameters.GUI.StimDelayIncr = 0.01;
    TaskParameters.GUI.StimDelayDecr = 0.01;
    TaskParameters.GUI.StimDelay = TaskParameters.GUI.StimDelayMin;
    TaskParameters.GUIMeta.StimDelay.Style = 'text';
    TaskParameters.GUIPanels.StimDelay = {'StimDelayAutoincrement','StimDelayMin','StimDelayMax','StimDelayIncr','StimDelayDecr','StimDelay'};
    %% FeedbackDelay
    TaskParameters.GUI.FeedbackDelaySelection = 1;
    TaskParameters.GUIMeta.FeedbackDelaySelection.Style = 'popupmenu';
    TaskParameters.GUIMeta.FeedbackDelaySelection.String = {'Fix','AutoIncr','TruncExp'};
    TaskParameters.GUI.FeedbackDelayMin = 0.01;
    TaskParameters.GUI.FeedbackDelayMax = 0.1;
    TaskParameters.GUI.FeedbackDelayIncr = 0.01;
    TaskParameters.GUI.FeedbackDelayDecr = 0.01;
    TaskParameters.GUI.FeedbackDelayTau = 0.05;
    TaskParameters.GUI.FeedbackDelayGrace = 0;
    TaskParameters.GUI.IncorrectChoiceFeedbackType = 1;
    TaskParameters.GUIMeta.IncorrectChoiceFeedbackType.Style = 'popupmenu';
    TaskParameters.GUIMeta.IncorrectChoiceFeedbackType.String = {'None','Tone','PortLED'};
    TaskParameters.GUI.SkippedFeedbackFeedbackType = 1;
    TaskParameters.GUIMeta.SkippedFeedbackFeedbackType.Style = 'popupmenu';
    TaskParameters.GUIMeta.SkippedFeedbackFeedbackType.String = {'None','Tone','PortLED'};
    TaskParameters.GUI.FeedbackDelay = TaskParameters.GUI.FeedbackDelayMin;
    TaskParameters.GUIMeta.FeedbackDelay.Style = 'text';
    TaskParameters.GUIPanels.FeedbackDelay = {'FeedbackDelaySelection','FeedbackDelayMin','FeedbackDelayMax','FeedbackDelayIncr','FeedbackDelayDecr','FeedbackDelayTau','FeedbackDelayGrace','FeedbackDelay','IncorrectChoiceFeedbackType','SkippedFeedbackFeedbackType'};
    %% OdorParams
    TaskParameters.GUI.OdorA_bank = 3;
    TaskParameters.GUI.OdorB_bank = 4;
    %     TaskParameters.GUI.OdorSettings = 0;
    %     TaskParameters.GUI.OdorTable.OdorFracA = 50+[-1; 1]*round(logspace(log10(6),log10(90),3)/2);
    %     TaskParameters.GUI.OdorTable.OdorFracA = sort(TaskParameters.GUI.OdorTable.OdorFracA(:));
    TaskParameters.GUI.OdorTable.OdorFracA = [5, 30, 45, 55, 70, 95]';
    TaskParameters.GUI.OdorTable.OdorProb = ones(size(TaskParameters.GUI.OdorTable.OdorFracA))/numel(TaskParameters.GUI.OdorTable.OdorFracA);
    TaskParameters.GUIMeta.OdorTable.Style = 'table';
    TaskParameters.GUIMeta.OdorTable.String = 'Odor probabilities';
    TaskParameters.GUIMeta.OdorTable.ColumnLabel = {'a = Frac Odor A','P(a)'};
    TaskParameters.GUI.OdorStimulusTimeMin = 0;
    %     TaskParameters.GUIMeta.OdorSettings.Style = 'pushbutton';
    %     TaskParameters.GUIMeta.OdorSettings.String = 'Odor settings';
    %     TaskParameters.GUIMeta.OdorSettings.Callback = @GUIOdorSettings;
    TaskParameters.GUIPanels.Olfactometer = {'OdorA_bank', 'OdorB_bank'};
    TaskParameters.GUIPanels.OlfStimuli = {'OdorTable','OdorStimulusTimeMin'};
    %% Auditory Params
    %clicks
    TaskParameters.GUI.AuditoryAlpha = 0.5;
    TaskParameters.GUI.LeftBiasAud = 0.5;
    TaskParameters.GUIMeta.LeftBiasAud.Style = 'text';
    TaskParameters.GUI.SumRates = 100;
    %zador freq stimuli
    TaskParameters.GUI.Aud_nFreq = 18;
    TaskParameters.GUI.Aud_NoEvidence = 0;
    TaskParameters.GUI.Aud_minFreq = 200;
    TaskParameters.GUI.Aud_maxFreq = 20000;
    TaskParameters.GUI.Aud_Volume = 70;
    TaskParameters.GUI.Aud_ToneDuration = 0.03;
    TaskParameters.GUI.Aud_ToneOverlap = 0.6667;
    TaskParameters.GUI.Aud_Ramp = 0.003;
    TaskParameters.GUI.Aud_SamplingRate = 192000;
    TaskParameters.GUI.Aud_UseMiddleOctave=0;
    TaskParameters.GUI.Aud_Levels.AudFracHigh = [5, 30, 45, 55, 70, 95]';
    TaskParameters.GUI.Aud_Levels.AudPFrac = ones(size(TaskParameters.GUI.Aud_Levels.AudFracHigh))/numel(TaskParameters.GUI.Aud_Levels.AudFracHigh);
    TaskParameters.GUIMeta.Aud_Levels.Style = 'table';
    TaskParameters.GUIMeta.Aud_Levels.String = 'Freq probabilities';
    TaskParameters.GUIMeta.Aud_Levels.ColumnLabel = {'a = Frac high','P(a)'};
    %min auditory stimulus and general stuff
    TaskParameters.GUI.AuditoryStimulusTime = 0.35;
    TaskParameters.GUI.AuditoryStimulusType = 1;
    TaskParameters.GUIMeta.AuditoryStimulusType.Style = 'popupmenu';
    TaskParameters.GUIMeta.AuditoryStimulusType.String = {'Clicks','Freqs'};
    TaskParameters.GUI.MinSampleAudMin = 0.35;
    TaskParameters.GUI.MinSampleAudMax = 0.35;
    TaskParameters.GUI.MinSampleAudAutoincrement = false;
    TaskParameters.GUIMeta.MinSampleAudAutoincrement.Style = 'checkbox';
    TaskParameters.GUI.MinSampleAudIncr = 0.05;
    TaskParameters.GUI.MinSampleAudDecr = 0.02;
    TaskParameters.GUI.MinSampleAud = TaskParameters.GUI.MinSampleAudMin;
    TaskParameters.GUIMeta.MinSampleAud.Style = 'text';
    TaskParameters.GUIPanels.AudGeneral = {'AuditoryStimulusType','AuditoryStimulusTime'};
    TaskParameters.GUIPanels.AudClicks = {'AuditoryAlpha','LeftBiasAud','SumRates'};
    TaskParameters.GUIPanels.AudFreq = {'Aud_nFreq','Aud_NoEvidence','Aud_minFreq','Aud_maxFreq','Aud_Volume','Aud_ToneDuration','Aud_ToneOverlap','Aud_Ramp','Aud_SamplingRate','Aud_UseMiddleOctave'};
    TaskParameters.GUIPanels.AudFreqLevels = {'Aud_Levels'};
    TaskParameters.GUIPanels.AudMinSample= {'MinSampleAudMin','MinSampleAudMax','MinSampleAudAutoincrement','MinSampleAudIncr','MinSampleAudDecr','MinSampleAud'};
 %% Block structure
    % high block is randomly assigned when session starts
    %high and low noise blocks are randomly assigned when session starts
    
    HiTable=randi([0 1], 100,2);
    HiTable=HiTable(sum(HiTable,2)==1,:);
    HiTable=HiTable(randperm(10),:)*TaskParameters.GUI.HiMultiplier;
    x=[reshape(HiTable,1,[]);ones(1,numel(HiTable))];
    BlockTable=reshape(x,[],2);
    BlockTable(BlockTable==0)=1;
    
    HiNoise=[reshape(round(rand(1,10))',1,[]);zeros(1,10)];
    NoiseTable=reshape(HiNoise,[],1);
    
    TaskParameters.GUI.BlockTable.BlockNumber = [1:20]';
    TaskParameters.GUI.BlockTable.RewL = BlockTable(:,1);
    TaskParameters.GUI.BlockTable.RewR = BlockTable(:,2);
    TaskParameters.GUI.BlockTable.HiNoise = NoiseTable;
    
    x=[reshape(round(normrnd(TaskParameters.GUI.BlockMean,TaskParameters.GUI.BlockNoise,[10,1])),1,[]);ones(1,10)*200];
    LenTable=reshape(x,[],1);

    TaskParameters.GUI.BlockTable.BlockLen = LenTable;
    
    TaskParameters.GUIMeta.BlockTable.Style = 'table';
    TaskParameters.GUIMeta.BlockTable.String = 'Block structure';
    TaskParameters.GUIMeta.BlockTable.ColumnLabel = {'BlockNumber', 'RewL','RewR', 'HiNoise', 'BlockLen'};
    
    TaskParameters.GUI.RewardDrift = true;
    TaskParameters.GUIMeta.RewardDrift.Style = 'checkbox';
   

    TaskParameters.GUIPanels.BlockStructure = {'BlockTable', 'RewardDrift'};
    %% Plots
    %Show Plots
    TaskParameters.GUI.ShowPsycOlf = 1;
    TaskParameters.GUIMeta.ShowPsycOlf.Style = 'checkbox';
    TaskParameters.GUI.ShowPsycAud = 1;
    TaskParameters.GUIMeta.ShowPsycAud.Style = 'checkbox';
    TaskParameters.GUI.ShowVevaiometric = 1;
    TaskParameters.GUIMeta.ShowVevaiometric.Style = 'checkbox';
    TaskParameters.GUI.ShowTrialRate = 1;
    TaskParameters.GUIMeta.ShowTrialRate.Style = 'checkbox';
    TaskParameters.GUI.ShowFix = 1;
    TaskParameters.GUIMeta.ShowFix.Style = 'checkbox';
    TaskParameters.GUI.ShowST = 1;
    TaskParameters.GUIMeta.ShowST.Style = 'checkbox';
    TaskParameters.GUI.ShowFeedback = 1;
    TaskParameters.GUIMeta.ShowFeedback.Style = 'checkbox';
    TaskParameters.GUIPanels.ShowPlots = {'ShowPsycOlf','ShowPsycAud','ShowVevaiometric','ShowTrialRate','ShowFix','ShowST','ShowFeedback'};
    %Vevaiometric
    TaskParameters.GUI.VevaiometricMinWT = 2;
    TaskParameters.GUI.VevaiometricNBin = 8;
    TaskParameters.GUI.VevaiometricShowPoints = 1;
    TaskParameters.GUIMeta.VevaiometricShowPoints.Style = 'checkbox';
    TaskParameters.GUIPanels.Vevaiometric = {'VevaiometricMinWT','VevaiometricNBin','VevaiometricShowPoints'};
    %% Laser
    TaskParameters.GUI.LaserTrials = false;
    TaskParameters.GUI.LaserSoftCode = false;
    TaskParameters.GUIMeta.LaserSoftCode.Style='checkbox';
    TaskParameters.GUI.LaserAmp = 5;
    TaskParameters.GUI.LaserStimFreq = 0;
    TaskParameters.GUI.LaserPulseDuration_ms = 1;
    TaskParameters.GUI.LaserTrainDuration_ms = 0;
    TaskParameters.GUI.LaserRampDuration_ms = 0;
    TaskParameters.GUI.LaserTrainRandStart = false;
    TaskParameters.GUIMeta.LaserTrainRandStart.Style='checkbox';
    TaskParameters.GUI.LaserTrainStartMin_s = 0;
    TaskParameters.GUI.LaserTrainStartMax_s = 5;
    TaskParameters.GUI.LaserITI = 0; TaskParameters.GUIMeta.LaserITI.Style = 'checkbox';
    TaskParameters.GUI.LaserPreStim = 0; TaskParameters.GUIMeta.LaserPreStim.Style = 'checkbox';
    TaskParameters.GUI.LaserStim = 0; TaskParameters.GUIMeta.LaserStim.Style = 'checkbox';
    TaskParameters.GUI.LaserMov = 0; TaskParameters.GUIMeta.LaserMov.Style = 'checkbox';
    TaskParameters.GUI.LaserTimeInvestment = 1; TaskParameters.GUIMeta.LaserTimeInvestment.Style = 'checkbox';
    TaskParameters.GUI.LaserRew = 0; TaskParameters.GUIMeta.LaserRew.Style = 'checkbox';
    TaskParameters.GUI.LaserFeedback = 0; TaskParameters.GUIMeta.LaserFeedback.Style = 'checkbox';
    TaskParameters.GUIPanels.LaserGeneral = {'LaserTrials','LaserSoftCode','LaserAmp','LaserStimFreq','LaserPulseDuration_ms'};
    TaskParameters.GUIPanels.LaserTrain = {'LaserTrainDuration_ms','LaserTrainRandStart','LaserRampDuration_ms','LaserTrainStartMin_s','LaserTrainStartMax_s'};
    TaskParameters.GUIPanels.LaserTaskEpochs = {'LaserITI','LaserPreStim','LaserStim','LaserMov','LaserTimeInvestment','LaserRew','LaserFeedback'};
    %% Video
    TaskParameters.GUI.Wire1VideoTrigger = false;
    TaskParameters.GUIMeta.Wire1VideoTrigger.Style = 'checkbox';
    TaskParameters.GUI.VideoTrials = 1;
    TaskParameters.GUIMeta.VideoTrials.Style = 'popupmenu';
    TaskParameters.GUIMeta.VideoTrials.String = {'Investment','All'};
    TaskParameters.GUIPanels.VideoGeneral = {'Wire1VideoTrigger','VideoTrials'};
    
    %% Photometry
    %photometry general
    TaskParameters.GUI.Photometry=false;
    TaskParameters.GUIMeta.Photometry.Style='checkbox';
    TaskParameters.GUI.DbleFibers=0;
    TaskParameters.GUIMeta.DbleFibers.Style='checkbox';
    TaskParameters.GUIMeta.DbleFibers.String='Auto';
    TaskParameters.GUI.Isobestic405=0;
    TaskParameters.GUIMeta.Isobestic405.Style='checkbox';
    TaskParameters.GUIMeta.Isobestic405.String='Auto';
    TaskParameters.GUI.RedChannel=1;
    TaskParameters.GUIMeta.RedChannel.Style='checkbox';
    TaskParameters.GUIMeta.RedChannel.String='Auto';    
    TaskParameters.GUIPanels.PhotometryRecording={'Photometry','DbleFibers','Isobestic405','RedChannel'};
    
    %plot photometry
    TaskParameters.GUI.TimeMin=-4;
    TaskParameters.GUI.TimeMax=4;
    TaskParameters.GUI.NidaqMin=-5;
    TaskParameters.GUI.NidaqMax=10;
    TaskParameters.GUI.PhotoPlotSidePokeIn=true;
	TaskParameters.GUIMeta.PhotoPlotSidePokeIn.Style='checkbox';
    TaskParameters.GUI.PhotoPlotSidePokeLeave=true;
	TaskParameters.GUIMeta.PhotoPlotSidePokeLeave.Style='checkbox';
    TaskParameters.GUI.PhotoPlotReward=true;
	TaskParameters.GUIMeta.PhotoPlotReward.Style='checkbox';    
     TaskParameters.GUI.BaselineBegin=0.1;
    TaskParameters.GUI.BaselineEnd=1.1;
    TaskParameters.GUIPanels.PhotometryPlot={'TimeMin','TimeMax','NidaqMin','NidaqMax','PhotoPlotSidePokeIn','PhotoPlotSidePokeLeave','PhotoPlotReward','BaselineBegin','BaselineEnd'};
    
    %% Nidaq and Photometry
    TaskParameters.GUI.PhotometryVersion=1;
    TaskParameters.GUI.Modulation=true;
    TaskParameters.GUIMeta.Modulation.Style='checkbox';
    TaskParameters.GUIMeta.Modulation.String='Auto';
	TaskParameters.GUI.NidaqDuration=4;
    TaskParameters.GUI.NidaqSamplingRate=6100;
    TaskParameters.GUI.DecimateFactor=610;
    TaskParameters.GUI.LED1_Name='Fiber1 470-A1';
    TaskParameters.GUIMeta.LED1_Name.Style='edittext';
    TaskParameters.GUI.LED1_Amp=2;
    TaskParameters.GUI.LED1_Freq=211;
    TaskParameters.GUI.LED2_Name='Fiber1 405 / 565';
    TaskParameters.GUIMeta.LED2_Name.Style='edittext';
    TaskParameters.GUI.LED2_Amp=2;
    TaskParameters.GUI.LED2_Freq=531;
    TaskParameters.GUI.LED1b_Name='Fiber2 470-mPFC';
    TaskParameters.GUIMeta.LED1b_Name.Style='edittext';
    TaskParameters.GUI.LED1b_Amp=2;
    TaskParameters.GUI.LED1b_Freq=531;

    TaskParameters.GUIPanels.PhotometryNidaq={'PhotometryVersion','Modulation','NidaqDuration',...
                            'NidaqSamplingRate','DecimateFactor',...
                            'LED1_Name','LED1_Amp','LED1_Freq',...
                            'LED2_Name','LED2_Amp','LED2_Freq',...
                            'LED1b_Name','LED1b_Amp','LED1b_Freq'};
                        
                     % rig-specific
        TaskParameters.GUI.nidaqDev='Dev2';
        TaskParameters.GUIMeta.nidaqDev.Style='edittext';
        
        TaskParameters.GUIPanels.PhotometryRig={'nidaqDev'};      
                        
    %%
    TaskParameters.GUI = orderfields(TaskParameters.GUI);
    %% Tabs
    TaskParameters.GUITabs.General = {'StimDelay','BiasControl','Reward','General','FeedbackDelay'};
    TaskParameters.GUITabs.Odor = {'Olfactometer','OlfStimuli'};
    TaskParameters.GUITabs.Auditory = {'AudGeneral','AudMinSample','AudClicks','AudFreq','AudFreqLevels'};
    TaskParameters.GUITabs.Plots = {'ShowPlots','Vevaiometric'};
    TaskParameters.GUITabs.Laser = {'LaserGeneral','LaserTrain','LaserTaskEpochs'};
    TaskParameters.GUITabs.Video = {'VideoGeneral'};
    TaskParameters.GUITabs.Photometry = {'PhotometryRecording','PhotometryNidaq','PhotometryPlot','PhotometryRig'};
    TaskParameters.GUITabs.BlockStructure = {'BlockStructure'};
    
    %%Non-GUI Parameters (but saved)
    TaskParameters.Figures.OutcomePlot.Position = [200, 200, 1000, 400];
    TaskParameters.Figures.ParameterGUI.Position =  [9, 454, 1474, 562];
    
end
BpodParameterGUI('init', TaskParameters);


%% Initializing data (trial type) vectors
BpodSystem.Data.Custom.HiBlock(1) = 1;
BpodSystem.Data.Custom.HiNoise(1) = TaskParameters.GUI.BlockTable.HiNoise(1);
BpodSystem.Data.Custom.SwitchBaited(1)=0;
BpodSystem.Data.Custom.BlockNumber(1)=1;
BpodSystem.Data.Custom.BlockTrial(1)=1;
BpodSystem.Data.Custom.BlockTable=horzcat(TaskParameters.GUI.BlockTable.RewL,TaskParameters.GUI.BlockTable.RewR);

BpodSystem.Data.Custom.ErrorLoopTrial(1) = 0;
BpodSystem.Data.Custom.ChoiceLeft = [];
BpodSystem.Data.Custom.ChoiceCorrect = [];
BpodSystem.Data.Custom.Feedback = false(0);
BpodSystem.Data.Custom.FeedbackTime = [];
BpodSystem.Data.Custom.FixBroke = false(0);
BpodSystem.Data.Custom.EarlyWithdrawal = false(0);
BpodSystem.Data.Custom.FixDur = [];
BpodSystem.Data.Custom.MT = [];
BpodSystem.Data.Custom.CatchTrial = false;
BpodSystem.Data.Custom.OdorFracA = randsample([min(TaskParameters.GUI.OdorTable.OdorFracA) max(TaskParameters.GUI.OdorTable.OdorFracA)],2)';
BpodSystem.Data.Custom.OdorID = 2 - double(BpodSystem.Data.Custom.OdorFracA > 50);
BpodSystem.Data.Custom.OdorPair = ones(1,2)*2;
BpodSystem.Data.Custom.ST = [];
BpodSystem.Data.Custom.ResolutionTime = [];
BpodSystem.Data.Custom.Rewarded = false(0);
%BpodSystem.Data.Custom.RewardMagnitude = TaskParameters.GUI.RewardAmount*[TaskParameters.GUI.BlockTable.RewL(1), TaskParameters.GUI.BlockTable.RewR(1)];
BpodSystem.Data.Custom.TrialNumber = [];
BpodSystem.Data.Custom.LaserTrial = false;
BpodSystem.Data.Custom.LaserTrialTrainStart = NaN;
BpodSystem.Data.Custom.AuditoryTrial = rand(1,2) < TaskParameters.GUI.PercentAuditory;
BpodSystem.Data.Custom.ClickTask = true(1,2) & TaskParameters.GUI.AuditoryStimulusType == 1;
BpodSystem.Data.Custom.OlfactometerStartup = false;
BpodSystem.Data.Custom.PsychtoolboxStartup = false;

%housekeeping
BpodSystem.Data.Custom.RewardBase=TaskParameters.GUI.RewardAmount*horzcat(TaskParameters.GUI.BlockTable.RewL(1,:),TaskParameters.GUI.BlockTable.RewR(1,:));


%Reward Magnitude
if TaskParameters.GUI.RewardDrift == false
    BpodSystem.Data.Custom.RewardMagnitude = TaskParameters.GUI.RewardAmount*horzcat(TaskParameters.GUI.BlockTable.RewL(1,:),TaskParameters.GUI.BlockTable.RewR(1,:));

elseif TaskParameters.GUI.RewardDrift == true
    
    HiNoiseMatrix=(horzcat(TaskParameters.GUI.BlockTable.RewL,TaskParameters.GUI.BlockTable.RewR)==max(horzcat(TaskParameters.GUI.BlockTable.RewL,TaskParameters.GUI.BlockTable.RewR))).*TaskParameters.GUI.BlockTable.HiNoise;
    LowNoiseMatrix=(horzcat(TaskParameters.GUI.BlockTable.RewL,TaskParameters.GUI.BlockTable.RewR)==max(horzcat(TaskParameters.GUI.BlockTable.RewL,TaskParameters.GUI.BlockTable.RewR))).*~TaskParameters.GUI.BlockTable.HiNoise;
    BpodSystem.Data.Custom.RewardMagnitude = round(TaskParameters.GUI.RewardAmount*horzcat(TaskParameters.GUI.BlockTable.RewL(1,:),TaskParameters.GUI.BlockTable.RewR(1,:))+ normrnd(0,  TaskParameters.GUI.HiNoise).*HiNoiseMatrix(1,:)+normrnd(0,  TaskParameters.GUI.LowNoise).*LowNoiseMatrix(1,:));
    
    while sum(BpodSystem.Data.Custom.RewardMagnitude < TaskParameters.GUI.RewardMin) > 0 || sum(BpodSystem.Data.Custom.RewardMagnitude >TaskParameters.GUI.RewardMax ) > 0
        BpodSystem.Data.Custom.RewardMagnitude = round(TaskParameters.GUI.RewardAmount*horzcat(TaskParameters.GUI.BlockTable.RewL(1,:),TaskParameters.GUI.BlockTable.RewR(1,:))+ normrnd(0,  TaskParameters.GUI.HiNoise)*HiNoiseMatrix(1,:)+normrnd(0,  TaskParameters.GUI.LowNoise)*LowNoiseMatrix(1,:));
    end
    
    %disp(normrnd(0,  TaskParameters.GUI.LowNoise)*LowNoiseMatrix(1,:))
    %disp(normrnd(0,  TaskParameters.GUI.HiNoise)*HiNoiseMatrix(1,:))
    %disp(BpodSystem.Data.Custom.RewardMagnitude)
    %disp(BpodSystem.Data.Custom.RewardBase)
end

% make auditory stimuli for first trials
for a = 1:2
    switch BpodSystem.Data.Custom.ClickTask(a)
        case true
            if BpodSystem.Data.Custom.AuditoryTrial(a)
                
                if TaskParameters.GUI.AuditoryDiscretize == true
                   BpodSystem.Data.Custom.AuditoryOmega(a)=randsample([0.05 0.3 0.45 0.55 0.7 0.95],1); 
                else
                   BpodSystem.Data.Custom.AuditoryOmega(a) = betarnd(TaskParameters.GUI.AuditoryAlpha/4,TaskParameters.GUI.AuditoryAlpha/4,1,1);
                end
                
                BpodSystem.Data.Custom.LeftClickRate(a) = round(BpodSystem.Data.Custom.AuditoryOmega(a)*TaskParameters.GUI.SumRates);
                BpodSystem.Data.Custom.RightClickRate(a) = round((1-BpodSystem.Data.Custom.AuditoryOmega(a))*TaskParameters.GUI.SumRates);
                BpodSystem.Data.Custom.LeftClickTrain{a} = GeneratePoissonClickTrain(BpodSystem.Data.Custom.LeftClickRate(a), TaskParameters.GUI.AuditoryStimulusTime);
                BpodSystem.Data.Custom.RightClickTrain{a} = GeneratePoissonClickTrain(BpodSystem.Data.Custom.RightClickRate(a), TaskParameters.GUI.AuditoryStimulusTime);
                
                %correct left/right click train
                if ~isempty(BpodSystem.Data.Custom.LeftClickTrain{a}) && ~isempty(BpodSystem.Data.Custom.RightClickTrain{a})
                    BpodSystem.Data.Custom.LeftClickTrain{a}(1) = min(BpodSystem.Data.Custom.LeftClickTrain{a}(1),BpodSystem.Data.Custom.RightClickTrain{a}(1));
                    BpodSystem.Data.Custom.RightClickTrain{a}(1) = min(BpodSystem.Data.Custom.LeftClickTrain{a}(1),BpodSystem.Data.Custom.RightClickTrain{a}(1));
                elseif  isempty(BpodSystem.Data.Custom.LeftClickTrain{a}) && ~isempty(BpodSystem.Data.Custom.RightClickTrain{a})
                    BpodSystem.Data.Custom.LeftClickTrain{a}(1) = BpodSystem.Data.Custom.RightClickTrain{a}(1);
                elseif ~isempty(BpodSystem.Data.Custom.LeftClickTrain{1}) &&  isempty(BpodSystem.Data.Custom.RightClickTrain{a})
                    BpodSystem.Data.Custom.RightClickTrain{a}(1) = BpodSystem.Data.Custom.LeftClickTrain{a}(1);
                else
                    BpodSystem.Data.Custom.LeftClickTrain{a} = round(1/BpodSystem.Data.Custom.LeftClickRate*10000)/10000;
                    BpodSystem.Data.Custom.RightClickTrain{a} = round(1/BpodSystem.Data.Custom.RightClickRate*10000)/10000;
                end
                if length(BpodSystem.Data.Custom.LeftClickTrain{a}) > length(BpodSystem.Data.Custom.RightClickTrain{a})
                    BpodSystem.Data.Custom.LeftRewarded(a) = double(1);
                elseif length(BpodSystem.Data.Custom.LeftClickTrain{1}) < length(BpodSystem.Data.Custom.RightClickTrain{a})
                    BpodSystem.Data.Custom.LeftRewarded(a) = double(0);
                else
                    BpodSystem.Data.Custom.LeftRewarded(a) = rand<0.5;
                end
            else
                BpodSystem.Data.Custom.AuditoryOmega(a) = NaN;
                BpodSystem.Data.Custom.LeftClickRate(a) = NaN;
                BpodSystem.Data.Custom.RightClickRate(a) = NaN;
                BpodSystem.Data.Custom.LeftClickTrain{a} = [];
                BpodSystem.Data.Custom.RightClickTrain{a} = [];
            end
            
            
        case false
            StimulusSettings.SamplingRate = TaskParameters.GUI.Aud_SamplingRate; % Sound card sampling rate;
            StimulusSettings.ramp = TaskParameters.GUI.Aud_Ramp;
            StimulusSettings.nFreq = TaskParameters.GUI.Aud_nFreq; % Number of different frequencies to sample from
            StimulusSettings.ToneOverlap = TaskParameters.GUI.Aud_ToneOverlap;
            StimulusSettings.ToneDuration = TaskParameters.GUI.Aud_ToneDuration;
            StimulusSettings.Noevidence=TaskParameters.GUI.Aud_NoEvidence;
            StimulusSettings.minFreq = TaskParameters.GUI.Aud_minFreq ;
            StimulusSettings.maxFreq = TaskParameters.GUI.Aud_maxFreq ;
            StimulusSettings.UseMiddleOctave=TaskParameters.GUI.Aud_UseMiddleOctave;
            StimulusSettings.Volume=TaskParameters.GUI.Aud_Volume;
            StimulusSettings.nTones = floor((TaskParameters.GUI.AuditoryStimulusTime-StimulusSettings.ToneDuration*StimulusSettings.ToneOverlap)/(StimulusSettings.ToneDuration*(1-StimulusSettings.ToneOverlap))); %number of tones
            
            EasyProb = zeros(numel(TaskParameters.GUI.Aud_Levels.AudPFrac),1);
            EasyProb(1) = 0.5; EasyProb(end)=0.5;
            newFracHigh = randsample(TaskParameters.GUI.Aud_Levels.AudFracHigh,1,1,EasyProb);
            [Sound, Cloud, ~] = GenerateToneCloudDual(newFracHigh/100, StimulusSettings);
            BpodSystem.Data.Custom.AudFracHigh(a) = newFracHigh;
            BpodSystem.Data.Custom.AudCloud{a} = Cloud;
            BpodSystem.Data.Custom.AudSound{a} = Sound;
            BpodSystem.Data.Custom.LeftRewarded(a)= newFracHigh>50;
    end
    if BpodSystem.Data.Custom.AuditoryTrial(a)
        if BpodSystem.Data.Custom.ClickTask
            BpodSystem.Data.Custom.DV(a) = (length(BpodSystem.Data.Custom.LeftClickTrain{a}) - length(BpodSystem.Data.Custom.RightClickTrain{a}))./(length(BpodSystem.Data.Custom.LeftClickTrain{a}) + length(BpodSystem.Data.Custom.RightClickTrain{a}));
        else
            BpodSystem.Data.Custom.DV(a) = (2*BpodSystem.Data.Custom.AudFracHigh(a)-100)/100;
        end
        BpodSystem.Data.Custom.OdorFracA(a) = NaN;
        BpodSystem.Data.Custom.OdorID(a) = NaN;
        BpodSystem.Data.Custom.OdorPair(a) = NaN;
    else
        BpodSystem.Data.Custom.DV(a) = (2*BpodSystem.Data.Custom.OdorFracA(a)-100)/100;
    end
end%for a+1:2

BpodSystem.SoftCodeHandlerFunction = 'SoftCodeHandler';

%server data
[~,BpodSystem.Data.Custom.Rig] = system('hostname');
[~,BpodSystem.Data.Custom.Subject] = fileparts(fileparts(fileparts(fileparts(BpodSystem.DataPath))));

%% Configuring PulsePal
load PulsePalParamStimulus.mat
load PulsePalParamFeedback.mat
BpodSystem.Data.Custom.PulsePalParamStimulus=configurePulsePalLaser(PulsePalParamStimulus);
BpodSystem.Data.Custom.PulsePalParamFeedback=PulsePalParamFeedback;
clear PulsePalParamFeedback PulsePalParamStimulus
if BpodSystem.Data.Custom.AuditoryTrial(1)
   if ~BpodSystem.EmulatorMode
    
    if BpodSystem.Data.Custom.ClickTask(1) 
        ProgramPulsePal(BpodSystem.Data.Custom.PulsePalParamStimulus);
        SendCustomPulseTrain(1, BpodSystem.Data.Custom.RightClickTrain{1}, ones(1,length(BpodSystem.Data.Custom.RightClickTrain{1}))*5);
        SendCustomPulseTrain(2, BpodSystem.Data.Custom.LeftClickTrain{1}, ones(1,length(BpodSystem.Data.Custom.LeftClickTrain{1}))*5);
    else
        InitiatePsychtoolbox(1);
        PsychToolboxSoundServer('Load', 1, BpodSystem.Data.Custom.AudSound{1});
        BpodSystem.Data.Custom.AudSound{1} = {};
    end
    end
end

%% Initialize plots
BpodSystem.ProtocolFigures.SideOutcomePlotFig = figure('Position', TaskParameters.Figures.OutcomePlot.Position,'name','Outcome plot','numbertitle','off', 'MenuBar', 'none', 'Resize', 'off');
BpodSystem.GUIHandles.OutcomePlot.HandleRewOutcome = axes('Position',    [  .055          .38 .91 .1]);
BpodSystem.GUIHandles.OutcomePlot.HandleOutcome = axes('Position',    [  .055          .1 .91 .2]);
BpodSystem.GUIHandles.OutcomePlot.HandlePsycOlf = axes('Position',    [1*.05          .6  .1  .3], 'Visible', 'off');
BpodSystem.GUIHandles.OutcomePlot.HandlePsycAud = axes('Position',    [2*.05 + 1*.08   .6  .1  .3], 'Visible', 'off');
BpodSystem.GUIHandles.OutcomePlot.HandleTrialRate = axes('Position',  [3*.05 + 2*.08   .6  .1  .3], 'Visible', 'off');
BpodSystem.GUIHandles.OutcomePlot.HandleFix = axes('Position',        [4*.05 + 3*.08   .6  .1  .3], 'Visible', 'off');
BpodSystem.GUIHandles.OutcomePlot.HandleST = axes('Position',         [5*.05 + 4*.08   .6  .1  .3], 'Visible', 'off');
BpodSystem.GUIHandles.OutcomePlot.HandleFeedback = axes('Position',   [6*.05 + 5*.08   .6  .1  .3], 'Visible', 'off');
BpodSystem.GUIHandles.OutcomePlot.HandleVevaiometric = axes('Position',   [7*.05 + 6*.08   .6  .1  .3], 'Visible', 'off');
MainPlot(BpodSystem.GUIHandles.OutcomePlot,'init');
BpodSystem.ProtocolFigures.ParameterGUI.Position = TaskParameters.Figures.ParameterGUI.Position;
%BpodNotebook('init');

%% NIDAQ Initialization and Plots
if TaskParameters.GUI.Photometry
if (TaskParameters.GUI.DbleFibers+TaskParameters.GUI.Isobestic405+TaskParameters.GUI.RedChannel)*TaskParameters.GUI.Photometry >1
    disp('Error - Incorrect photometry recording parameters')
    return
end

Nidaq_photometry('ini');

FigNidaq1=Online_NidaqPlot('ini','470');
if TaskParameters.GUI.DbleFibers || TaskParameters.GUI.Isobestic405 || TaskParameters.GUI.RedChannel
    FigNidaq2=Online_NidaqPlot('ini','channel2');
end
end

%% Main loop
RunSession = true;
iTrial = 1;

while RunSession
    
    
    if iTrial==1
    
        HiTable=randi([0 1], 100,2);
        HiTable=HiTable(sum(HiTable,2)==1,:);
        HiTable=HiTable(randperm(10),:)*TaskParameters.GUI.HiMultiplier;
        x=[reshape(HiTable,1,[]);ones(1,numel(HiTable))];
        BlockTable=reshape(x,[],2);
        BlockTable(BlockTable==0)=1;

        HiNoise=[reshape(round(rand(1,10))',1,[]);zeros(1,10)];
        NoiseTable=reshape(HiNoise,[],1);

        TaskParameters.GUI.BlockTable.BlockNumber = [1:20]';
        TaskParameters.GUI.BlockTable.RewL = BlockTable(:,1);
        TaskParameters.GUI.BlockTable.RewR = BlockTable(:,2);
        TaskParameters.GUI.BlockTable.HiNoise = NoiseTable;
        
        x=[reshape(round(normrnd(TaskParameters.GUI.BlockMean,TaskParameters.GUI.BlockNoise,[10,1])),1,[]);ones(1,10)*200];
        LenTable=reshape(x,[],1);

        TaskParameters.GUI.BlockTable.BlockLen = LenTable;
        BpodSystem.Data.Custom.BlockTable=horzcat(TaskParameters.GUI.BlockTable.RewL,TaskParameters.GUI.BlockTable.RewR);

    end
    
    TaskParameters = BpodParameterGUI('sync', TaskParameters);
    
    InitiateOlfactometer(iTrial);
    InitiatePsychtoolbox(iTrial);
    
    %% send state matrix to Bpod
    sma = stateMatrix(iTrial);
    SendStateMatrix(sma);
    
    %% NIDAQ Get nidaq ready to start
    if TaskParameters.GUI.Photometry
        Nidaq_photometry('WaitToStart');
    end
    
    %% Run Trial
    RawEvents = RunStateMatrix;
    
    %% NIDAQ Stop acquisition and save data in bpod structure
    if TaskParameters.GUI.Photometry
    Nidaq_photometry('Stop');
    [PhotoData,Photo2Data]=Nidaq_photometry('Save');
    BpodSystem.Data.NidaqData{iTrial}=PhotoData;
    if TaskParameters.GUI.DbleFibers || TaskParameters.GUI.RedChannel
        BpodSystem.Data.Nidaq2Data{iTrial}=Photo2Data;
    end
    end
    
    %% Bpod save
    if ~isempty(fieldnames(RawEvents))
        BpodSystem.Data = AddTrialEvents(BpodSystem.Data,RawEvents);
        BpodSystem.Data.TrialSettings(iTrial) = TaskParameters;
        SaveBpodSessionData;
    end
    
    %% pause conditions    
    HandlePauseCondition; % Checks to see if the protocol is paused. If so, waits until user resumes.
    if BpodSystem.BeingUsed == 0
        return
    end
    
    if (BpodSystem.Data.TrialStartTimestamp(iTrial) - BpodSystem.Data.TrialStartTimestamp(1))/60 > TaskParameters.GUI.MaxSessionTime
        TaskParameters.GUI.MaxSessionTime = 1000;
        try
            Notify() % optional notify sript in your MATLAB path (not part of protocol)
        catch
        end
        RunProtocol('StartPause')
    end
    

    %% update custom data fields for this trial and draw future trials
    updateCustomDataFields(iTrial);
   %error loop: repeat last trial
   
   if TaskParameters.GUI.ErrorLoop 
       if iTrial>5 && rand(1)<=TaskParameters.GUI.ErrorLoopRate && (BpodSystem.Data.Custom.AuditoryOmega(iTrial)>(1-TaskParameters.GUI.ErrorLoopDiffBoundary) || BpodSystem.Data.Custom.AuditoryOmega(iTrial)<TaskParameters.GUI.ErrorLoopDiffBoundary) 
                if BpodSystem.Data.Custom.ChoiceCorrect(iTrial)==0 
                               %randomly adds incorrect
                    preAllocatedTrials=1:5;
                    replaceTrials=randsample(preAllocatedTrials,TaskParameters.GUI.ErrorLoopReplace);
                    
                        disp('error loop')
                        BpodSystem.Data.Custom.AuditoryOmega(iTrial+[replaceTrials])=BpodSystem.Data.Custom.AuditoryOmega(iTrial);
                        BpodSystem.Data.Custom.LeftClickRate(iTrial+[replaceTrials]) = BpodSystem.Data.Custom.LeftClickRate(iTrial);
                        BpodSystem.Data.Custom.RightClickRate(iTrial+[replaceTrials]) = BpodSystem.Data.Custom.RightClickRate(iTrial);
                        BpodSystem.Data.Custom.DV(iTrial+[replaceTrials]) = BpodSystem.Data.Custom.DV(iTrial);
                        BpodSystem.Data.Custom.LeftClickTrain(replaceTrials+iTrial)=BpodSystem.Data.Custom.LeftClickTrain(iTrial);
                        BpodSystem.Data.Custom.RightClickTrain(replaceTrials+iTrial)= BpodSystem.Data.Custom.RightClickTrain(iTrial);
                        BpodSystem.Data.Custom.LeftRewarded(iTrial+[replaceTrials])=BpodSystem.Data.Custom.LeftRewarded(iTrial);
                        BpodSystem.Data.Custom.ErrorLoopTrial(iTrial+[replaceTrials]) = 1;
                        BpodSystem.Data.Custom.LeftRewarded(iTrial+[replaceTrials]) = BpodSystem.Data.Custom.LeftRewarded(iTrial);

                       %if the next immediate trial needs to be replaced,
                       %else replaced in updatecustomdatafields
                        if ~BpodSystem.EmulatorMode && sum(replaceTrials==1)>0
                                if BpodSystem.Data.Custom.ClickTask(iTrial)
                                    SendCustomPulseTrain(1, BpodSystem.Data.Custom.RightClickTrain{iTrial}, ones(1,length(BpodSystem.Data.Custom.RightClickTrain{iTrial}))*5);
                                    SendCustomPulseTrain(2, BpodSystem.Data.Custom.LeftClickTrain{iTrial}, ones(1,length(BpodSystem.Data.Custom.LeftClickTrain{iTrial}))*5);
                                else
                                    PsychToolboxSoundServer('Load', 1, BpodSystem.Data.Custom.AudSound{iTrial+replaceThisTrial});
                                    BpodSystem.Data.Custom.AudSound{iTrial+replaceThisTrial} = {};
                                end
                        end
                        
                    

                end
           
       
       end
   else
       BpodSystem.Data.Custom.ErrorLoopTrial=NaN;
   end
    

    
    %% update behavior plots
    MainPlot(BpodSystem.GUIHandles.OutcomePlot,'update',iTrial);
    
    %% update photometry plots
    if TaskParameters.GUI.Photometry
            
        Alignments = {[],[],[]};
        %Choice
        if ~isnan(BpodSystem.Data.Custom.ChoiceLeft(iTrial)) %Choice
            Alignments{1} = 'start_'; %a little dangerous since generic state name start_ but so far (3/2019) only used for choice
        end
        %Leave
        if ~isnan(BpodSystem.Data.Custom.ChoiceLeft(iTrial)) && (BpodSystem.Data.Custom.ChoiceCorrect(iTrial) == 0 || BpodSystem.Data.Custom.CatchTrial(iTrial) == 1)
            Alignments{2} = BpodSystem.Data.Custom.ResolutionTime(iTrial);
        end
        %Reward
        if  BpodSystem.Data.Custom.Rewarded(iTrial)==1
            Alignments{3} = 'water_';
        end
        
        for k =1:length(Alignments)
             align = Alignments{k};
             if ~isempty(align)
            [currentNidaq1, rawNidaq1]=Online_NidaqDemod(PhotoData(:,1),nidaq.LED1,TaskParameters.GUI.LED1_Freq,TaskParameters.GUI.LED1_Amp,align);
            FigNidaq1=Online_NidaqPlot('update',[],FigNidaq1,currentNidaq1,rawNidaq1,k);
            
            if TaskParameters.GUI.Isobestic405 || TaskParameters.GUI.DbleFibers || TaskParameters.GUI.RedChannel
                if TaskParameters.GUI.Isobestic405
                    [currentNidaq2, rawNidaq2]=Online_NidaqDemod(PhotoData(:,1),nidaq.LED2,TaskParameters.GUI.LED2_Freq,TaskParameters.GUI.LED2_Amp,align);
                elseif TaskParameters.GUI.RedChannel
                    [currentNidaq2, rawNidaq2]=Online_NidaqDemod(Photo2Data(:,1),nidaq.LED2,TaskParameters.GUI.LED2_Freq,TaskParameters.GUI.LED2_Amp,align);
                elseif TaskParameters.GUI.DbleFibers
                    [currentNidaq2, rawNidaq2]=Online_NidaqDemod(Photo2Data(:,1),nidaq.LED2,TaskParameters.GUI.LED1b_Freq,TaskParameters.GUI.LED1b_Amp,align);
                end
                FigNidaq2=Online_NidaqPlot('update',[],FigNidaq2,currentNidaq2,rawNidaq2,k);
            end
             end%if non-empty align
        end%alignment loop
    end%if photometry
    
    iTrial = iTrial + 1;
    
end

%% photometry check
if TaskParameters.GUI.Photometry
    thismax=max(PhotoData(TaskParameters.GUI.NidaqSamplingRate:TaskParameters.GUI.NidaqSamplingRate*2,1))
    if thismax>4 || thismax<0.3
        disp('WARNING - Something is wrong with fiber #1 - run check-up! - unpause to ignore')
        BpodSystem.Pause=1;
        HandlePauseCondition;
    end
    if TaskParameters.GUI.DbleFibers
    thismax=max(Photo2Data(TaskParameters.GUI.NidaqSamplingRate:TaskParameters.GUI.NidaqSamplingRate*2,1))
    if thismax>4 || thismax<0.3
        disp('WARNING - Something is wrong with fiber #2 - run check-up! - unpause to ignore')
        BpodSystem.Pause=1;
        HandlePauseCondition;
    end
    end
end

end
