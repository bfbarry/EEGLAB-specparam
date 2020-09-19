function fooof_results = fooof_wrap(data, ALLEEG, cluster, design, f_range, mode, settings)
    % Author: The Voytek Lab and Brian Barry 
    % Calls FOOOF wrapper on spectral data from EEGLAB
    
    % TODO: extract study design to accommodate foof_group()
    % - incorporate statistics 
    % Decide on what to return
    % implement pop_ and std_ functions for GUI and plotting
    
    % For fooof related docs see: https://github.com/fooof-tools/fooof_mat/blob/master/fooof_mat/
    
    % For relevant EEGLAB related docs see:
    % - For study: https://github.com/sccn/eeglab/blob/develop/functions/studyfunc/std_specplot.m
    
    % Inputs:
    % data is either EEG or STUDY (unless a std_fooof_wrap.m is created)
    % cluster = cluster # for study
    % design = design #
    % if mode = 'single', runs fooof.m 
    % if mode = 'group', runs fooof_group.m (once again unless a std_fooof_wrap.m is created)
    %   f_range         = fitting range (Hz)
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
    
    if nargin < 7 % need a better way to check because design may be empty too
        settings = struct(); % empty settings      
    end
    
    if lower(mode) == 'single'
        % How to extract spectra for a dataset?  (probably by component?)
        fooof_results = fooof(freqs, psd, f_range, settings, 'return_model', true);
    elseif lower(mode) == 'group' 
        STUDY, specdata, freqs = std_specplot(STUDY,ALLEEG, 'clusters', cluster); 
        design = STUDY.design(design).variable
        % need to decide on shape of specdata from study design 
        fooof_results = zeros(size(design)(2))
        for i = 1:size(design)(2) % for now assumes design is a 1xn array of conditions
            temp_results = fooof_group(freqs, specdata, f_range, settings); %where specdata is an array of spectra
            fooof_results = [fooof_results, temp_results]
            % now foof_results is an array of fitting data, each index are fooof results for a condition in the design
        end
        
    end
        
    
    
    