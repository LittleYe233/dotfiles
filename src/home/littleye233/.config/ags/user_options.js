// For every option, see ~/.config/ags/modules/.configuration/user_options.js
// (vscode users ctrl+click this: file://./modules/.configuration/user_options.js)
// (vim users: `:vsp` to split window, move cursor to this path, press `gf`. `Ctrl-w` twice to switch between)
//   options listed in this file will override the default ones in the above file

const userConfigOptions = {
    'cheatsheet': {
        'keybinds': {
            'configPath': "~/.config/hypr/custom/keybinds.conf"
        }
    },
    'time': {
        // See https://docs.gtk.org/glib/method.DateTime.format.html
        // Here's the 12h format: "%I:%M%P"
        // For seconds, add "%S" and set interval to 1000
        'format': "%H:%M:%S",
        'interval': 1000,
        'dateFormatLong': "%A, %Y-%m-%d", // On bar
        'dateInterval': 5000,
        'dateFormat': "%m-%d", // On notif time
    },
}

export default userConfigOptions;
