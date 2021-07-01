# cpp
FROM registry.redhat.io/codeready-workspaces/stacks-cpp-rhel8

ARG S2IDIR="/home/s2i"
# TODO: Put the maintainer name in the image metadata
LABEL maintainer="Avinash Reddy Palleti <avinash.reddy.palleti@intel.com>"

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0
ENV EXE=
# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building CPP applications" \
      io.k8s.display-name="builder cpp" \
      io.openshift.s2i.scripts-url="image://$S2IDIR/bin"
#      io.openshift.expose-services="8080:http" \
#      io.openshift.tags="builder,x.y.z,etc."
# TODO: Install required packages here:

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/
USER root
# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY s2i $S2IDIR
RUN chmod 777 -R $S2IDIR
# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001
# TODO: Set the default port for applications built using this image
# EXPOSE 8080

# TODO: Set the default CMD for the image
# CMD ["/usr/libexec/s2i/usage"]
