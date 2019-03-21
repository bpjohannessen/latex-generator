#!/bin/bash
#
# This bash shell script creates
# a folder with required files
# for LaTeX notes for a course
#
# Bjørn-Petter Johannessen
# bp.johannessen@gmail.com
# Last modified: March 21 2019

# Get input from the user
# $coursename, $courseauthor
# $coursechapters, $coursedate

echo "What is the name of the course?"
read coursename

# Change this if you are not me
if [ $HOSTNAME = "bp-mac.local" ]; then
	courseauthor="Bjørn-Petter Johannessen"
#elif [ $HOSTNAME = "other-computer.lan" ]; then
#	courseauthor="Owner of Computer"
else
	echo "Who is the author of the notes?"
	read courseauthor
fi

echo "How many chapters are you planning?"
read coursechapters

echo "In what time period are they written? (e.g., yyy-mm-dd - yyyy-mm-dd)"
read coursedate

#
# Print what will be created
#

echo -e "The following will be created:\n"
echo "Course name: $coursename"
echo "Course author: $courseauthor"
echo "Number of chapters: $coursechapters"
echo "Time range: $coursedate"

#
# Get confirmation from user
#

echo "Are you sure? (y/n)"
read confirm

#
# Check Y/N from user; N terminates.
#

if [ $confirm != "y" ]

	then
	# Terminate
	echo "Terminating"

else

	# Carry on..
	
	# Create directory for the course,
	# escapes space with dash (// /-)

	# New variables with string replacement
	# are named $variablenameman

	# Variables for file names
	#are named $variablenametex
	
	coursenameman="${coursename// /-}"
	coursenametex="${coursename// /-}".tex

	# Create folder for course and index file
	# Names are the same as $coursename

	mkdir $coursenameman
	cd $coursenameman

	# Create Attachments folder for images, etc
	
	mkdir "Attachments"

	touch $coursenametex
	
	# Add required header (packages, etc and course information)
	# to the index file

	cat ../header.tex > $coursenametex

	echo "\\title{${coursename//&/\&}}" >> $coursenametex
	echo "\\author{${courseauthor//&/\&}}" >> $coursenametex
	echo "\\date{${coursedate//&/\&}}" >> $coursenametex
	echo "\\maketitle" >> $coursenametex
	echo "\\clearpage" >> $coursenametex

	# Make table of contents

	echo "\\tableofcontents" >> $coursenametex

	# Create common tex folder for chapters
	
	mkdir "tex"

	# Ask the user for names for the chapters
	
	i=1
	while [ $i -le $coursechapters ]
	do
	
		# Ask for the name of chapter
		
		echo "What is the name of chapter $i?"
		read chaptername

		# If $chaptername is left blank, name = $i-$coursename

		if [ "$chaptername" = 0 ] ; then chaptername=$i"-"$coursename ; fi

		# Manipulate $chaptername
		
		chapternameman="${chaptername// /-}"
		chapternametex=$chapternameman.tex

		# Print what will be created

		echo "Creating folder: $chapternameman"
		
		# Create folder, change directory,
		# create chapter file and print information
		# about the chapter
		# 
		# Print input{} to index file	
		
		# mkdir $chapternameman
		# cd $chapternameman

		cd "tex"
		
		touch $i"-"$chapternametex

		echo "%!TEX root=../"$coursenametex >> $i"-"$chapternametex
		echo "\\chapter{${chaptername//&/\&}}" >> $i"-"$chapternametex
		echo -e "\\section{}\n\n" >> $i"-"$chapternametex
		echo "\\begin{itemz}" >> $i"-"$chapternametex
		echo -e "\t\item" >> $i"-"$chapternametex
		echo -e "\t\item" >> $i"-"$chapternametex
		echo -e "\t\item" >> $i"-"$chapternametex
		echo -e "\t\item" >> $i"-"$chapternametex
		echo -e "\t\item" >> $i"-"$chapternametex
		echo -e "\t\item" >> $i"-"$chapternametex
		echo "\end{itemz}" >> $i"-"$chapternametex


		echo "\\input{./tex/$i"-"$chapternametex}" >> ../$coursenametex

		# Exit directory

		cd ..

		# Reset $chaptername and $i+1

		chaptername=0
		i=$[i+1]

	
	done		

	# Print end{document}

	echo "\\end{document}" >> $coursenametex

	echo "Creating folder: $coursename"
	cd ..
	open .	
fi