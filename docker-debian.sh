#
# Installer for Vodia PBX on Debian
#
# TODO:
# Decide what languages you want installed (for audio). Valid languages are:
# dk: Danish
# nl: Dutch
# uk: English (UK)
# en: English (US)
# ca: French (Canada)
# fr: French (France)
# de: German
# gr: Greek
# it: Italian
# pl: Polish
# ru: Russian
# sp: Spanish
# se: Swedish
# tr: Turkish
#LANGUAGES="en de" #ENV VARIABLE !

# TODO:
# Decide where to put all the stuff:
PBX_DIR=/usr/local/pbx

# TODO:
# Decide which version you want to run:
#VERSION=59.0 #ENV VARIABLE !

# Below here should be audomatic
# Find out if this is 32 or 64 bit:
BITS=`getconf LONG_BIT`;

DOWNLOAD_PATH=http://vodia.com/downloads/pbx

#
# Check if this is root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi


if [ ! -d $PBX_DIR ]; then
  mkdir $PBX_DIR
fi
cd $PBX_DIR

# Get the language files:
for i in $LANGUAGES moh; do
  wget $DOWNLOAD_PATH/audio/audio_$i.zip
  unzip audio_$i.zip
  rm audio_$i.zip
done

# Get the executable:
wget $DOWNLOAD_PATH/debian$BITS/pbxctrl-debian$BITS-$VERSION
wget $DOWNLOAD_PATH/dat/pbxctrl-$VERSION.dat

mv pbxctrl-debian$BITS-$VERSION pbxctrl
mv pbxctrl-$VERSION.dat pbxctrl.dat
chmod a+rx pbxctrl

cat >pbx.sh <<EOF
#!/bin/bash -f
cd $PBX_DIR
while [ 1 ]; do
    ./pbxctrl --dir . --no-daemon
done
EOF
chmod a+rx pbx.sh
