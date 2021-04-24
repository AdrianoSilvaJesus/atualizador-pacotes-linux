#!/bin/bash
#
# Autor: Adriano Oliveira de Jesus
# GitHub: https://github.com/AdrianoSilvaJesus/atualizador-pacotes-linux
# E-mail: adrianosilvaoliveiradejesus@outlook.com
# Criado: 20/04/2021
# Atualizado: 24/04/2021
#
# Este programa foi criado para manipular pacotes do sistema operacional linux em diferentes modalidades (atualização, busca, instalação, remoção).

# Checa se o diretório de preferências do programa foi criado em /etc. Senão o cria.
# Precisa-se de permissão de admnistrador para funcionar.
if ! [ -d "/etc/manipular-pacote" ]
then
	echo "Diretório ainda não foi criado.";
	mkdir /etc/manipulador-pacotes;
	echo "Diretório criado."
fi

pesquisar () {
	echo "Pesquisando pacote.";

	# Programa que deve ser pesquisado
	PROGRAMA_PESQUISAR="$(zenity \
	--height=100 \
	--width=100 \
	--title="Pesquisar" \
	--text="Buscar programa" \
	--entry)"

	# Lista com os programas retornados da busca
	LISTA_PROGRAMAS="$(apt-cache search "$PROGRAMA_PESQUISAR")";

	if [ -z "$LISTA_PROGRAMAS" ]
	then
		zenity \
		--height=50 \
		--width=400 \
		--warning \
		--text="Nenhum programa que correspondesse à busca foi encontrado.";

		kill "$$";
	fi


	
}

# Interface inicial de opções
OPCAO="$(zenity \
	--height=100 \
	--width=300 \
	--title="Manipulador de pacotes" \
	--forms \
	--add-combo="Operaçoẽs no sistema" \
	--combo-values="Atualizar sistema|Pesquisar pacote|Instalar pacote|Remover pacote")"  

echo "$OPCAO";

case "$OPCAO" in
	"Atualizar sistema")
		echo "Atualizar o sistema operacional.";
	;;

	"Pesquisar pacote")
		pesquisar
	;;

	"Instalar pacote")
		echo "Instalando pacote";
	;;

	"Remover pacote")
		echo "Remover pacote";
	;;
esac