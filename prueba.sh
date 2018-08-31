

lista=$(lsusb|awk '{ print $6 }')
nombre=lista=$(lsusb|awk '{ print $7 }')

whitelist=/bin/texto.txt
blacklist=/bin/lista.txt

for dispositivo in $lista; do
	
	cadena="$(grep -x $dispositivo $whitelist)"
	cadena2="$(grep -x $dispositivo $blacklist)"

	if [ "$dispositivo" == "$cadena" ]
	then
		echo "match"

	elif [ "$dispositivo" == "$cadena2" ]; 
	then
		echo -e "USB ($nombre) detectada en lista negra, no se va a montar"
	else
		#statements
		echo "no match"
		echo -e "Ha ingresado la USB $nombre, es de confianza? ingrese s en caso de afirmativo"
		read usb
		
		if [[ "$usb" == "s" ]]; then
			echo "$dispositivo" >> /bin/texto.txt
		else 
			echo "$dispositivo" >> /bin/lista.txt
		fi

	fi
	#touch $whitelist >> $dispositivo
done


#volumen log volumen fisico
