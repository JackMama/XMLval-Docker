Validation d'un fichier XML sous Docker
========================================

Le but de cette manipulation est de valider un fichier xml et le fichier xsd associé
grace à l'utilisation d'un programme *libxml2-utils* installé dans un container de docker.  


##Déroulement de la réalisation

1 - Installation de Docker sur une machine linux de l'école  
* sudo apt-get install docker.io

2- Installation d'une image  
* sudo pull debian
 
3-Configuration du proxy vu que j'ai travaillé depuis l'école.  
* cd etc/apt/apt.conf.d/  
* vim proxy.conf  
* http::proxy "http://10.0.4.2:3128/"
 
4- Mise à jour des paquets de debian + installation de *libxml2-utils* dans le docker  
* apt-get update  
* apt-get install libxml2-utiles

5-Création des fichiers annuaire.xml et annuaire.xsd dans mon container 

6- Test de la validation des fichiers annuaire.xml et annuaire.xsd à l'intérieur du container (en guise de test) grace à la commande  
* xmllint --noout annuaire.xml --schema annuaire.xsd'  
* *Message affiché: annuaire.xml validates.*
 
7- Création d'un fichier de validation : val_xml.sh contenant les instructions:  
* #!/bin/bash  
* xmllint --noout $1 --schema $2


8- Création du fichier Dockerfile qui contient les instructions suivantes:  
* FROM debian  
* MAINTAINER TSI15  
* ADD proxy.conf /etc/apt/apt.conf.d/proxy.conf  
* RUN apt-get update && apt-get install -y libxml2-utils  
* ADD val_xml.sh val_xml.sh  
* RUN chmod +x val_xml.sh


##Exécution du Test de validation

1- création d'une copie de  l'image en se positinant dans le meme répotoire que le fichier dockerfile et les fichiers annuaire.xml et annuaire.xsd  
* docker build -t test ./

2- Exécution de la commande suivante :  
* docker run -v /home/gtsi/Images:/rep test --name=monconteneur ./val_xml.sh rep/annuaire.xml rep/annuaire.xsd  
* *Message affiché: rep/annuaire.xsd.*
