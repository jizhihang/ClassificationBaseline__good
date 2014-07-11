function [ same ] = CompareLabelName(a,b )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

same = 1;

for i = 1: size(a,1)
    if (~strcmp(a(i),b(i)))
        same = 0;
        break;
    end
end

