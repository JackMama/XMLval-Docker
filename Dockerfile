FROM debian
MAINTAINER TSI15
ADD proxy.conf /etc/apt/apt.conf.d/proxy.conf
RUN apt-get update && apt-get install -y libxml2-utils
ADD val_xml.sh val_xml.sh
RUN chmod +x val_xml.sh

