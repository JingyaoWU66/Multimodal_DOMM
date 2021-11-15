# Main Function Description:
In this script, we provide the demo code to reproduce the results reported in the paper. We also provide the labels in RECOLA. 
You need to used your own features to run the code. The feature set should be in the form: 9\*1 cells, with each cell to be 7501\*n double matrix, where n is your feature dimensions.
As an example, the attached figures show the feature structure of the 88-dimensional eGemaps feature set.
![image](https://user-images.githubusercontent.com/92004108/141737543-d5bbc5cf-5a7b-4aff-8df5-9dc09c8f6197.png)
![image](https://user-images.githubusercontent.com/92004108/141737656-bdaecd74-adc2-41ad-ad46-1026d5a839b9.png)


You can test the system with different feature sets and interval-to-AOL-conversion thresholds, for both arousal and valence.
By setting:

emotion = "arousal"; or emotion = "valence";
audio_name = "your audio features";
video_name = "your video features";
thresholds are saved in the variables named: 'sh1' and 'sh2'.

