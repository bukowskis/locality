# Locality

## Swedish A-Region

See https://sv.wikipedia.org/wiki/A-region

### Installation

```bash
# Go and buy the rec2LK database from postnummerservice.se
# Put it in the ./db directory
```

### Configuration

```ruby
Locality.configure do |config|

  # By default, locality will look for the rec2LK database in
  # these locations: `Locality.config.postnummerfilen_paths`
  # You can add a custom location like so:
  config.postnummerfilen_path = '/some/custom/rec2LK.csv'

end

```
### Usage

```ruby
lookup = Locality::Aregion.new 21  # Gotland

lookup.zip_codes  # => Array of Integers
# More to come...
```

## IP Lookup

### Installation

```bash
# Get the libmaxminddb, e.g. via homebrew on Mac OS
brew install libmaxminddb
# Tell bundler where to find it
bundle config build.hive_geoip2 --with-opt-dir=$(brew --prefix)
# Download and extract the MaxMind GeoIp2 database
curl http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz -o ./db && gunzip ./db/GeoLite2-City.mmdb.gz
```

### Configuration

```ruby
Locality.configure do |config|

  # By default, locality will look for the maxmind database in
  # these locations: `Locality.config.maxmind_geoip2_path`
  # You can add a custom location like so:
  config.maxmind_geoip2_path = '/some/custom/maxmind_geolite2.mmdb'

  # If you want, you can add custom lookups like so:
  config.add_custom_ip_location '198.51.100.99/24', city_name: 'Main Office', country_name: 'Australia'
end
```

### Usage

```ruby
# If you want to make sure on application
# bootup that everything works, call this method:
Locality::IP.check!

# Lookup an IP
lookup = Locality::IP.new '198.51.100.55'

# All these attributes return either a String or nil.
lookup.ip
lookup.city_name
lookup.province_name
lookup.state_name
lookup.country_name
lookup.human_readable_name

# Get them all combined in a Hash
lookup.to_hash
```

