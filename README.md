# FOOOF for EEGLAB

make sure Matlab's version of Python is on 3.X
- This can be done via `pyversion 3.X` or `pyversion location`

### TODO:
- std_fooof_wrap.m
- pop_fooof_wrap.m
- and one for channel spectra? (as in pop_spectopo.m)
- look into statistics (std_stat.m)

### Relevant repos
- https://github.com/fooof-tools/fooof_mat
- https://github.com/sccn/eeglab/blob/develop/functions/popfunc
- https://github.com/sccn/eeglab/blob/develop/functions/studyfunc
- https://github.com/sccn/eeglab/blob/develop/functions/studyfunc/std_stat.m

Questions:
- What data for we want?  For example in study case with given design, do we want fooof_group on each design (averaged) or 