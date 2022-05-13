# snyk-project-import

This repo contains the necessary files to execute the [snyk-api-import](https://github.com/snyk-tech-services/snyk-api-import) library in a containerized environment.

> **Please Note: The following directions are specific to a self-hosted GitLab environment. For a different SCM, please refer to [snyk-api-import](https://github.com/snyk-tech-services/snyk-api-import)**

### Directions

1. On the host, create a directory to store the logs that are generated during execution:

> Note: These files should **not** be deleted, as they are required to prevent all repos from being re-imported. Retaining these files will ensure only *new* repos are imported.

```
sudo mkdir -p /var/lib/snyk
```

2. Change ownership of the directory to match the uid/gid of the ```node``` user executing the container

```
sudo chown -R 1000:1000 /var/lib/snyk
```

3. Add the necessary variable values to ```run.sh```

```
export GITLAB_TOKEN=
export SNYK_TOKEN=

sourceOrgPublicId=
groupId=
sourceUrl=
```

4. Build the image, including the version of the [snyk-api-import](https://github.com/snyk-tech-services/snyk-api-import) to use. This example uses version 1.66.0.

```
docker build -t snyk-api-import --build-arg version=1.66.0 ./
```

5. Run the container. Please note, a volume is mounted to store the generated files on the host.

```
docker run --name snyk-api-import -v /var/lib/snyk:/home/node snyk-api-import
```

6. Wait for the operation to complete. If this is your first time executing it, it will create Snyk orgs to mirror your GitLab instance, and import the repos to their respective org. To import newly created repos, please execute this container at a specified interval.

test commit
