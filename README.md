# Quickstart

The docker-compose file mounts a volume called `/app` which is where the server will be sourced from.

There are also cache volumes mounted for the PostGRES data directory and the bundle install directory, so that you don't have to wait for bundles to install every `compose up`. To bust the cache, simply run `docker-compose down -v` to destroy the volumes, and then `docker-compose up` as usual.

The docker-start.sh file runs a `yarn install`, `bundle check || bundle install` to check if any gems are missing and if so, install them. Kills any artifacts blocking the server from running if the container is shutdown forcibly, and binds the server to port `3000` along with some self-signed SSL certificates, to comply with the new Chrome forced HTTPS protocol. This fixes the `ERR_SSL_PROTOCOL` white screen in Chrome when trying to use `rails server` or `rails s`, and the Puma Error in the rails logs: `HTTP parse error, malformed request (): #<Puma::HttpParserError: Invalid HTTP format, parsing fails.`

Simply drop these files into your application folder, change the `docker-compose` file to map your ports to fit your needs, and adapt the `docker-start.sh` to match the port mappings in your `docker-compose` file. 
