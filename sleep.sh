#!/bin/bash

stderr_echo() {
  echo >&2 "$@"
}

#echo=stderr_echo
echo="$(which echo)"

$echo "SECONDS: ${SECONDS}"

SECONDS=0
$echo "START: $(date)"
$echo "SLEEPING: ${SLEEP} seconds"

echo '{}' | jq .

if ! which /usr/games/cowsay; then
  echo "cowsay not installed"
  exit 1
else
  echo "installed"
  /usr/games/cowsay -h
fi

if [ "${KEEPALIVE}" == true ]; then
  $echo "KEEPING ALIVE"
  while [ "${SECONDS}" -lt "${SLEEP}" ]; do
    $echo "${SECONDS} < ${SLEEP}"
    #sleep 300
    stress --cpu 4 --timeout 300
  done
else
  $echo "NOT KEEPING ALIVE"
  #sleep "${SLEEP}"
  stress --cpu 2 --timeout "${SLEEP}"
fi

$echo "END: $(date)"
duration=$SECONDS
$echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
