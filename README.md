# ⚠️ WARNING ⚠️

This was created before MaxMind released their official Docker container. As such, I will not be updating this code and I suggest you use their official container (link below)

https://hub.docker.com/r/maxmindinc/geoipupdate

# docker-geoipupdate

[![Build Status](https://travis-ci.org/loganmarchione/docker-geoipupdate.svg?branch=master)](https://travis-ci.org/loganmarchione/docker-geoipupdate)
[![](https://images.microbadger.com/badges/image/loganmarchione/docker-geoipupdate.svg)](https://microbadger.com/images/loganmarchione/docker-geoipupdate "Get your own image badge on microbadger.com")

Runs MaxMind's [GeoIP Update](https://dev.maxmind.com/geoip/geoipupdate/) program in Docker
  - Source code: [GitHub](https://github.com/loganmarchione/docker-geoipupdate)
  - Docker container: [Docker Hub](https://hub.docker.com/r/loganmarchione/docker-geoipupdate)
  - Image base: [Ubuntu](https://hub.docker.com/_/ubuntu)
  - Init system: N/A
  - Application: [GeoIP Update](https://dev.maxmind.com/geoip/geoipupdate/)

## Docker image information

### Docker image tags
  - `latest`: Latest version
  - `X.X.X`: [Semantic version](https://semver.org/) (use if you want to stick on a specific version)

### Environment variables
| Variable          | Required? | Definition                       | Example                                     | Comments                        |
|-------------------|-----------|----------------------------------|---------------------------------------------|---------------------------------|
| GeoIP_AccountID   | Yes       | Account ID                       | XXXXXX                                      |                                 |
| GeoIP_LicenseKey  | Yes       | License key                      | XXXXXXXXXXXXXXXX                            |                                 |
| GeoIP_EditionIDs  | Yes       | List of databases to download    | GeoLite2-ASN GeoLite2-City GeoLite2-Country |                                 |
| GeoIP_Cron        | No        | When the cron job should run     | 21 * * * * /usr/bin/geoipupdate -v          | Needs to be in crontab format   |
| TZ                | No        | Timezone                         | America/New_York                            | Needed if using GeoIP_Cron      |

### Ports
N/A

### Volumes
| Volume on host            | Volume in container | Comments                            |
|---------------------------|---------------------|-------------------------------------|
| Choose at your discretion | /usr/share/GeoIP    | Used to store the MaxMind databases |

### Example usage
Below is an example docker-compose.yml file.
```
version: '3'
services:
  geoipupdate:
    container_name: geoipupdate
    restart: unless-stopped
    environment:
      - GeoIP_AccountID=XXXXXX
      - GeoIP_LicenseKey=XXXXXXXXXXXXXXXX
      - 'GeoIP_EditionIDs=GeoLite2-ASN GeoLite2-City GeoLite2-Country'
      - 'GeoIP_Cron=5 4 15 * * /usr/bin/geoipupdate -v'
    networks:
      - geoipupdate
    volumes:
      - 'GeoIP_Data:/usr/share/GeoIP'
    image: loganmarchione/docker-geoipupdate:latest

networks:
  geoipupdate:

volumes:
  GeoIP_Data:
    driver: local
```

## TODO
- [ ] Run the processes inside the container as a non-root user
- [ ] Add a [healthcheck](https://docs.docker.com/engine/reference/builder/#healthcheck)
- [ ] Support more variables in `GeoIP.conf` from the [official documentation](https://github.com/maxmind/geoipupdate/blob/master/doc/GeoIP.conf.md)
