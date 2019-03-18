FROM rethinkdb:2.3.6

COPY ./start-rethinkdb-cluster.sh /start-rethinkdb-cluster.sh

RUN chmod 777 /start-rethinkdb-cluster.sh
RUN ls -al /data


ENTRYPOINT ["bash", "-c", "/start-rethinkdb-cluster.sh"]

# checking for empty command in entrypoint.sh to allow runtime override
CMD [""]
