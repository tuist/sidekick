#!/usr/bin/env bash
#MISE description="Creates a Linux release of the agent"

set -eo pipefail

(cd agent && MIX_ENV=prod BURRITO_TARGET=macos mix release --overwrite)

TMP_DIR=$(mktemp -d)
KEYCHAIN_PATH=$TMP_DIR/keychain.keychain
CERTIFICATE_PATH=$TMP_DIR/certificate.p12
echo "$MACOS_SIGNING_CERTIFICATE_BASE64" | base64 --decode > $CERTIFICATE_PATH

# Create a temporary keychain in CI
if [ "$CI" = "1" ]; then
  KEYCHAIN_PASSWORD=$(uuidgen)
  security create-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN_PATH
  security set-keychain-settings -lut 21600 $KEYCHAIN_PATH
  security default-keychain -s $KEYCHAIN_PATH
  security unlock-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN_PATH
fi

CERTIFICATE_EXISTS=$(security find-certificate -c "$CERTIFICATE_NAME" 2>/dev/null)
if [ -z "$CERTIFICATE_EXISTS" ]; then
    security import $CERTIFICATE_PATH -P $CERTIFICATE_PASSWORD -A
fi

/usr/bin/codesign --sign "$CERTIFICATE_NAME" --timestamp --options runtime --verbose agent/burrito_out/plasma_agent_macos
