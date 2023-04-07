
#--Função: Atualiar sistema (base Debian)--#
declare -f ATUALIZAR
function ATUALIZAR(){
			echo "#-----------------------------Atualizar Sistema------------------------------#"
				sudo apt update &&
			echo "#-------------------------Repositórios Atualizados---------------------------#"
			sleep 1s
				sudo apt upgrade -y &&
			echo "#---------------------------Programas Atualizados----------------------------#"
			sleep 2s
			KSUPERKEY
		}
	

#--Função: Base Debian - Instalar ksuperkey (possibilidata chamar o Rofi com a tecla super)--#
declare -f KSUPERKEY
function KSUPERKEY()
	{
			echo "#----------------------------Habilitar ksuperkey-----------------------------#"
			sudo apt install gcc make libx11-dev libxtst-dev pkg-config -y
			cd /tmp && git clone https://github.com/hanschen/ksuperkey.git
			cd ksuperkey
			make
			sudo make install &&
			clear &&
			echo "#---------------------------Ksuperkey habilitado-----------------------------#"
				sleep 2s
            PERSONA
	}



	
#--Função: Usar personalizações para: fonts, configs, ícones, themas, polybar, dunst e rofi--#
declare -f PERSONA
function PERSONA()
	{
			echo "#----------------Copiar personalizações (ícones, themas, fonts)--------------#"
				sudo cp -r /tmp/debian-basics/fonts/* /usr/share/fonts
				cp -rf /tmp/debian-basics/home/config/* ~/.config
				cp -rf /tmp/debian-basics/home/.gtkrc-2.0 $HOME
				
		
				# Copiar temas
				cd /tmp && git clone https://github.com/archcraft-os/archcraft-themes && chmod 755 archcraft-themes/* -R
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-adapta/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-arc/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-blade/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-cyberpunk/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-dracula/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-groot/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-gruvbox/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-hack/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-juno/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-kripton/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-manhattan/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-nordic/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-rick/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-spark/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-sweet/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-wave/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-white/files/* /usr/share/themes
				sudo cp -rf /tmp/archcraft-themes/archcraft-gtk-theme-windows/files/* /usr/share/themes
					
				# Copiar Icones do sistema
				cd /tmp && git clone https://github.com/archcraft-os/archcraft-icons && chmod 755 archcraft-icons/* -R
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-arc/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-breeze/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-hack/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-luna/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-luv/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-nordic/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-numix/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-papirus/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-qogir/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-white/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-win11/files/* /usr/share/icons
				sudo cp -rf /tmp/archcraft-icons/archcraft-icons-zafiro/files/* /usr/share/icons &&
			clear &&
			echo "#---------------------Personalizações padrões copiadas-----------------------#"
            PERSONA_DEBIAN
	}
	


	
#--Função: Personalização específica para Debian xfce--#
declare -f PERSONA_DEBIAN
function PERSONA_DEBIAN()
	{
			clear
			echo "#---------------------Copiar personalizações para Debian---------------------#"
				cp -rf /tmp/debian-basics/home/debian/.fehbg $HOME
				cp -rf /tmp/debian-basics/home/xubuntu/Thunar/ ~/.config
				cp -rf /tmp/debian-basics/home/xubuntu/sxhkd/ ~/.config
				mkdir ~/.config/neofetch
				cp -rf /tmp/debian-basics/home/debian/config.conf ~/.config/neofetch
				cp -rf /tmp/debian-basics/home/xubuntu/powermenu ~/.config/bspwm/rofi/bin
				cp -rf /tmp/debian-basics/home/debian/powermenu.rasi ~/.config/bspwm/rofi/themes
				sudo cp -rf /tmp/debian-basics/home/debian/nordico.png /usr/share/images/desktop-base/
				sudo cp -rf /tmp/debian-basics/home/debian/lightdm-gtk-greeter.conf /etc/lightdm/ &&
			clear &&
			echo "#--------------------Personalizações para Debian copiadas--------------------#"
				sleep 3s
			clear
			NOTF_SUCESS
	}



#--Função: Notificar sucesso na operação--#
declare -f NOTF_SUCESS
function NOTF_SUCESS()
	{
		echo "Sucesso na instalação. Para que tudo funcione corretamente, é recomendável que reinicie seu micro."
        sleep 2
	}
		
##--------------------------------Funções utilizadas no script--------------------------------##
	clear
		echo "#---------------Esse assistente instalará bspwm em sua máquina---------------#"
	ATUALIZAR