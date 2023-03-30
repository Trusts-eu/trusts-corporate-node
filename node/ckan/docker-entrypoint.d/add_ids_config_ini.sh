#!/bin/sh

## envvars currently load at random order, so it might be that when the ckanext-ids plugin is loaded, the config is not yet in place
## with this script we make sure that the ckan.ini contains the required parameters for the plugin to load succesfully.

ckan config-tool ${CKAN_INI} ckanext.ids.trusts_local_dataspace_connector_url=${CKANEXT__IDS__TRUSTS_LOCAL_DATASPACE_CONNECTOR_URL} \
     ckanext.ids.trusts_local_dataspace_connector_port=${CKANEXT__IDS__TRUSTS_LOCAL_DATASPACE_CONNECTOR_PORT} \
     ckanext.ids.trusts_local_dataspace_connector_username=${CKANEXT__IDS__TRUSTS_LOCAL_DATASPACE_CONNECTOR_USERNAME} \
     ckanext.ids.trusts_local_dataspace_connector_password=${CKANEXT__IDS__TRUSTS_LOCAL_DATASPACE_CONNECTOR_PASSWORD} \
     ckanext.ids.trusts_central_broker=${CKANEXT__IDS__TRUSTS_CENTRAL_BROKER} \
     ckanext.ids.local_node_name=${CKANEXT__IDS__TRUSTS_LOCAL_NODE_NAME} \
     ckanext.ids.blockchain_enable=${CKANEXT__IDS__BLOCKCHAIN_ENABLE} \
     scheming.dataset_schemas="${CKAN___SCHEMING__DATASET_SCHEMAS}" \
     scheming.organization_schemas="${CKAN___SCHEMING__ORGANIZATION_SCHEMAS}" \
     scheming.presets="${CKAN___SCHEMING__PRESETS}" \
     licenses_group_url="${CKAN___LICENSES_GROUP_URL}" \
     ckan.auth.create_user_via_web=false \
     ckan.site_logo=/images/TrustsLogo.png

EXTRA_PLUGINS="ids ids_resources scheming_datasets scheming_organizations scheming_groups vocabularies"
ckan config-tool ${CKAN_INI} ckan.plugins="${CKAN__PLUGINS} ${EXTRA_PLUGINS}"

