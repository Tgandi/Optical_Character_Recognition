						SIMPLE TEXT RECOGNITION BASED ON CCA AND NEURAL NETWORKS
						----------------------------------------------------------------------------------------

Files and Folders
-----------------


MyScript.m	-Main code for calling the functions
binarize.m		-Performs binarisation for the image as expected by the functions
align.m		-aligns the text horizontally for the slight change in the angle
MyCanny.m	-Canny edge detector used by the binarize
MyConv.m		-Performs convolution
MyGauss.m	-Generates the gaussian mask for the given sigma and size
predict.m		-Predict the label for the given test data
sortcol.m		-Arranged the components returned by the CCA as the reading order.
bin.m		-Binarise the image (Normal)
thresh.m		-Provides the threshold for binarisation by otsu method
conncomp.m	-Provides the componets in the image by the Connected Component Analysis.
softmax.m		-softmax function used by the predict.m
wv_300.mat	-Dataset containing the weights for neural networks used in predict.m using 300 hidden units
wv_400.mat	-Dataset using 400 hidden units 
wv_500.mat	-Dataset using 500 hidden units	


Dataset		-Folder containg the 
			-Msk 		:folder containg images on which is built 
			-buildata.m 	:the script for building
			-buildata.mat	:dataset containing the dataset builded.
	
Train		-Folder for training the data and building the weights for neural networks
			-MyNN.m 		:main code for calling functions
			-forward pass	:functions that performs forward passing
			-computergradient.m     :grasdient for weights
			-softmax.m		:function softmax
			-chars62.mat	:dataset for training

Analysis	-Folder containing the data analysed while training
			-ts_acc.mat		:test accuracies cross validated for k=10 to analyse
			-it_hid_val.mat	:traing accuracies varying iterations and hidden values



along with the test images.

USE:
-------
To build data use buildata.m in Dataset folder.
To train use MyNN function in Train folder.
To run the main file run MyScript.m function for any image file as argument.

	MyScript('IMAGE_FILE')

and output is displayed to output.txt
	


Group Members:
1.Thipparthy Jagadeesh Chandra
2.Peeru Mahesh Chandra Teja Reddy
3.Pavuluri Jaya Bharath
4.Tharshith Gandi
