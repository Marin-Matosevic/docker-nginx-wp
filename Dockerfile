FROM wordpress:php8.0-fpm

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libmcrypt-dev \
    libmagickwand-dev \
    libsodium-dev \
    libzip-dev \
    --no-install-recommends && rm -r /var/lib/apt/lists/* \
    && pecl install redis-5.3.3 imagick-3.6.0 libsodium-2.0.21 \
    && docker-php-ext-enable redis imagick sodium \
    && docker-php-ext-install -j$(nproc) exif gettext intl sockets zip

# # Install wp-cli
# RUN apt-get update && apt-get install -y sudo less mariadb-client
# RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN chmod +x /bin/wp-cli.phar
# RUN cd /bin && mv wp-cli.phar wp
# RUN mkdir -p /var/www/.wp-cli/cache && chown www-data:www-data /var/www/.wp-cli/cache

# Forward Message to mailhog
RUN curl --location --output /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
    chmod +x /usr/local/bin/mhsendmail
RUN echo 'sendmail_path="/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025 --from=no-reply@gbp.lo"' > /usr/local/etc/php/conf.d/mailhog.ini

# Note: Use docker-compose up -d --force-recreate --build when Dockerfile has changed.