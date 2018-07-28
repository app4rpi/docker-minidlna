FROM hypriot/rpi-alpine

MAINTAINER app4rpi <app4rpi@outlook.com>

RUN apk add --no-cache bash minidlna
RUN rm -rf /var/cache/apk/*

ADD minidlna.conf /etc/minidlna.conf

RUN mkdir -p /var/cache/minidlna /var/log /media/video /media/musica /media/img
RUN [ $(getent group minidlna) ] || addgroup minidlna &&  [ $(getent passwd minidlna) ] || adduser -G minidlna -S minidlna
RUN chown minidlna:minidlna /var/cache/minidlna /var/log /media/video /media/musica /media/img

EXPOSE 1900/udp
EXPOSE 8200

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
