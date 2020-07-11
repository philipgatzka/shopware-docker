#!/usr/bin/env bash

checkParameter

if [[ "$@" == *"--watch"* ]]; then
    TEST_SCRIPT="unit-watch"
else
    TEST_SCRIPT="unit"
fi

export PROJECT_ROOT="/var/www/html/$SHOPWARE_PROJECT"
export ENV_FILE="$PROJECT_ROOT/.env"
export APP_URL=$(get_url "$SHOPWARE_PROJECT")
export BABEL_ENV=test
export TESTING_ENV=watch

cd "$PROJECT_ROOT" || exit

if [[ -e vendor/shopware/platform ]]; then
    export ADMIN_PATH="vendor/shopware/platform/src/Administration/Resources/app/administration/"
    npm --prefix "$ADMIN_PATH" install
    npm --prefix "$ADMIN_PATH" run "$TEST_SCRIPT"
else
    export ADMIN_PATH="vendor/shopware/administration/Resources/app/administration/"
    npm --prefix "$ADMIN_PATH" install
    npm --prefix "$ADMIN_PATH" run "$TEST_SCRIPT"
fi