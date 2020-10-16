function std_fooof_results = std_fooof_wrap(STUDY, ALLEEG, cluster, f_range, settings, return_model, plot_model)
    % Author: The Voytek Lab and Brian Barry 
    % Calls FOOOF wrapper on spectral data from EEGLAB 
    
    % TODO: extract study design to accommodate foof_group()
    % - incorporate statistics 
    % - Decide on what to return
    
    % For fooof related docs see: https://github.com/fooof-tools/fooof_mat/blob/master/fooof_mat/
    
    % For relevant EEGLAB related docs see:
    % - For study: https://github.com/sccn/eeglab/blob/develop/functions/studyfunc/std_specplot.m
    
    % Inputs:
    % EEG, ALLEEG
    % cluster is a range or array of clusters, e.g. 3:14
    %   f_range         = fitting range (Hz)
    %   psds = matrix of power values, which each row representing a spectrum (in single case power_spectrum  = row vector of power values)
    %   settings        = fooof model settings, in a struct, including:
    %       settings.peak_width_limts
    %       settings.max_n_peaks
    %       settings.min_peak_height
    %       settings.peak_threshold
    %       settings.aperiodic_mode
    %       settings.verbose
    %    return_model    = boolean of whether to return the FOOOF model fit, optional
    
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
    addpath('fooof_mat');
    
    if ~exist('settings', 'var')
        settings = struct();
    end

    if ~exist('return_model', 'var')
        return_model = false; % shape needs to be reexamined
    end
    
    plot_model = false; %currently unused
    
    design_var = STUDY.design(STUDY.currentdesign).variable.value; %cell array of design variables
    std_fooof_results = cell([numel(cluster), 1]); 
    
    for c = 1:numel(cluster)
        [STUDY, specdata, freqs] = std_specplot(STUDY,ALLEEG, 'clusters', cluster(c)); 
        
        fooof_results_c = cell([numel(design_var), 1]);
        for v = 1:numel(design_var) 
            results_v = fooof_group(freqs, specdata{v}, f_range, settings, return_model); %specdata at design variable v shape {powers x trials}
            fooof_results_c{v} = results_v;
            % now foof_results is an array of fitting data, each index are fooof results for a condition in the design
        end
        std_fooof_results{c} = fooof_results_c
    end

    

    
        
    
    
    