#!/bin/bash

export SNYK_LOG_PATH=$PWD
export GITLAB_TOKEN=
export SNYK_TOKEN=

sourceOrgPublicId=
groupId=
sourceUrl=

source=gitlab
integrationType=gitlab

#Generate file to mirror GitLab groups/sub-groups
DEBUG=snyk* /snyk-api-import-linux orgs:data \
--sourceOrgPublicId=$sourceOrgPublicId \
--groupId=$groupId \
--source=$source \
--sourceUrl=$sourceUrl \
--skipEmptyOrgs

#Create orgs in Snyk
DEBUG=snyk* /snyk-api-import-linux orgs:create \
--file=group-$groupId-gitlab-orgs.json \
--noDuplicateNames

#Generate import data
DEBUG=snyk* /snyk-api-import-linux import:data \
--orgsData=snyk-created-orgs.json \
--integrationType=$integrationType \
--source=$source \
--sourceUrl=$sourceUrl

#Import repos
DEBUG=snyk* /snyk-api-import-linux import \
--file=gitlab-import-targets.json