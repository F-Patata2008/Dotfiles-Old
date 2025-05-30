#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5

# Current Theme
dir="$HOME/.config/rofi/powermenu/type-1"
theme='style-1'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown=' Shutdown'
reboot=' Reboot'
lock=' Lock'
suspend=' Suspend'
logout=' Logout'
yes=' Yes'
no=' No'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "$host" \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
            # Lock the screen before suspending
            # Prioritize hyprlock for Hyprland environments
            if command -v hyprlock &>/dev/null && [[ -n "$WAYLAND_DISPLAY" ]]; then
                hyprlock & # hyprlock daemonizes/forks, run in background
            elif command -v swaylock &>/dev/null && [[ -n "$WAYLAND_DISPLAY" ]]; then
                swaylock & # swaylock typically daemonizes/forks
            elif command -v betterlockscreen &>/dev/null && [[ -x '/usr/bin/betterlockscreen' ]]; then
                betterlockscreen -l # betterlockscreen calls i3lock which forks
            elif command -v i3lock &>/dev/null && [[ -x '/usr/bin/i3lock' ]]; then
                i3lock # i3lock forks by default
            else
                echo "Warning: No suitable screen locker (hyprlock, swaylock, betterlockscreen, i3lock) found." >&2
                echo "Suspending without locking screen." >&2
            fi

            # Optional: A brief moment for the locker to take full effect.
            # This is often needed because systemctl suspend can be very fast.
            # Adjust or remove if your locker is fast enough or if hyprlock handles this internally.
            sleep 0.5 # Increased slightly, test what works for you

            # Pause media players
            if command -v mpc &>/dev/null; then
                mpc -q pause
            fi
            if command -v playerctl &>/dev/null; then
                playerctl --all-players pause || true # Pause all MPRIS players
            fi

            # Mute audio
            if command -v amixer &>/dev/null; then
                amixer -q set Master mute # -q for quiet
            fi

            systemctl suspend
		elif [[ $1 == '--logout' ]]; then
			if [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
				i3-msg exit
			elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
				qdbus org.kde.ksmserver /KSMServer logout 0 0 0
			elif [[ "$DESKTOP_SESSION" == 'hyprland' || "$XDG_CURRENT_DESKTOP" == 'Hyprland' ]]; then
				hyprctl dispatch exit ""
			else
                if command -v loginctl &>/dev/null && [[ -n "$XDG_SESSION_ID" ]]; then
                    loginctl terminate-session "${XDG_SESSION_ID}"
                else
				    echo "Attempting generic logout... pkill -SIGKILL -u $USER (last resort)" >&2
                    # pkill -SIGKILL -u "$USER" # Very aggressive, use with caution
                fi
			fi
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		# Prioritize hyprlock for Hyprland environments
		if command -v hyprlock &>/dev/null && [[ -n "$WAYLAND_DISPLAY" ]]; then
			hyprlock
		elif command -v swaylock &>/dev/null && [[ -n "$WAYLAND_DISPLAY" ]]; then
			swaylock
		elif command -v betterlockscreen &>/dev/null && [[ -x '/usr/bin/betterlockscreen' ]]; then
			betterlockscreen -l
		elif command -v i3lock &>/dev/null && [[ -x '/usr/bin/i3lock' ]]; then
			i3lock
		else
			echo "No lockscreen utility found (hyprlock, swaylock, betterlockscreen, i3lock)." >&2
		fi
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
