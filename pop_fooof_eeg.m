function fooof_results = pop_fooof_eeg(varargin)
    % Author: The Voytek Lab and Brian Barry 
    % GUI for FOOOF wrapper on spectral data from EEGLAB

    % For fooof related docs see: https://github.com/fooof-tools/fooof_mat/blob/master/fooof_mat/
    
    % For relevant EEGLAB related docs see:
    % https://github.com/sccn/eeglab/blob/develop/functions/popfunc/pop_spectopo.m
    


    promptstr    = { 'Enter the parameter:' };
    inistr       = { '0' };
    result       = inputdlg( promptstr, 'Title of window', 1,  inistr);
    if length( result ) == 0 return; end;

    param3   	 = eval( [ '[' result{1} ']' ] ); % the brackets allow to process matlab arrays
