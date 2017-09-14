#!/bin/bash

echo "SECONDS: ${SECONDS}"

SECONDS=0
echo "START: $(date)"
echo "SLEEPING: ${SLEEP} seconds"

if [ "${KEEPALIVE}" == true ]; then
  echo "KEEPING ALIVE"
  while [ "${SECONDS}" -lt "${SLEEP}" ]; do
    echo "${SECONDS} < ${SLEEP}"
    echo "Stressing 60 seconds before sleeping 340 (${SLEEP} total)"
    stress --cpu 8 --timeout 60
    sleep 340
  done
else
  echo "NOT KEEPING ALIVE"
  echo "Stressing 30 seconds before sleeping ${SLEEP}"
  stress --cpu 4 --timeout 30
  sleep "${SLEEP}"
fi

echo "END: $(date)"
duration=$SECONDS
echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
