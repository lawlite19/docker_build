FROM alpine
LABEL author="lawlite" email="849451478@qq.com"
WORKDIR /app
COPY src /app
RUN echo 321 >> test.txt
ARG B=11
ONBUILD ENV C=100
ENV A=${B}
CMD echo ${C}

