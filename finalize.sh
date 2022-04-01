# turn on the firewall
sudo ufw --force enable

# last log cleanup
rm -rf /var/log/*.gz /var/log/*.[0-9] /var/log/*-???????? /var/log/*.log