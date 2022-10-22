#!/bin/sh
# shellcheck disable=SC2016,SC2059

# Find your keybaord ID using `xinput list | grep "keyboard"`.
# Use device ID to stop minor mindfucks.
# You can use `xinput test <ID>` to test keycodes in real time.
KEYBOARD_ID="13"

METRIC=wpm
FORMAT="%d $METRIC"

INTERVAL=10

LAYOUT=qwerty

# $3 is the key index
case "$LAYOUT" in
    qwerty) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 24 && $3 <= 33) || ($3 >= 37 && $3 <= 53) || ($3 >= 52 && $3 <= 58)'; ;;
    azerty) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 24 && $3 <= 33) || ($3 >= 37 && $3 <= 54) || ($3 >= 52 && $3 <= 57)'; ;;
    qwertz) CONDITION='($3 >= 10 && $3 <= 20) || ($3 >= 24 && $3 <= 34) || ($3 == 36) || ($3 >= 38 && $3 <= 48) || ($3 >= 52 && $3 <= 58)'; ;;
    dvorak) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 27 && $3 <= 33) || ($3 >= 38 && $3 <= 47) || ($3 >= 53 && $3 <= 61)'; ;;
    dontcare) CONDITION='1'; ;; # Just register all key presses, not only letters and numbers
    *) echo "Unsupported layout \"$LAYOUT\""; exit 1; ;;
esac

multiply_by=60

divide_by=$INTERVAL

case "$METRIC" in
    wpm) divide_by=$((divide_by * 5)); ;;
    cpm) ;;
    *) echo "Unsupported metric \"$METRIC\""; exit 1; ;;
esac

typespeed_cache="$(mktemp -p '' typespeed_cache.XXXXX)"
trap 'rm "$typespeed_cache"' EXIT

# Write a `.` to our cache for each keypress
printf '' > "$typespeed_cache"
xinput test "$KEYBOARD_ID" | \
stdbuf -o0 awk '$1 == "key" && $2 == "press" && ('"$CONDITION"') {printf "."}' >> "$typespeed_cache" &

while true; do
	# check the file size in bytes using the `stat` command.
	# this will be equal to the amount of dots in the file
	# (how much keys were pressed since the file was last cleared)
    lines=$(stat --format %s "$typespeed_cache")
    
    # Truncate the cache file to only count new keypressed in next iteration
    printf '' > "$typespeed_cache"
    
    # The shell only does integer operations
	# first multiply and then divide
    value=$((lines * multiply_by / divide_by))
    
    printf "$FORMAT\\n" "$value"
    
    sleep $INTERVAL
done
