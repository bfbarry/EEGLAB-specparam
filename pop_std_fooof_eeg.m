function STUDY = pop_std_fooof_eeg(varargin)
    % Author: The Voytek Lab and Brian Barry 
    % GUI for FOOOF wrapper on spectral data from EEGLAB

    % For fooof related docs see: https://github.com/fooof-tools/fooof_mat/blob/master/fooof_mat/
    
    % For relevant EEGLAB related docs see:
    % https://github.com/sccn/eeglab/blob/develop/functions/popfunc/pop_spectopo.m
    
    % Should have
        % settings.peak_width_limits sets the possible lower- and upper-bounds for the fitted peak widths.
        % settings.max_n_peaks sets the maximum number of peaks to fit.
        % settings.min_peak_height sets an absolute limit on the minimum height (above aperiodic) for any extracted peak.
        % settings.peak_threshold sets a relative threshold above which a peak height must cross to be included in the model.
        % settings.aperiodic_mode defines the approach to use to parameterize the aperiodic component.

    settings = struct();
    promptstr    = { 'Enter the parameter:' };
    inistr       = { '0' };
    result       = inputdlg( promptstr, 'Title of window', 1,  inistr);
    if length( result ) == 0 return; end;

    param3   	 = eval( [ '[' result{1} ']' ] ); % the brackets allow to process matlab arrays
