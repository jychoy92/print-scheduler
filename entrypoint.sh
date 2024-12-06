#!/bin/bash

# Default settings
DEFAULT_PRINTER_IP="127.0.0.1"
PRINTER_IP=${PRINTER_IP:-$DEFAULT_PRINTER_IP}
DEFAULT_SCHEDULE="0 12 * * *"
CRON_SCHEDULE=${CRON_SCHEDULE:-$DEFAULT_SCHEDULE}

# Start CUPS service
service cups start

# Configure the printer with the provided or default IP
lpadmin -p My-Printer -E -v ipp://$PRINTER_IP/ipp/print -m everywhere || {
    echo "Failed to add printer. Please check the printer IP and configuration."
    exit 1
}
cupsctl --remote-any

# Configure the cron job
echo "$CRON_SCHEDULE /root/print_job.sh" > /etc/cron.d/print_job
chmod 0644 /etc/cron.d/print_job
crontab /etc/cron.d/print_job

# Start cron service
cron

# Keep the container running (optional)
tail -f /dev/null
