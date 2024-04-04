#!/bin/bash
#summarize_trf
#this script summarizes the output of TRF into a format to be used for an R script
#input: TRF output .dat file
#output: .dat.sum file

#f = output .dat file from running trf on a genome fasta
while getopts f: option;do
    case $option in
	f) file=$OPTARG;;
    esac
done


#specify name of output file for this script
outfile=$(echo $file".sum")
touch $outfile


#print the sequence that a repeat was found on, the start and end of the repeat array, and the size of repeat monomers
while read line
do
    if [[ ${line:0:1} == "@" ]]
    then
	seq=$(echo $line | sed 's/@//')
    else
	if [[ $line =~ ^[0-9] ]]
	then
	    start=$(echo $line | sed 's/ .*//')
	    end=$(echo $line | sed "s/$start //" | sed 's/ .*//')
	    unit=$(echo $line | sed "s/$start //" | sed "s/$end //" | sed 's/ .*//')
	    echo $seq" "$start" "$end" "$unit >> $outfile
	fi
    fi
done < $file


exit 0
