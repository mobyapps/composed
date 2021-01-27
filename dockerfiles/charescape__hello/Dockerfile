FROM scratch

COPY ./dockerfiles/charescape__hello/hello /

RUN set -eux \
&& chmod +x /hello \
&& /hello

CMD ["/hello"]
