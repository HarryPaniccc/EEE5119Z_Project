function [ vect_out ] = ovs_vect( vect_in, ovs_factor )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N           = length(vect_in);

new_spacing = (vect_in(2) - vect_in(1))/ovs_factor;
vect_out    = linspace(vect_in(1), vect_in(N)+(ovs_factor-1)*new_spacing,ovs_factor.*N);

end

