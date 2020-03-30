function seq = lfsrSeq(taps,initSeq,samps)
%{
Returns the sequence generated by the linear feedback shift register with
the given taps and initial memory values.

Inputs:
    taps    : (k, ) k tap weights. [g1,...,gk]
    initSeq : (m, ) m binary values representing the initial memory
              contents. m is the largest value in taps
    samps   : (1, ) How many sequence values to generate

Outputs: 
    seq     : (samps, ) Output sequence of lfsr
%}

m = max(taps);     %Length of LFSR
imTaps = [mink(taps,length(taps)-1),0] + 1;

if(length(initSeq) ~= m)
    error('Make sure initial sequence is the correct size')
end

seq = nan(1,samps);

%Initialize LFSR
curr = initSeq;
next = initSeq;

for ii = 1:samps
    curr = next;    
    
    %Store output
    seq(ii) = curr(1);
    
    %Update taps
    next(1:(m-1)) = curr(2:m);
    next(m) = mod(sum(curr(imTaps)),2);
end
    
