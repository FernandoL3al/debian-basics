declare -f MEEE
function MEEE(){
    echo "#------------------Instalando o Nala------------------#"
    sudo apt install nala
    echo "#------------------Nala foi instalado-----------------#"
    sleep 2s
}

declare -f BAAA
function BAAA(){
    echo "#------------------Substituindo o Bashrc------------------#"
    sudo cp -rf /tmp/debian-basics/.bashrc ~/
    sudo cp -rf /tmp/debian-basics/.bashrcroot /root/.bashrc        
    source ~/.bashrc
    printf "\e[1;32m#-------------------Bashrc atualizado---------------------#.\e[0m\n"
    sleep 3s
    source /tmp/debian-basics/start.sh
}


MEEE
BAAA

