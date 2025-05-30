#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot (Modified for hyprshot, swaync, loupe, clipse)

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Screenshot'
mesg="DIR: $(xdg-user-dir PICTURES)/Screenshots"

if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='5'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='5'
	win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='5'
	win_width='520px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='5'
	list_row='1'
	win_width='670px'
fi

# Options
layout=$(cat "${theme}" | grep 'USE_ICON' | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
	option_1=" Capture Desktop"
	option_2=" Capture Area"
	option_3=" Capture Window"
	option_4=" Capture in 5s"
	option_5=" Capture in 10s"
else
	option_1=""
	option_2=""
	option_3=""
	option_4=""
	option_5=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "${theme}"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Screenshot directory
dir="$(xdg-user-dir PICTURES)/Screenshots"

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# Notification function using swaync
send_notification() {
    local message="$1"
    local transient=${2:-false} # Optional second argument for transient
    local notif_id=699 # Consistent ID for swaync to replace

    if [[ "$transient" == "true" ]]; then
        swaync-client -R "$notif_id" -h string:type:transient:true -d "$message"
    else
        swaync-client -R "$notif_id" -d "$message"
    fi
}

# Notify and view screenshot
notify_view() {
	# Give a brief moment for the filesystem and hyprshot to complete
	sleep 0.2

	# Find the newest PNG file in the directory. Hyprshot saves with timestamps.
	# This assumes hyprshot is saving PNGs and it's the latest one.
	local latest_screenshot
	latest_screenshot=$(ls -t "${dir}"/*.png 2>/dev/null | head -n 1)

	if [[ -f "$latest_screenshot" ]]; then
		# hyprshot -c already handled the clipboard, clipse should pick it up
		send_notification "Copied to clipboard (via clipse)."
		loupe "${latest_screenshot}" & # Use loupe and run in background
		send_notification "Screenshot Saved: $(basename "${latest_screenshot}")"
	else
		send_notification "Failed to save or find screenshot."
	fi
}

# Countdown
countdown () {
	for sec in $(seq "$1" -1 1); do
		send_notification "Taking shot in : $sec" true # true for transient
		sleep 1
	done
}

# Take shots using hyprshot
# -o "$dir": Output to specified directory, hyprshot names the file
# -c:       Copy to clipboard (clipse will monitor this)

shotnow () {
	sleep 0.5 # Optional: small delay for things like menu disappearing
	hyprshot -m output -o "$dir" -c
	notify_view
}

shot5 () {
	countdown '5'
	hyprshot -m output -o "$dir" -c
	notify_view
}

shot10 () {
	countdown '10'
	hyprshot -m output -o "$dir" -c
	notify_view
}

shotwin () {
	# No cd needed, hyprshot handles path with -o
	hyprshot -m window -o "$dir" -c
	notify_view
}

shotarea () {
	hyprshot -m region -o "$dir" -c
	notify_view
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	elif [[ "$1" == '--opt4' ]]; then
		shot5
	elif [[ "$1" == '--opt5' ]]; then
		shot10
	fi
}

# Actions
chosen="$(run_rofi)"
case "${chosen}" in
    "$option_1")
		run_cmd --opt1
        ;;
    "$option_2")
		run_cmd --opt2
        ;;
    "$option_3")
		run_cmd --opt3
        ;;
    "$option_4")
		run_cmd --opt4
        ;;
    "$option_5")
		run_cmd --opt5
        ;;
esac
