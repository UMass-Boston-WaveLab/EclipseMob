%where to look for files
wavdir = '/Users/physics/Documents/eclipseMob/test data/sample data';
%only look at .wav files
files = dir([wavdir '/*.wav']);

bigchunk=44100*60; %number of samples in one minute

chunk=8192; %number of samples in one chunk


for ii =1:length(files)
   info=audioinfo([wavdir '/' files(ii).name]);
   %will store one averaged fft of length 8192 for each minute-long chunk
   fft_avg = zeros(chunk, floor(info.TotalSamples/bigchunk));
   %cycle through the file minute by minute
   for jj=1:floor(info.TotalSamples/bigchunk)
       %get a minute-long chunk
       [y, rate] = audioread([wavdir '/' files(ii).name],[(jj-1)*bigchunk+1, (jj*bigchunk)]);    
       %average the absolute value of the fft of the small chunks
       fft_avg(:,jj)= fft_averager(y, chunk);
   end
   %plot the fft
   figure;
   %x axis of this plot is for frequency. the frequency step size is 1/(total chunk time)
   %where total chunk time is chunk size * (1/sample rate).
   plot(repmat(((1:(floor(chunk/2)))*rate*0.001/chunk).',1,floor(info.TotalSamples/bigchunk)),20*log10(abs(fft_avg(1:(floor(chunk/2)),:))));
   title(files(ii).name)
   xlabel('Frequency [kHz]')
   ylabel('Amplitude [dB]')
end