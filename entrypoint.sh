#!/bin/sh

setup_es_endpoint() {
 
  ### Shard Allocations Awareness Attribute ###
  if [ -n "$ES_URLS" ]; then
    index=0
    for ES_URL in $(echo $ES_URLS | sed "s/,/ /g")
    do
      ES_URL=$(echo $ES_URL | sed "s/ //g")
      OPTS="$OPTS -Dhosts.$index.host=$ES_URL"
      index=$(($index+1))
    done
  fi
}

setup_es_endpoint

echo "ES_URLS $ES_URLS"
echo "Starting Cerebro for elasticsearch with the options $OPTS"
CMD="$CEREBRO_HOME/bin/cerebro $OPTS"
$CMD
