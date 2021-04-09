function dev_fooof_results = dev_fooof_eeg(cluster, f_range, settings, return_model, plot_model)
    % For testing matlab FOOOF with external data
    % paste this for quick command line loading: load('~/Desktop/IversenLab/external/data/spectra/dip_only/brian_diponly_3_spectra.mat')

    addpath('fooof_mat');
    if ~exist('settings', 'var')
        settings = struct();
    end

    if ~exist('return_model', 'var')
        return_model = false; % shape needs to be reexamined
    end
    
    if ~exist('plot_model', 'var')
        plot_model = false; % shape needs to be reexamined
    end
    
    design_var = {'press Left', 'press Right',    'tap Left' ,   'tap Right'};
    dev_fooof_results = cell([numel(cluster), 1]); 
    

    for c = cluster
        load(strcat('~/Desktop/IversenLab/fooof_tests/dip_only/brian_diponly_',int2str(cluster(c)),'_spectra.mat'));
        
        if strcmpi(fit_mode, 'group')
            fooof_results_c = cell([numel(design_var), 1]); %fooof results for a particular cluster, arranged by design variable
            for v = 1:numel(design_var) 
                results_v = fooof_group(specfreqs, specdata{v}, f_range, settings, return_model); %specdata at design variable v, shape {powers x trials}
                fooof_results_c{v} = results_v;
            end
            dev_fooof_results{c} = fooof_results_c;

        elseif strcmpi(fit_mode, 'across design')
            design_spec = cell([numel(design_var), 1]); %this is what you see when you plot spectrum for a cluster in EEGLAB
            for v = 1:numel(design_var)
                spec_mean = mean(specdata{v}, 2); 
                design_spec{v} = spec_mean; 
            end
            fooof_results_c = fooof_group(specfreqs, horzcat(design_spec{:}), f_range, settings, return_model); %horzcat makes designspec dims |psds| x #design variables
            dev_fooof_results{c} = fooof_results_c;

        end
    end