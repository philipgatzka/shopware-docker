#!/usr/bin/env bash

checkParameter
clearCache

PROJECT_ROOT="/var/www/html/$SHOPWARE_PROJECT/"
URL=$(get_url "$SHOPWARE_PROJECT")

cd "${PROJECT_ROOT}" || exit 1

bin/console theme:dump
export APP_URL=$URL
export PROJECT_ROOT=$PROJECT_ROOT

PLATFORM_PATH=$(platform_component Storefront)

cp /opt/swdc/modules/platform/hot-proxy-patched.js "$PLATFORM_PATH"/Resources/app/storefront/build/proxy-server-hot/index.js

npm --prefix "$PLATFORM_PATH"/Resources/app/storefront/ run hot-proxy
