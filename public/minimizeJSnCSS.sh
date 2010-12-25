if [ $# == 0 ]
then
	echo "Usage: \t$0 file_list output_file"
	echo "Help: \t$0 -h "
	exit 0
elif [ $# == 1 ] && [ $1 == "-h" ]
then
	echo "Usage: \t\t$0 file_list output_file"
	echo "Purpose: \tThis script minimize a list of CSS or JS files uing YUI compressor and appends them in one file."
	echo "Arguments: \tfile_list \t- A plain text file in wich each line represents an input file."
	echo "\t\toutput_file \t- The file that contains all the minimized text present in file_list."
	echo "Notes: \t\t- All file names in the file_list must include extension, either all CSS or all JS."
	echo "\t\t- YUI compressor (yuicompressor-2.4.2.jar) must be in a subdirectory named yuicompressor/build"
elif [ $# == 2 ]
then
	file_list=$1
	output_file=$2
	if [ -f $output_file ]
	then
		rm $output_file
		echo "$output_file already exists, it will be replaced"
	fi
	for input_file in $(cat $file_list)
	do
		if [ -f $input_file ]
		then
			echo "processing $input_file"
			java -jar yuicompressor/build/yuicompressor-2.4.2.jar $input_file >> $output_file
		else
			echo "warning: file $input_file doesn't exits"
		fi
	done
fi
