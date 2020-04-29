# docker-geoipupdate

Runs MaxMind's [geoipupdate](https://dev.maxmind.com/geoip/geoipupdate/) program in Docker

| Property    | Value                                            |
|-------------|--------------------------------------------------|
| Base        | [Ubuntu](https://hub.docker.com/_/ubuntu)        |
| Init system | N/A                                              |

## Environment variables
| Variable          | Required? | Definition                       | Example                                     | Comments                        |
|-------------------|-----------|----------------------------------|---------------------------------------------|---------------------------------|
| GeoIP_AccountID   | Yes       | Account ID                       | XXXXXX                                      |                                 |
| GeoIP_LicenseKey  | Yes       | License key                      | XXXXXXXXXXXXXXXX                            |                                 |
| GeoIP_EditionIDs  | Yes       | List of databases to download    | GeoLite2-ASN GeoLite2-City GeoLite2-Country |                                 |
| GeoIP_Cron        | No        | When the cron job should run     | 21 * * * * /usr/bin/geoipupdate -v          | Needs to be in crontab format   |
| TZ                | No        | Timezone                         | America/New_York                            | Needed if using GeoIP_Cron      |

## Ports
N/A

## Volumes
| Volume on host            | Volume in container | Comments                            |
|---------------------------|---------------------|-------------------------------------|
| Choose at your discretion | /usr/share/GeoIP    | Used to store the MaxMind databases |
