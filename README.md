# Massffuf
A wrapper around ffuf.
This script allows you to run ffuf on multiple urls with the same dictionary file.
Not only that, it then saves the output in clear, easily readible text file removing all the false positives and unwanted paths given by ffuf.
It's usage is very simple.

## Usage:

###./massffuf.sh [folder-name] [dictionary-file] [output-file]

1. folder-name:       name of the folder where PROBEDURLS-httprobe.txt is located
2. dictionary-file:   dictionary file used for fuzzing paths
3. output-file:       name of the output file
