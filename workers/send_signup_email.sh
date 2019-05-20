#!/bin/bash

MESSAGE_ROUTING_KEY=$2
MESSAGE_FILE=$3
MESSAGE=$(cat $MESSAGE_FILE)

# cleanup
rm $MESSAGE_FILE

# The the message is a JSON object, so we convert all the keys to vars like this
while read k v; do export $k=$v; done < <(echo  $MESSAGE | jq -c -r 'to_entries[] | [.key, .value] | @tsv')

# works starts here


printf "Sending signup email to ${name} <${email}>... "

# sendEmail -o tls=yes \
# -xu $GMAIL_USER \
# -xp $GMAIL_PASSWORD \
# -s smtp.gmail.com:587 \
# -f "$GMAIL_FROM" \
# -t "${name} <${email}>" \
# -u "Welcome to our service (Khumbu Icefall)" \
# -m "We hope you enjoy your stay."
