#!/bin/sh -e

conf_file=/etc/GeoIP.conf

printf "#####\n"
printf "# Container starting up!\n"
printf "#####\n"

# Test variables, we need these three at minimum
if [ -z "$GeoIP_AccountID" ] || [ -z "$GeoIP_LicenseKey" ] || [ -z "$GeoIP_EditionIDs" ]; then
  printf "# ERROR: Either GeoIP_AccountID, GeoIP_LicenseKey, or GeoIP_EditionIDs are undefined, exiting!\n"
  exit 1
fi

# Create configuration file
printf "# STATE: Creating configuration file at $conf_file\n"
cat <<EOF > "$conf_file"
AccountID $GeoIP_AccountID
LicenseKey $GeoIP_LicenseKey
EditionIDs $GeoIP_EditionIDs
EOF

# Run the command once, this will download the databases
printf "# STATE: Running geoipupdate for the first time\n"
/usr/bin/geoipupdate -v

# If GeoIP_Cron is defined, install a cron job in the container
if [ -n "$GeoIP_Cron" ]; then
  # Create crontab file
  printf "# STATE: Detected GeoIP_Cron is defined, creating crontab file\n"
  printf "$GeoIP_Cron > /var/log/geoip_cronlog.txt 2>&1\n" > geoip_crontab.txt
  # Install crontab file 
  printf "# STATE: Installing crontab file\n"
  crontab geoip_crontab.txt
fi

# Continue running the CMD (from the Dockerfile)
exec $@
