FROM phusion/baseimage:focal-1.0.0alpha1-amd64

COPY ./dockerfiles/charescape__hello/helloworld  /etc/my_init.d/

RUN set -eux \
&& chmod +x /etc/my_init.d/helloworld \
&& /etc/my_init.d/helloworld

CMD ["/sbin/my_init"]
