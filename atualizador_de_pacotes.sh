#!/bin/bash

OPCOES="$(zenity \
	--height=400 \
	--width=300 \
	--title="Atualizador de pacotes" \
	--list \
	--text="Selecione as operações de atualização dos pacotes no sistema operacional" \
	--column="" \
	--column="OPCAO" \
	--column="Operacoes" \
	--checklist TRUE 1 "Atualizar todo o sistema (remove alguns programas obsoletos)" \
	--checklist FALSE 2 "Atualizar o sistema (não remove programas obsoletos)" \
	--checklist TRUE 3 "Limpar cache de pacotes baixados após a atualização" \
	--checklist FALSE 4 "Remover pacotes não utilizados" \
	--checklist TRUE 5 "Reiniciar automaticamente após a atualização" \
	--separator=" " \
	--hide-column="2")" 

zenity \
	--notification \
	--text="Atualizando a lista de repositórios";

# Hora do inicio da atualização
INICIO=$(date +%s);

sudo apt-get update

LISTAREPOSITORIOS="$(zenity \
	--height=350 \
	--width=600 \
	--title="Lista de repositórios /etc/apt/sources_list" \
	--text-info \
	--filename="backup_sources_list.txt" \
	--checkbox="Aceitar configurações" \
	--editable)"

echo "$LISTAREPOSITORIOS" > backup_sources_list.txt;

LISTA_OPCOES=($OPCOES);
CONTADOR=0;

for LETRA in "${LISTA_OPCOES[@]}"
do
	case "$LETRA" in

		1)
			sudo apt-get dist-upgrade
			zenity \
				--notification \
				--text="Atualização completa.";
			;;

		2) 
			sudo apt-get dist-upgrade
			zenity \
				--notification \
				--text="Atualização parcial.";
			;;

		3)
			sudo apt-get clean
			zenity \
				--notification \
				--text="Limpando cache de pacotes.";
			;;

		4)
			sudo apt-get autoremove
			zenity \
				--notification \
				--text="Removendo pacotes não utilizados.";
			;;

		5)
			TERMINO=$(date +%s);
			TEMPO_ATUALIZACAO=$[TERMINO - INICIO];

			zenity \
				--height=100 \
				--width=300 \
				--title="Término da atualização" \
				--question \
				--text="A atualização do sistema levou $TEMPO_ATUALIZACAO segundos \n \n deseja reiniciar o sistema agora(recomendado) ?"

				if [ "$?" = "0" ]
					then
						reboot;
					else
						echo "Processo negado !";
				fi
	esac 
done