#!/usr/bin/bash

#if qc_summary_results.txt exists, clear it of its contents
> qc_summary_results.txt

#creating the variable for parent_directory so that we don't have to type a file location multiple times
parent_directory=$HOME/Exercises/MyFirstPipeline/fastq/fastqc_unzipped
echo -e "${parent_directory}"

#creating an output file to put our final results into
output_file="qc_summary_results.txt"
echo -e "${output_file}"

#searching through the folders in the parent directory
#looking at every folder in the parent directory
for folder in ${parent_directory}/*
do

	#check if summary.txt exists in the folder
	summary_file="${folder}/summary.txt"

	#if summary.txt exists, look for the line 'Per base sequence quality' in the file. Consider this a new variable.
	if [ -f ${summary_file} ] 
	then 
		qc_line=$(awk '/Per base sequence quality/ {print $0}' ${summary_file})
		
		#if the qc_line variable exists, then take that entire line and put it in the output file
		if [ -n "${qc_line}" ] 
		then
			echo ${qc_line} >> ${output_file}
		#if the qc_line variable does not exists, print the following error message
		else
			echo -e "Error - unable to find sequences"
		fi
	#if summary.txt does not exist, then print the folliwng error message	
	else
		echo -e "Unable to find anything"
	fi
done

#print the following message
echo "Quality scores extracted and saved to ${output_file}"
	      
