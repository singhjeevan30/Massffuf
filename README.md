# Massffuf
A wrapper around ffuf.
This script allows you to run ffuf on multiple urls with the same dictionary file.
Not only that, it then saves the output in clear, easily readible text file removing all the false positives and unwanted paths given by ffuf.
It's usage is very simple.

---

## Requirements:
Kindly install ffuf first from **https://github.com/ffuf/ffuf** 

---

## Installation:
git clone https://github.com/singhjeevan30/Massffuf/  
cd Massffuf  
chmod +x massffuf.sh  

---

## Usage:

### ./massffuf.sh [folder-name] [dictionary-file] [output-file]

folder-name:       name of the folder where PROBEDURLS-httprobe.txt is located  
dictionary-file:   dictionary file used for fuzzing paths  
output-file:       name of the output file  
