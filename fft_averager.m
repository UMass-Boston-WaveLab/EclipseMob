function [ cfft ] = fft_averager(y, chunksize)

cfft=zeros(chunksize,1);
   for jj=1:floor(length(y)/chunksize)
       cfft=cfft+abs(fft(y((1:chunksize)+(jj-1)*chunksize)))/(floor(length(y)/chunksize)); %average fft of many chunks
   end
end

