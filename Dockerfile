# Base image with CUPS and cron
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    cups \
    cups-client \
    cups-bsd \
    wget \
    cron \
    printer-driver-brlaser && \
    apt-get clean

# Copy scripts into the container
COPY colorful_page.pdf /root/colorful_page.pdf
COPY entrypoint.sh /root/entrypoint.sh
COPY print_job.sh /root/print_job.sh

# Set executable permissions for scripts
RUN chmod +x /root/entrypoint.sh /root/print_job.sh

# Expose CUPS web interface port (optional)
EXPOSE 631

# Use entrypoint script to handle runtime logic
ENTRYPOINT ["/root/entrypoint.sh"]
