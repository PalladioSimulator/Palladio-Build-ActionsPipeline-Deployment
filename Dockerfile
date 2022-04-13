FROM alpine:3.15
# Copies entrypoint.sh from action to '/' of the container
COPY entrypoint.sh /entrypoint.sh
#Make entrypoint.sh file executable:
RUN chmod 777 entrypoint.sh

#Install openssh
RUN apk update
RUN apk add --no-cache openssh

# Execute script
ENTRYPOINT ["/entrypoint.sh"]