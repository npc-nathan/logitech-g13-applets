#!/bin/sh
# Check every applet in this repository with the driver's own checker.
#
#   ./check.sh                        uses g13 from PATH
#   G13=/path/to/g13 ./check.sh       uses a particular binary
#   ./check.sh applets/one.json ...   checks only the files you name
#
# An applet is checked from a temporary config directory, so this never looks at - or touches - the config of the
# machine it runs on.
set -eu
HERE=$(cd "$(dirname "$0")" && pwd)
G13=${G13:-g13}
if ! command -v "$G13" >/dev/null 2>&1 && [ ! -x "$G13" ]; then
    echo "no g13 to check with: put it on PATH, or set G13=/path/to/g13" >&2
    exit 1
fi

FILES=${*:-"$HERE"/applets/*.json}
CONFIG=$(mktemp -d)
mkdir -p "$CONFIG/applets"
trap 'rm -rf "$CONFIG"' EXIT
cp $FILES "$CONFIG/applets/"

status=0
for file in $FILES; do
    name=$(basename "$file" .json)
    declared=$(python3 -c "import json,sys; print(json.load(open(sys.argv[1])).get('name', ''))" "$file")
    if [ "$name" != "$declared" ]; then
        echo "  $name: the file name and its name field disagree ('$declared')" >&2
        status=1
    fi
    if ! G13_CONFIG_DIR="$CONFIG" "$G13" applet check "$name"; then
        status=1
    fi
done
exit $status
