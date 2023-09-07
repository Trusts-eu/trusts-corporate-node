FROM ckan/ckan-base:ckan-2.10.0

# Set up environment variables
ENV APP_DIR=/srv/app
ENV TZ=UTC
RUN echo ${TZ} > /etc/timezone

# Make sure both files are not exactly the same
RUN if ! [ /usr/share/zoneinfo/${TZ} -ef /etc/localtime ]; then \
        cp /usr/share/zoneinfo/${TZ} /etc/localtime ;\
    fi ;

RUN pip3 install -r /srv/app/src/ckan/dev-requirements.txt && \
    pip3 install -e "git+https://github.com/ckan/ckanext-scheming.git#egg=ckanext-scheming" "git+https://github.com/ckan/ckanext-basiccharts.git#egg=ckanext-basiccharts" future ckanext-visualize && \
    pip3 install cachetools rdflib==6.3.1 pyparsing==2.4.7 SPARQLWrapper==1.8.5 attrs flask_swagger_ui && \
    pip3 install ckanext-ids==1.0.14 ckanext-vocabularies==0.0.6

COPY docker-entrypoint.d/* /docker-entrypoint.d/