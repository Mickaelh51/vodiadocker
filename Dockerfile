#command to build (in vodia directory): docker build -t vodia/pbx:60 .

FROM debian:latest
MAINTAINER HUBERT Mickael "mickael@winlux.fr"
RUN apt-get update -y && apt-get install -y wget apt-utils ntp unzip psmisc
# We copy just the requirements.txt first to leverage Docker cache
COPY ./docker-debian.sh /install/docker-debian.sh
WORKDIR /install
ENV VERSION "60.0"
ENV LANGUAGES "en fr"
RUN bash /install/docker-debian.sh
EXPOSE 443
EXPOSE 80
CMD ["/bin/bash"]
CMD ["/usr/local/pbx/pbx.sh"]
