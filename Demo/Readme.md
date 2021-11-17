# Main Function Description:
In this script, we provide the demo code to reproduce the results reported in the paper. We also provide the labels in RECOLA. 
 
## Data
- The interval labels can be found in public RECOLA dataset at: https://diuf.unifr.ch/main/diva/recola/download.html
- The interval lalels should be stored in the form with 9\*1 cells, with each cell to be 7501\*7 double matrix, where 7501 is the frame index, and 7 corresponds to time at the  first column; labels from 6 annotators at the rest 6 coloumns. For example, the training and test labels are stored as below:

![image](https://user-images.githubusercontent.com/92004108/142169405-8632693a-505c-4709-85fe-d5535ca3cfc9.png)
![image](https://user-images.githubusercontent.com/92004108/142169468-ae7ab2c9-2652-443f-913a-85d227e84fd2.png)

- The AOL labels will be automatically converted in this implementation with given thresholds, sh1 and sh2.
- You need to convert your own ROL labels according to the paper, and stored in the Demo folder. It will be loaded while running the script.
![image](https://user-images.githubusercontent.com/92004108/142172354-6744de8e-4ea7-4b85-8827-64bf047a8283.png)
- The ROLs should be stored in the form with 9\*n double matrix for 9 utterances and n time index.


- You need to used your own features to run the code. 
- The feature set (for both audio and video single modality features) should be in the form: 9\*1 cells, with each cell to be 7501\*n double matrix, where n is your feature dimensions. The feature level fusion is automatically processed in the code.

As an example, the attached figures show the feature structure of the 88-dimensional eGemaps feature set.
![image](https://user-images.githubusercontent.com/92004108/141737543-d5bbc5cf-5a7b-4aff-8df5-9dc09c8f6197.png)
![image](https://user-images.githubusercontent.com/92004108/141737656-bdaecd74-adc2-41ad-ad46-1026d5a839b9.png)


## Usage:
You can test the system with different feature sets and interval-to-AOL-conversion thresholds, for both arousal and valence.
By setting:

- emotion = "arousal"; or emotion = "valence";
- audio_name = "your audio features";
- video_name = "your video features";
- thresholds are saved in the variables named: 'sh1' and 'sh2'.

