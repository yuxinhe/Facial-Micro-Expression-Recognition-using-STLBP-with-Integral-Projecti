clear all;close all;clc;
%% getlabel happiness=0£¬disgust=1£¬surprise=2£¬repression=3£¬others=4
xlsfile = 'F:\database\CASME2\CASME2-coding-20140508.xlsx'
label = getlabel(xlsfile)
save('CASME2_label','label');