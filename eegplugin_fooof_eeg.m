function eegplugin_fooof_eeg(fig,try_strings,catch_strings)
    % tools menu
    tools_menu = findobj(fig, 'tag', 'tools');
    submenu = uimenu(tools_menu, 'Label', 'FOOOF', 'separator', 'on');
    uimenu(submenu, 'label', 'Fit power spectra', 'callback', 'pop_fooof_eeg;');
    uimenu(submenu, 'label', 'Plot fit', 'separator','on', 'callback', 'pop_fooofplot;');
    % study menu
    std_menu = findobj(fig, 'tag', 'study');
    submenu = uimenu(std_menu, 'Label', 'FOOOF', 'separator', 'on');
    uimenu( submenu, 'label', 'Fit power spectra', 'callback', 'pop_std_fooof_eeg');
    uimenu(submenu, 'label', 'Plot cluster fit', 'separator','on', 'callback', 'pop_std_fooofplot;');


