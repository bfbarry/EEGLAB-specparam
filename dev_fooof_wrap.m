function dev_fooof_results = dev_fooof_wrap(cluster, f_range, settings, return_model, plot_model)
    % For testing matlab FOOOF with external data

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
    
    for c = 1:numel(cluster)
        load(strcat('~/Desktop/IversenLab/fooof_tests/dip_only/brian_diponly_',int2str(cluster(c)),'_spectra.mat'));
        
        fooof_results_c = cell([numel(design_var), 1]);
        for v = 1:numel(design_var) 
            results_v = fooof_group(specfreqs, specdata{v}, f_range, settings, return_model); %specdata at design variable v shape {powers x trials}
            fooof_results_c{v} = results_v;
            % now foof_results is an array of fitting data, each index are fooof results for a condition in the design
        end
        dev_fooof_results{c} = fooof_results_c;
    end