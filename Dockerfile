FROM centos:centos6
MAINTAINER sean

ENV LISTEN_IP ${LISTEN_IP:-127.0.0.1}
ENV LISTEN_PORT ${LISTEN_PORT:-17777}
ENV SS_SERVER_IP ${SS_SERVER_IP:-0.0.0.0}
ENV SS_SERVER_PORT ${SS_SERVER_PORT:-44312}
ENV SS_ENCRYPT_METHOD ${SS_ENCRYPT_METHOD:-aes-256-cfb}
ENV SS_PASSWORD ${SS_ENCRYPT_METHOD:-123456}

EXPOSE $LISTEN_PORT

RUN rm -Rf ~/.cow
RUN rm -Rf /cow
RUN mkdir ~/.cow
RUN mkdir /cow
RUN echo "listen = http://${LISTEN_IP}:${LISTEN_PORT}" >> ~/.cow/rc
RUN echo "proxy = ss://${SS_ENCRYPT_METHOD}:${SS_PASSWORD}@${SS_SERVER_IP}:${SS_SERVER_PORT}" >> ~/.cow/rc

COPY ./cow/cow /cow/cow
RUN chmod +x /cow/cow

CMD ["/cow/cow"]