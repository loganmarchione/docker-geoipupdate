# ⚠️ WARNING ⚠️

This was created before MaxMind released their official Docker container. As such, I will not be updating this code and I suggest you use their official container (link below)

https://hub.docker.com/r/maxmindinc/geoipupdate

# docker-geoipupdate

Runs MaxMind's [GeoIP Update](https://dev.maxmind.com/geoip/geoipupdate/) program in Docker
  - Source code: [GitHub](https://github.com/loganmarchione/docker-geoipupdate)
  - Image base: [Ubuntu](https://hub.docker.com/_/ubuntu)
  - Init system: N/A
  - Application: [GeoIP Update](https://dev.maxmind.com/geoip/geoipupdate/)

## Explanation

  - This run MaxMind's GeoIP Update program in Docker. The databases are saved to a volume, which can then be exposed to another container (e.g., Graylog).

## Requirements

  - You must already have a Maxmind account, as described [here](https://blog.maxmind.com/2019/12/18/significant-changes-to-accessing-and-using-geolite2-databases/).

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

#### Build
```
git clone https://github.com/loganmarchione/docker-geoipupdate.git
cd docker-geoipupdate
docker build --no-cache --file Dockerfile --tag loganmarchione/docker-geoipupdate .
```

#### Run
```
docker run --name geoipupdate --detach \
  --env GeoIP_AccountID=ACCOUNT_ID \
  --env GeoIP_LicenseKey=LICENSE_KEY \
  --env 'GeoIP_EditionIDs=GeoLite2-ASN GeoLite2-City GeoLite2-Country' \
  --env 'GeoIP_Cron=5 4 15 * * /usr/bin/geoipupdate -v' \
  --volume 'GeoIP_Data:/usr/share/GeoIP' \
  loganmarchione/docker-geoipupdate
```

## TODO
- [ ] Run the processes inside the container as a non-root user
- [ ] Add a [healthcheck](https://docs.docker.com/engine/reference/builder/#healthcheck)
- [ ] Support more variables in `GeoIP.conf` from the [official documentation](https://github.com/maxmind/geoipupdate/blob/master/doc/GeoIP.conf.md)
