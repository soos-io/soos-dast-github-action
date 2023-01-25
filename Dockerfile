FROM soosio/dast:actiontest


# Copies your code file from your action repository to the filesystem path `/` of the container
USER root
COPY check_version.py /check_version.py
WORKDIR /zap
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
CMD ["-h"]
