function y = sinc_function(x)  		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE
%    Calculates the sinc function
%
% INPUT
%    x                  Vector
%                       Value
%
% OUTPUT
%    y                  Vector
%                       Sinc function
%
% REVISION
%    Version |   Date     |   Author          | 
%    V1.0    | 10-07-2009 | D. Cerutti-Maori  |  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


aux     = find(x~=0);
y       = ones(size(x));
y(aux)  = sin(x(aux))./x(aux);
