#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: TasmoAdmin
# Ensures data is store in a persistent location
# ==============================================================================
if ! bashio::fs.directory_exists "/data/tasmoadmin"; then
    bashio::log.debug 'Data directory not initialized, doing that now...'

    # Setup structure
    cp -R /var/www/tasmoadmin/tasmoadmin/data /data/tasmoadmin

    # Ensure file permissions
    chown -R nginx:nginx /data/tasmoadmin
    find /data/tasmoadmin -not -perm 0644 -type f -exec chmod 0644 {} \;
    find /data/tasmoadmin -not -perm 0755 -type d -exec chmod 0755 {} \;
fi

bashio::log.debug 'Symlinking data directory to persistent storage location...'
rm -f -r /var/www/tasmoadmin/tasmoadmin/data
ln -s /data/tasmoadmin /var/www/tasmoadmin/tasmoadmin/data
