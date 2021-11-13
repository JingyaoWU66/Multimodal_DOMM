load('E:\0UNSW_PhD\Code\Ordinal_FSMM\RECOLA_revised\pre_trained_matlab\DOMM_function\results\valenceAudio_eGemaps_Video_appearance0_0.16.mat')
names = {"L-L","L-M","L-H","M-L","M-M","M-H","H-L","H-M","H-H"}
figure
for i = 1:9
[a,b] = ksdensity(data_total.new_Tran{i});
subplot(3,3,i)
plot(b,a)
xlim([-200,200])
title(names{i})
end