function [EEG, LASTCOM] = pop_eeg_fooof(EEG, varargin)
    % Author: The Voytek Lab and Brian Barry 
    % GUI for FOOOF wrapper on spectral data from EEGLAB

    % For fooof related docs see: https://github.com/fooof-tools/fooof_mat/blob/master/fooof_mat/
    
    % For relevant EEGLAB related docs see:
    % https://github.com/sccn/eeglab/blob/develop/functions/popfunc/pop_spectopo.m
    

    %param3   	 = eval( [ '[' result{1} ']' ] ); % the brackets allow to process matlab arrays

    % popup window parameters
	% -----------------------
	% promptstr    = {['New sampling rate']};
	% inistr       = { 0 };
	% result       = inputdlg2( promptstr, 'Resample current dataset -- pop_resample()', 1,  inistr, 'pop_resample');
	% if length(result) == 0 return; end
    % freq         = eval( result{1} );
    
    if ~isempty(EEG.icaweights) %maybe different UI if ICA performed previously
        default_comps = [num2str(1) ':' num2str(max(EEG.icachansind))];
    else
        default_comps = '';
    end

    uilist = { { 'style' 'text' 'string' 'epoch range [min_ms max_ms]:' } ... %2 element array
            { 'style' 'edit' 'string' [num2str( EEG.xmin*1000) ' ' num2str(EEG.xmax*1000)]  } ...
            { 'style' 'text' 'string' 'percent of the data to sample for computing:' } ...
            { 'style' 'edit' 'string' 100 } ...
            { 'style' 'text' 'string' 'Frequency range to fit:' } ...
            { 'style' 'edit' 'string' '' } ...
            { 'style' 'text' 'string' 'ICA Components to include (default: all):' } ...
            { 'style' 'edit' 'string' default_comps } ...
            ... % Now FOOOF settings
            { 'style' 'text' 'string' '                     FOOOF settings (optional)' 'fontweight' 'bold' }...       
            { 'style' 'text' 'string' 'peak_width_limits' } ...
            { 'style' 'edit' 'string' '' } ...
            { 'style' 'text' 'string' 'max_n_peaks' } ...
            { 'style' 'edit' 'string' '' } ...
            { 'style' 'text' 'string' 'min_peak_height' } ...
            { 'style' 'edit' 'string' '' } ...
            { 'style' 'text' 'string' 'peak_threshold' } ...
            { 'style' 'edit' 'string' '' } ...
            { 'style' 'text' 'string' 'aperiodic_mode' } ...
            { 'style' 'edit' 'string' "'fixed'" } ... %want to make a checkmark later
            { 'style' 'text' 'string' 'verbose (boolean)' } ...
            { 'style' 'edit' 'string' 'false' } };
    uigeom = { [11 4] [11 3] [11 3] [11 3] [1] [11 3] [11 3] [11 3] [11 3] [11 3] [11 3]};
    [result, usrdat, sres2, sres] = inputgui( 'uilist', uilist, 'geometry', uigeom, 'title', 'FOOOF EEG - pop_eeg_fooof()', 'helpcom', 'pophelp(''pop_eeg_fooof'');', 'userdata', 0); %currently ignoring usrdat, sres2, sres
    params = {}; %parameters for fooof_eeg w/o FOOOF settings
    settings_keys = {'peak_width_limits','max_n_peaks','min_peak_height','peak_threshold','aperiodic_mode','verbose'}; %the FOOOF settings
    settings = struct(); %can be empty
    for i = 1:length(result)
        if i < 5 % spectral settings
            param_curr = eval( [ '[' result{i} ']' ] );
            params{end+1} = param_curr;
        else % FOOOF settings
            if ~isempty(eval( [ '[' result{i} ']' ] ))
                settings.(settings_keys{i-4}) = eval( [ '[' result{i} ']' ] );
            end
        end
    end
    
    EEG = eeg_fooof(EEG, params{1}, params{2}, params{3}, params{4}, settings);            % epoch 1        epoch 2    percent   f_range1      f_range2
    LASTCOM = sprintf('EEG = eeg_fooof(EEG, [%d %d], %d, [%d %d], [ %d ], settings)', params{1}(1), params{1}(2), params{2}, params{3}(1), params{3}(2), params{4}); % ! still have to add settings (how?)
    
    %%%%%%% THINGS TO MAYBE ADD %%%%%%

    % return the string command: !! line 1 should be [EEG, COM] = function(...)
    % -------------------------
    % com = sprintf('pop_sample( %s, %d, [%s] );', inputname(1), typeproc, int2str(param3));

    % return;
    
