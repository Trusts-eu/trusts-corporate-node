# Deployment of the TRUSTS plaform corporate node

### Introduction
This is an example deployment of a single node of the [TRUSTS](https://www.trusts-data.eu/) plaform. 
For better understanding of the TRUSTS plaform architecture, please refer to the project's deliverable [D2.7 Architecure design and technical specifications document II](https://www.trusts-data.eu/wp-content/uploads/2022/01/D2.7-Architecture-design-and-technical-specifications-document-II_Dec2021.pdf)

In this example you will
- start up one Dataspace Connector with file persistence
- deploy a local CKAN instance along with it's auxiliary services (postgres, solr, redis, recommender)
For the sake of simplicity this example uses the Dataspace Connector with an in-built H2 database.
Therefore, we do not set up additional database containers.

### Prerequisites
- You need docker compose to run this example.
- Make sure to have put all files from **/node/recomm** in the same folder structure to your execution destination path alongside the **docker-compose.yaml** file

### Installation Steps
Before starting up the containers you have to create the .env file and the config.json file. In principle, for now only the LOCAL_NODE_NAME has to be specified, for the rest you can use the default values.
To simplify the process you can use the following on your terminal.

**Important**: You need the gettext package in order to run the following
```bash
## on Debian based *nix
sudo apt-get install -y gettext

## on MacOS
brew install gettext
brew link --force gettext

## on Windows
# the following scripts do not run on CMD. I would recommend to install
# CygWin or MiniGW or Git Bash (Ubuntu WSL) 
# otherwise you will have to create and edit the files manually
```



First define the basic variables
```console
export LOCAL_NODE_NAME=<replace_this_with_your_local_node_name>            //example: export LOCAL_NODE_NAME=alpha-core
export NODE_IP_ADDRESS=<replace_this_with_your_VM_IP>                      //example: export NODE_IP_ADDRESS=35.205.82.213
export CKAN_URL=<replace_this_with_the_url_you_use_to_access_CKAN:PORT>    //example: export CKAN_URL=http://35.205.82.213:5000
export LOCAL_NODE_CERT=<replace_this_with_name_dsc_certificate>            //example: export LOCAL_NODE_CERT=alpha-core.p12
export DAPS_URL=<replace_this_with_the_daps_server_url_provided>           //example: export DAPS_URL=DAPS_URL=https://daps.tb.nicos-rd.com
export BROKER_URL=<replace_this_with_the_broker_url_provided>              //example: export BROKER_URL=http://broker-core:8282/infrastructure
```

then run the following commands
```console
envsubst < config_templates/.env.template > node/.env
envsubst < config_templates/config.template.json > node/config.json
envsubst < config_templates/trustshosts.template > trustshosts
envsubst < config_templates/appsettings.json > node/appsettings.json
```
That's it, you will see the newly created files on their respective folders, and now you are nearly able to bring up the containers.

### Certificates
The certificate should be placed in directory node/idscert before run docker compose for example in folder should be at least two files: truststore.p12 and alpha-core.p12 if your node is apha-core.


### run this command to update the images

To start the containers from the given docker-compose.yml file do

```console
cd ./node
docker-compose pull
```
(If you get a python error with this pull, do `export LD_LIBRARY_PATH=/usr/local/lib` and try again)
And then launch with
```

docker-compose up -d
```
If everything is OK, you should have your local node up and running.
Please follow the [instructions](node/README.md) in order to further proceed.

## Important
In the resulting `docker-compose.yml` file, it might be necessary to replace the `CKAN_SITE_URL` variable in case the value of `LOCAL_NODE_NAME` is not in the clients /etc/hosts file

## One time action if the certificate has problem

Only in first run of docker-compose and if Dataspace Connector has problem to find your certificate you maybe need to delete volume "node_dataspaceconnector-data" using command:
```

docker volume rm node_dataspaceconnector-data
```


## Enabling the Vocabularies plugin
The ckanext-vocabularies plugin is not enabled by default in the current deployment. To enable it, change in the docker-compose.yml the value of CKAN_EXTRA_PLUGIN_LIST to 
```
- CKAN_EXTRA_PLUGIN_LIST=,vocabularies,trusts_theme
```


Now the plugin is enabled but still you will not see any changes. This is because the scheming plugin loads the schemas from the schemes defined in the ids plugin. In this repo you will find a set of predefined schemas in the node/schemas folder. For now, the dataset.yml has been modified to enable use of a test vocabulary provided by the central node DSC. In order to use those schemas instead of the defaults, you can add the following env variable on the definition of the ```local-ckan``` service:
```
- SCHEMING_DATASET_SCHEMAS=file:///schemas/dataset.yml ckanext.ids:schemes/service.yml ckanext.ids:schemes/application.yml
```

# Contributors

This code has been developed as part of the [TRUSTS project](https://www.trusts-data.eu/). Contributors to this repository are:
* Sotiris Karampatakis  (Semantic Web Company)
* Victor Mireles (Semantic Web Company)
* Dieter Theiler (KNOW Center)
* Nikos Fourlataras (Relational Greece)



# License

This deployment is distributed under [AGPL](https://www.gnu.org/licenses/agpl-3.0.en.html). 
However, some components might have other sorts of licenses. 

In particular, if you want to use the optional recommender system (not included in this deployment), you need to acquire a licence from KNOW Center. Please refer to `/recommender/recomm-README.md` file for contact details. 

# Funding
This code was created as part of project TRUSTS: Trusted secure data sharing space.

This project has received funding from the European Union's Horizon 2020 research and innovation programme under grant agreement [No 871481](https://cordis.europa.eu/project/id/871481).
