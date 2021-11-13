clear all;close all
load('..Multimodal_DOMM\Demo\RECOLAR_all.mat');
load('..Multimodal_DOMM\Demo\video_appearance.mat')
%%
emotion = "valence"
%audio_name = "BoAW_pca"
audio_name = "eGemaps"
%video_name = "appearance"
%video_name = "ResNet50";
video_name = "Geometric"
if emotion == "arousal"
    label.train = arousal_train;
    label.test = arousal_dev;
    sh1 = -0.14;
    sh2 = 0.14
else
    label.train = val_train;
    label.test = val_dev;
    sh1 = 0;
    sh2 = 0.17;
end


window_index = 50;
overlap = 50;
if audio_name == "BoAW_pca"
    audio.train_features = train_feature;
    audio.test_features = test_feature;
else
    audio.train_features = AVEC2016_train_Audio;
    audio.test_features = AVEC2016_dev_Audio;
end
if video_name == "appearance"
    video.train_features = AVEC2015_EDA_train;
    video.test_features = AVEC2015_EDA_dev;
elseif video_name == "Geometric"
    video.train_features = AVEC2015_GEO_train;
    video.test_features = AVEC2015_GEO_dev;
else
    for u = 1:9
        feature_visual.train{u} = double(feature_visual.train{u});
        feature_visual.dev{u} = double(feature_visual.dev{u});
    end
    video.train_features = feature_visual.train;
    video.test_features = feature_visual.dev;
end

%%
[DOMM_pred,DOMM_RS_UAR,DOMM_RS_wkappa] = my_DOMM_multimodal(window_index,overlap,sh1,sh2,audio,video,label,audio_name,video_name,emotion)
