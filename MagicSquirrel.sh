
#! /bin/bash
 
## coded by Gabriel Berrios aka userHonest

clear


echo "- - - - - - - - - - - - - - - - - - - - - "

####### FUNCTIONS FROM  TOP AND DOWN ##########

function Encryption () { 

while true 
do
echo ""
echo "E N C R Y P T "
echo "- - - - - - - - -  "
echo ""
local PS3="Select Option: "
local options=("Encrypt" "Decrypt" "Go back to Main")
local optionSubMenu
echo ""
	select optionSubMenu in "${options[@]}"
	do
		case $optionSubMenu in
			
			"Encrypt")
				encSubMenu; break
				;;

			"Decrypt")
				decSubMenu; break
				;;

			"Go back to Main")
				return
				;;

			*) echo "Invalid Option $REPLY" ;;
		esac

done
done

}

function encSubMenu () {

while true; 
do
	echo ""
	
local PS3="Select Option"
local optionsEnc=("Make a file" "Encrypt" "Back")
local optionSubMenuEnc
echo "- - - - - - - - -"
	select  optionSubMenuEnc in "${optionsEnc[@]}"
	do
		case $optionSubMenuEnc in
			"Make a file")
				echo""
				echo "Create a Textfile"
				echo ""
				echo "What do you wish to write in the textfile?"
				read name
				echo ""
				echo "$name" >> output.txt
				echo ""
				echo "Textfile was created in directory "
				break
				;;

			"Encrypt")
				echo ""
				echo "Encrypt the file you just created with OpenSSL"
				echo ""
				echo "Choose encryption"
				read encryption
				echo ""
				echo "Add another switch!example: salt"
				read switch
				echo ""
				echo "Enter file name created in dir"
				read fileName
				echo ""
				echo "Add an enc extension exmample: file.txt.enc"
				read EncExtension
				echo ""
				echo "Add password"
				echo ""
				read passw
				echo
				read statement
				estatement=`openssl enc $encryption $switch -in $fileName -out $EncExtension -k "$passw"`
				echo ""
				echo "- - - - - - - - -"
				echo "Press nr (3) to go back to submenu"
				echo ""
				;;
			   "Back")
				echo "Go back"
				return ;;

			*) echo "Invalid option $REPLY";;

		esac
	done
done

 }


function decSubMenu () { 

while true;
do
echo ""
local PS3="Select Option"
local optionDec=("Decrypt" "Decrypt with more switches" "Back")
local optionSubMenuDec
echo "- - - - - - - - -"
	select optionSubMenuDec in "${optionDec[@]}"
	do

		case $optionSubMenuDec in
			"Decrypt")
 				echo ""
				echo "Decrypt a file with Open SSL"
				echo ""
				echo "Choose cipher command"
				read encryption
				echo ""
				echo "Add encrypted file from directory,example: file.txt.enc"
				read fileName
				echo ""
				echo "Add name to decrypted textfile,its to be stored in your directory, example:file.d.txt"
				read outName
				echo ""
				echo "Add password"
				read passw
				echo ""
				read estatement
				estatement=`openssl enc $encryption -d -in $fileName -out $outName -k "$passw"`
				echo ""
				echo "- - - - - - - - -"
				echo "Press nr (3) to go back to Submenu"
				echo ""

				;;

			"Decrypt with more switches")
				echo ""
				echo "Add an extra switch to your OpenSSL decryption"
				echo ""
				echo "Choose cipher command"
				read cipher
				echo ""
				echo "Add encrypted file from directory,example: file.txt.enc"
				read fileNameDec
				echo ""
				echo "Add name to textfile that is going to be decrypted,its to be stored in your directory example:file.d.txt"
				read outNameDec
				echo ""
				echo "Add switch example: -base64"
				read extraSwitch
				echo ""
				echo "Add password"
				read passwr
				echo
				read eStatement
				eStatement=`openssl enc $cipher -d -in $fileNameDec -out $outNameDec $extraSwitch -k "$passwr"`
				echo ""
				echo "- - - - - - - - -"
				echo "Press nr (3) to go to Submenu"
				echo ""
				;;

			"Back")
				echo "Go back"
				return ;;

				*) "Invalid option $REPLY ";;



		esac
	done
done
}


## function bruteforcing a opensll encrypted file ##

function Bruteforce () {
	echo ""
	echo "B R U T E F O R C E "
	echo "- - - - - - - - -"
	echo "Important !"
	echo "The file you are bruteforing is encrypted with Openssl and has a max of 4 digit password"
	echo ""
	echo "Insert Cypher commands"
	read cypher
	echo ""
	echo "Insert file to Bruteforce"
	read fileName
	echo ""
	echo "Insert Digest Command"
	read dgstCmd
	echo ""
	echo "Insert other Digest Command and it may not need the - before"
	read dgstCmndTwo
	echo ""
	echo "Press Enter to Run"


## This part is an upgraded version of a bruteforce script that lest you choose the switch
for i in {0000..9999}
do

echo "Testing $i "

if
openssl enc $cypher -d -in ./$fileName -out ./decryptedFile.d.txt -k $i $dgstCmd $dgstCmndTwo 2>/dev/null; then
openssl enc $cypher -d -in ./$fileName -out ./decryptedFile$i.d.txt -k $i $dgstCmd $dgstCmndTwo 2>/dev/null

## This logic was assembled by participation of other students from Kristiania
file -i ./decryptedFile$i.d.txt > result$i.txt

	if ! grep "iso" ./result$i.txt > /dev/null; then

		rm ./decryptedFile$i.d.txt
		rm ./result$i.txt

	elif grep "iso" ./result$i.txt > /dev/null; then

	echo "- - - - - - - - - - - - - - - - - - - "
	echo ""
	echo "          Password is: $i"
	echo ""
	echo "Textfile is saved in current directory"
	echo ""
	echo "- - - - - - - - - - - - - - - - - - - "

		rm ./decryptedFile.d.txt

return

		fi
	fi


done


}



## function to encode a text file to base64 ##

function Base64 () { 

while true;
do
echo ""
echo "B A S E  64"
echo "- - - - - - - - -"
local PS3="Select Option: "
local options=("Encode" "Decode" "Go back to Main")

	select opt in "${options[@]}"
do

	case $opt in

		"Encode")
			echo ""
			echo "- - - - - - - - -"
			echo ""
			echo "Write text you wish to encode"
			echo ""
			read text
			etext=`echo -n $text | base64`
			echo ""
			echo "Encoded text is: $etext"
			echo ""
			echo "Paste the encoded text!"
			echo ""
			echo "- - - - - - - - -"
			echo "Press nr (3) to go back to Main"
			;;

		"Decode")
			echo ""
			echo "- - - - - - - - -"
			echo "Paste the text what is encoded in base64"
			echo ""
			read text
			etext=`echo $text | base64 -d`
			echo ""
			echo "Decoded text is: $etext"
			echo ""
			echo "- - - - - - - - -"
			echo "Press nr (3) to go back to Main"
			;;

		"Go back to Main")

			return
			;;

		*) echo "Invalid option $REPLY";;

		esac

	done
done
}



## function password ###


function Password () { 

while true;
do
echo ""
echo "P A S S W O R D   G E N E R A T O R "
echo "- - - - - - - - - - - - - - - - -"
local PS3="Enter your choice: "
local options=("Generate password" "Go back to Main")

	select opt in "${options[@]}"
do

	case $opt in

		"Generate password")
			echo "- - - - - - - - -"
			echo ""
			echo "Generate a few passwords with random characters"
			echo ""
			echo "How many characters?: "
			read passwLengt
			echo ""
			echo "How many passwords do you want?: "
			echo ""
			read numLenght

		## for loop that gives the option to generate certain amoun of listed passwords

			for i in $(seq 1 $numLengt);
			do
			openssl rand -hex 48 | cut -c1-$passwLengt
			done

			echo ""
			echo "Password length is important and safe!"
			echo ""
			echo "- - - - - - - - -"
			echo "Press nr (2) to go back to Main"
			;;

		"Go back to Main")
			return
			;;

		*)echo "Invalid option $REPLY";;

		esac
	done
done
}



## function for generating a hash with OpenSSL commands ##

function Hash () {

while true;
do
echo ""
echo "H A S H   A   T E X T "
echo "- - - - - - - - - - "
local PS3="Select Options"
local optionsHash=("Make a file" "Generate Hash" "Go back to Main")
local optionHashMenu

		select optionHashMenu in "${optionsHash[@]}"
		do

			case $optionHashMenu in 

			"Make a file")
				echo "- - - - - - - - -"
				echo ""
				echo "Create a textfile"
				echo ""
				echo "What do you wish to write in the textfile"
				read input
				echo ""
				echo "$input" >> hashFile.txt
				echo ""
				echo "Textfile was created in your directory"
				;;
			"Generate Hash")
				echo "- - - - - - - - -"
				echo ""
				echo "Generate a hash"
				echo ""
				echo "Select dgst command example: -sha256"
				read dgstCmnd
				echo ""
				read hash
				ehash=`openssl dgst $dgstCmnd -out hashFile.txt.hash hashFile.txt`
				echo ""
                                echo "Command: $ehash"
				cat hashFile.txt.hash
				echo ""
				echo "Textfile is hashed and added in your directory"
				echo ""
				echo "Press nr (3) to go back to Main"
				echo "- - - - - - - - -"

				;;

			"Go back to Main")
				echo "Going back to Main"
				return ;;

			*) echo "Invalid option $REPLY";;

			esac
		done
done
}

function Exit () {
echo ""
echo "Exiting program..."
}
#### Main Menu ###


while true; do

echo ""
echo " M A G I C    S Q U I R R E L"
echo "- - - - - - - - - - - - -"
echo ""
options=("Encryption" "Bruteforce" "Base64" "Password" "Hash" "Exit")
	echo "- - - - - - - - - "
	echo ""
	echo "  Select Options"
	echo ""
	select opt in "${options[@]}" ; do
		case $REPLY in
			1)Encryption; break ;;
			2)Bruteforce; break ;;
			3)Base64; break ;;
			4)Password; break ;;
			5)Hash; break ;;
			6)Exit; break 2 ;;
			*)echo "Wrong input" >&2
		esac
	done
		echo "Exit Program?"

	select opt in "Yes" "No"; do
		case $REPLY in
			1) break 2 ;;
			2) break ;;
			*) echo "Wrong input" >&2
			
		esac
	done
done

exit 0





