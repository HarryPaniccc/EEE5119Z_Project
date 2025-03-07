function y = rect_function(t, t0, T)  		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE
%    Calculates the rect function
%
% INPUT
%    t                  Vector
%                       Time
%    t0                 Scalar
%                       Time shift
%    T                  Scalar
%                       Duration
%
% OUTPUT
%    y                  Vector
%                       Rect function
%
% REVISION
%    Version |   Date     |   Author          | 
%    V1.0    | 10-07-2009 | D. Cerutti-Maori  |  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


y       = zeros(length(t),1);
aux     = find(abs(t-t0)<=T/2);
y(aux)  = 1;


