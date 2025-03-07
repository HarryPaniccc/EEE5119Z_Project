function y = hamming_window(N)  		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE
%    Hamming window
%
% INPUT
%    N                  Scalar
%                       Number of samples
%
% OUTPUT
%    y                  Vector
%                       Hamming window
%
% REVISION
%    Version |   Date     |   Author          | 
%    V1.0    | 10-07-2009 | D. Cerutti-Maori  |  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


y  = 0.54-0.46*cos(2*pi*(0:N)/(N-1));

