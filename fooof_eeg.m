function eeg_fooof_results = fooof_eeg(EEG, f_range, psd, mode, settings)
    % Author: The Voytek Lab and Brian Barry 
    % Calls FOOOF wrapper on spectral data from EEGLAB
    
    % TODO: should this use fooof_group too? 
    % - if so, want to incorporate foof_group()
    % - incorporate statistics 
    % - Decide on what to return
    
    % For fooof related docs see: https://github.com/fooof-tools/fooof_mat/blob/master/fooof_mat/
    
    % For relevant EEGLAB related docs see:
    % https://github.com/sccn/eeglab/blob/develop/functions/popfunc/pop_spectopo.m
    
    % if mode = 'single', runs fooof.m (mode is tentative)
    % if mode = 'group', runs fooof_group.m (once again unless a std_fooof_wrap.m is created)
    
    % Inputs:
    % EEG, ALLEEG
    %   f_range         = fitting range (Hz)
    %   power_spectrum  = row vector of power values (in group case psds = matrix of power values, which each row representing a spectrum)
    %   settings        = fooof model settings, in a struct, including:
    %       settings.peak_width_limts
    %       settings.max_n_peaks
    %       settings.min_peak_height
    %       settings.peak_threshold
    %       settings.aperiodic_mode
    %       settings.verbose
    %   for single mode only: return_model    = boolean of whether to return the FOOOF model fit, optional
    
    % Current outputs (default from fooof_mat)
    %   fooof_results   = fooof model ouputs, in a struct, including:
    %       fooof_results.aperiodic_params
    %       fooof_results.peak_params
    %       fooof_results.gaussian_params
    %       fooof_results.error
    %       fooof_results.r_squared
    %       for single case only: if return_model is true, it also includes:
    %            fooof_results.freqs
    %            fooof_results.power_spectrum
    %            fooof_results.fooofed_spectrum
    %            fooof_results.ap_fit
    
    if nargin < 6 
        settings = struct(); % empty settings      
    end
    
    if strcmpi(mode, 'single')
        % How to extract spectra for a dataset?  (probably by component?)
        fooof_results = fooof(freqs, psd, f_range, settings, 'return_model', true); %default return_model
    elseif strcmpi(mode, 'group')
        fooof_results = fooof_group(freqs, specdata, f_range, settings); %where specdata is an array of spectra
    end
        
    EEG.etc.FOOOF ;
    
    