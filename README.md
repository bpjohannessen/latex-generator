# LaTeX generator

## About
This bash script generates a folder for your course and its chapters. It uses a custom template, and is not suitable for writing scientific articles.

## Usage

**First time:** `chmod +x newcourse.sh`

`./newcourse`

Sample:
```
$ ./newcourse.sh

What is the name of the course?
Test Course
Who is the author of the notes?
Bjørn-Petter Johannessen
How many chapters are you planning?
3
In what time period are they written? (e.g., yyy-mm-dd - yyyy-mm-dd)
2019
The following will be created:

Course name: Test Course
Course author: Bjørn-Petter Johannessen
Number of chapters: 3
Time range: 2019
Are you sure? (y/n)
y  
What is the name of chapter 1?
Introduction
Creating folder: Introduction
What is the name of chapter 2?
Research
Creating folder: Research
What is the name of chapter 3?
Results
Creating folder: Results
Creating folder: Test Course
```