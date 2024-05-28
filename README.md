# ChatGPT-RCE
This project seeks to demonstrate the capabilities of ChatGPT, and to educate on the potiential dangers that the misuse of large language models can pose. 

DISCLAIMER:

ALL ITEMS IN THIS PROJECT ARE PROVIDED FOR EDUCATIONAL PURPOSES ONLY! I am in NO way responsible for harm caused by the misuse, exploitation, or the use of this project for malicious purposes. 
DISTRIBUTING MALWARE INTENTIONALLY IS ILLEGAL!! This code can be used for malicious purposes, and can cause damage to computer systems. USE AT YOUR OWN RISK!


Methodology:

All code in this project is written COMPLETELY by ChatGPT, and no editing is made by me directly, only by asking ChatGPT to change it. The malware is initated with the .cmd file, which downloads the server.py file, and moves it to C:\Users\User\Onedrive\Documents\ any random existing folder. It also creates five copies which are placed at random locations on the computer. The script also writes their locations in a .txt file on the user's desktop, for the purposes of this project. Each of these copies and the original are set to hidden, and shortcuts for each of these are placed in the startup folder. Additionally, task scheduler entries are placed to restart the programs if they are closed (via task manager, or other means). This results in six server.py instances running at the same time.
