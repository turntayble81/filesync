#!/bin/bash

#SAMPLE CONFIG FILE. COPY TO .config.sh
#AND SET VALUES

#POLLING FREQUENCY (IN SECONDS)
POLLING_TIME=0.5;

#ABSOLUTE PATH TO DIRECTORY TO WATCH. NO TRAILING SLASH
WATCH_DIR="/path/to/dir";

#SSH_USER
SSH_USER="username";

#SSH HOST
SSH_HOST="server.hostname.com";

#SSH PORT
SSH_PORT=22;

#SSH_DIR RELATIVE TO SSH USER HOME DIR
SSH_DIR="dest-dir";

#EXCLUDE PATTERNS
EXCLUDE=( "*node_modules*" "*.git*");