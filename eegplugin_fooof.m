function eegplugin_fooof(fig,try_strings,catch_strings)
    % keyboard
    
    eeg_fooof_command = [try_strings.no_check '[EEG LASTCOM] = pop_eeg_fooof(EEG);' catch_strings.store_and_hist];
    eeg_fooofplot_command = [try_strings.no_check 'LASTCOM = pop_eeg_fooofplot(EEG);' catch_strings.store_and_hist];

    std_fooof_command = [try_strings.no_check '[STUDY LASTCOM] = pop_std_fooof(STUDY, ALLEEG);' catch_strings.store_and_hist];
    std_fooofplot_command = [try_strings.no_check 'LASTCOM = pop_std_fooofplot(STUDY, ALLEEG);' catch_strings.store_and_hist];
    % tools menu
    tools_menu = findobj(fig, 'tag', 'tools');
    submenu = uimenu(tools_menu, 'Label', 'FOOOF', 'separator', 'on');
    uimenu(submenu, 'label', 'Fit power spectra', 'callback', eeg_fooof_command); 
    uimenu(submenu, 'label', 'Plot fit', 'separator','on', 'callback', eeg_fooofplot_command);
    % study menu
    std_menu = findobj(fig, 'tag', 'study');
    submenu = uimenu(std_menu, 'Label', 'FOOOF', 'separator', 'on');
    uimenu( submenu, 'label', 'Fit power spectra', 'callback', 'userdata', 'startup:off;study:on',std_fooof_command);
    uimenu(submenu, 'label', 'Plot cluster fit', 'separator','on', 'callback', 'userdata', 'startup:off;study:on', std_fooofplot_command);