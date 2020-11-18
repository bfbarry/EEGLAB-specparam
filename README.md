# FOOOF for EEGLAB

make sure Matlab's version of Python is on 3.X
- This can be done via `pyversion 3.X` or `pyversion location`

changes to FOOOF_MAT:
- added a return_model to fooof_group.m but not working 

error:

    Error using plot
    Data must be a single matrix Y or a list of pairs X,Y.

    Error in fooof_plot (line 38)
        data = plot(plt_freqs, fooof_results.power_spectrum, 'black');

### TODO:
- std_fooof_wrap.m
    - working on other fitting options like individual fits to each averaged design variable (fooof not fooof_group)

- pop_fooof_wrap.m
- and one for channel spectra? (as in pop_spectopo.m)
- look into statistics (std_stat.m)

### Relevant repos
- https://github.com/fooof-tools/fooof_mat
- https://github.com/sccn/eeglab/blob/develop/functions/popfunc
- https://github.com/sccn/eeglab/blob/develop/functions/studyfunc
- https://github.com/sccn/eeglab/blob/develop/functions/studyfunc/std_stat.m

If you use this code in your project, please cite:

    Haller M, Donoghue T, Peterson E, Varma P, Sebastian P, Gao R, Noto T, Knight RT, Shestyuk A,
    Voytek B (2018) Parameterizing Neural Power Spectra. bioRxiv, 299859.
    doi: https://doi.org/10.1101/299859
