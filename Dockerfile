ARG FUNCTION_DIR="/function"

FROM python:3.9.10-buster

RUN apt-get update && \
    apt-get install -y \
    g++ \
    make \
    cmake \
    unzip \
    libcurl4-openssl-dev

ARG FUNCTION_DIR

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN /usr/local/bin/python -m pip --no-cache-dir install --target ${FUNCTION_DIR} awslambdaric
ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie \
    /usr/local/bin/aws-lambda-rie
RUN chmod 755 /usr/local/bin/aws-lambda-rie

WORKDIR "${FUNCTION_DIR}"

COPY requirements.txt .
RUN /usr/local/bin/python -m pip --no-cache-dir install -r requirements.txt

COPY app.py .

COPY ./entry_script.sh /entry_script.sh
RUN chmod 755 /entry_script.sh

ENTRYPOINT [ "/entry_script.sh" ]
CMD [ "app.handler" ]
