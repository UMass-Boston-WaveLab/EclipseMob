% SA - Spectrum Analyzer for EclipseMob Project
%==========================================================================
%                         ---> SA.m <---
%--------------------------------------------------------------------------
%       PROGRAMMER:     Kevin Keegan (based on Glenn Meurer's DSA code)
%       DATE:           27 June 2016
%       UPDATE:         
%--------------------------------------------------------------------------
%       DESCRIPTION:    Reads in audio from a line in device,
%                       generates a spectrum analysis that refreshes 
%                       at the rate given to the program.
%--------------------------------------------------------------------------
%       USAGE:          DSA
%--------------------------------------------------------------------------
%       INPUTS:         refresh_rate
%       OUTPUTS:        spectrum analysis
%       FORMULA:        none
%                       
%       CALLS:          
%==========================================================================
%
% set up and static parameters (could be read in on command line)

Fs            =  48000;
prompt        =  'Refresh rate?';
refresh_rate  =  input(prompt);
recorder      =  audiorecorder(Fs, 8, 1, 2);
analyzer      =  dsp.SpectrumAnalyzer('SampleRate', Fs, 'PlotAsTwoSidedSpectrum',...
                 false, 'FrequencySpan', 'Start and stop frequencies', 'StartFrequency',...
                 0, 'StopFrequency', Fs/2, 'SpectralAverages',100);

% records an audiosample, plots the spectrum analysis.

recordblocking(recorder, refresh_rate);
y = getaudiodata(recorder);
step(analyzer,y)

% loops the recording and plotting until you hit ctrl+c.

n = 1;
while n == 1;
    release(analyzer);
    recordblocking(recorder, refresh_rate);
    y = getaudiodata(recorder);
    step(analyzer, y)
end

