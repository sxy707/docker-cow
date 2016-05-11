FROM centos:centos6
MAINTAINER sean


EXPOSE ${LISTEN_PORT:-17777}

RUN rm -Rf ~/.cow
RUN rm -Rf /cow
RUN mkdir ~/.cow
RUN mkdir /cow
RUN echo "listen = http://${LISTEN_IP:-127.0.0.1}:${LISTEN_PORT:-17777}" >> ~/.cow/rc
RUN echo "proxy = ss://${SS_ENCRYPT_METHOD:-aes-256-cfb}:${SS_PASSWORD:-000000}@${SS_SERVER_IP:-0.0.0.0}:${SS_SERVER_PORT:-44312}" >> ~/.cow/rc

COPY ./cow/cow /cow/cow
RUN chmod +x /cow/cow

VOLUME ~/.cow

CMD ["/cow/cow"]