# To start docker
#### if never define schedule thn it will run everyday 12PM
`$ docker run -e PRINTER_IP="192.168.88.90" -e CRON_SCHEDULE="0 15 * * *" -e TZ=Asia/Kuala_Lumpur -d --name print-scheduler jychoy/print-scheduler`

# To add printer
`$ lpadmin -p <printer_name> -E -v ipp://<printer_ip_address>/ipp/print -m everywhere`

# To list printer
`$ lpstat -p`

# To test print
`$ lp -d <printer_name> /root/colorful_page.pdf`
