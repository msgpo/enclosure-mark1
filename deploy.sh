#!/usr/bin/env bash
MYCROFT_HOSTNAME=${1}

if [[ -z "$MYCROFT_HOSTNAME" ]]; then
    echo "You have to specify a deployment hostname. Usage: deploy.sh <hostname>"
    echo "E.g. deploy.sh pi@localhost"
    exit 1
fi

echo "Compiling..."
./compile.sh
echo "Deploying to: " ${MYCROFT_HOSTNAME}
sshpass -p 'mycroft' ssh ${MYCROFT_HOSTNAME} "sudo mkdir -p /opt/enclosure"
sshpass -p 'mycroft' scp ${PWD}/build/enclosure.ino.hex ${MYCROFT_HOSTNAME}:/tmp/enclosure.ino.hex
sshpass -p 'mycroft' ssh ${MYCROFT_HOSTNAME} "sudo mv /tmp/enclosure.ino.hex /opt/enclosure"
echo "Burning..."
sshpass -p 'mycroft' ssh ${MYCROFT_HOSTNAME} "sudo avrdude enclosure.ino.hex -p atmega328p -C /opt/mycroft/enclosure/avrdude-gpio.conf -c linuxgpio -v -U flash:w:/opt/enclosure/enclosure.ino.hex"
echo "Cool! : D"
