% pop_sample() - description of the function. If less than
%                three arguments are given, a window pops up
%                to ask for the value of the additional 
%                parameters.   
%
% Usage:
%   >>  OUTEEG = pop_sample( INEEG, type, param3 );
%
% Inputs:
%   INEEG   - input EEG dataset
%   type    - type of processing. 1 process the raw
%             data and 0 the ICA components.
%   param3  - additional parameter.
%    
% Outputs:
%   OUTEEG  - output dataset
%
% See also:
%   SAMPLE, EEGLAB 

% Copyright (C) <year>  <name of author>
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

function [EEG, com] = pop_sample( EEG, typeproc, param3 );

% the command output is a hidden output that does not have to
% be described in the header

com = ''; % this initialization ensure that the function will return something
          % if the user press the cancel button            

% display help if not enough arguments
% ------------------------------------
if nargin < 2
	help pop_sample;
	return;
end;	

% pop up window
% -------------
if nargin < 3
	promptstr    = { 'Enter the parameter:' };
	inistr       = { '0' };
	result       = inputdlg( promptstr, 'Title of window', 1,  inistr);
	if length( result ) == 0 return; end;

	param3   	 = eval( [ '[' result{1} ']' ] ); % the brackets allow to process matlab arrays
end;

% call function sample either on raw data or ICA data
% ---------------------------------------------------
if typeproc == 1
	sample( EEG.data );
else
	if ~isempty( EEG.icadata )
		sample( EEG.icadata );
	else
		error('You must run ICA first');
	end;	
end;	 

% return the string command
% -------------------------
com = sprintf('pop_sample( %s, %d, [%s] );', inputname(1), typeproc, int2str(param3));

return;
