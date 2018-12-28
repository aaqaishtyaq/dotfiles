// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
    config: {
        // Choose either "stable" for receiving highly polished,
        // or "canary" for less polished but more frequent updates
        updateChannel: 'stable',

        // default font size in pixels for all tabs
        fontSize: 15,

        // font family with optional fallbacks
        //fontFamily: 'Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
        fontFamily: '"Operator Mono Lig", "FuraCode Nerd Font", monospace',

        // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
        cursorColor: 'rgb(98,39,174)', //'rgba(248,28,229,0.8)',

        // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
        cursorShape: 'BLOCK',

        // set to true for blinking cursor
        cursorBlink: true,

        // color of the text
        //foregroundColor: '#fff',

        // terminal background color
        //backgroundColor: 'rgb(9, 11, 16)',

        backgroundColor: 'rgb(15, 17, 26)',

        // border color (window, tabs)
        borderColor: '#ff000',

        // custom css to embed in the main window
        css: '',

        // custom css to embed in the terminal window
        termCSS: '',

        // set to `true` (without backticks) if you're using a Linux setup that doesn't show native menus
        // default: `false` on Linux, `true` on Windows (ignored on macOS)
        showHamburgerMenu: '',

        // set to `false` if you want to hide the minimize, maximize and close buttons
        // additionally, set to `'left'` if you want them on the left, like in Ubuntu
        // default: `true` on windows and Linux (ignored on macOS)
        showWindowControls: '',

        // custom padding (css format, i.e.: `top right bottom left`)
        padding: '12px 14px',

        // the full list. if you're going to provide the full color palette,
        // including the 6 x 6 color cubes and the grayscale map, just provide
        // an array here instead of a color map object
        //colors: {
        // black: '#000000',
        // red: '#ff0000',
        // green: '#33ff00',
        // yellow: '#ffff00',
        // blue: '#0066ff',
        // magenta: '#cc00ff',
        // cyan: '#00ffff',
        //white: '#d0d0d0',
        //lightBlack: '#808080',
        //lightRed: '#ff0000',
        //lightGreen: '#33ff00',
        //lightYellow: '#ffff00',
        //lightBlue: '#0066ff',
        //lightMagenta: '#cc00ff',
        //lightCyan: '#00ffff',
        //lightWhite: '#ffffff'
        //},

        colors: {
            black: '#0F111D',
            red: '#eb3d54',
            green: '#78bd65',
            yellow: '#e5cd52',
            blue: '#4fb4d8',
            magenta: '#C792EA',
            cyan: '#82AAFF',
            white: '#d0d0d0',
            lightBlack: '#808080',
            lightRed: '#eb3d54',
            lightGreen: '#78bd65',
            lightYellow: '#e5cd52',
            lightBlue: '#4fb4d8',
            lightMagenta: '#C792EA',
            lightCyan: '#82AAFF',
            lightWhite: '#ffffff'
        },

        // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
        // if left empty, your system's login shell will be used by default
        //
        // Windows
        // - Make sure to use a full path if the binary name doesn't work
        // - Remove `--login` in shellArgs
        //
        // Bash on Windows
        // - Example: `C:\\Windows\\System32\\bash.exe`
        //
        // Powershell on Windows
        // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
        shell: '/bin/zsh',

        // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
        // by default ['--login'] will be used
        shellArgs: ['--login'],

        // for environment variables
        env: {},

        // set to false for no bell
        bell: 'SOUND',

        // if true, selected text will automatically be copied to the clipboard
        copyOnSelect: false,

        //Hyperboarder config
        hyperBorder: {
            borderColors: ['#ea125e', '#6227ae'],
            borderWidth: '1px'
        },
        // //an-old-hype theme setting
        // themeSettings: {
        //     opacity: 0.94,
        //     style: 'vader'
        // },

        //Hyperline  Commented until hyper bring back support for hyperline
        //hyperline: {
        //plugins: [
        //"ip",
        //"cpu",
        //"spotify"
        //]
        //}

        hyperTabs: {
            trafficButtons: true,
            border: true,
            tabIconsColored: true,
            closeAlign: 'right',
        },
    },

    plugins: [
        //"hyperborder",
        //"hyperline",
        //"hyper-midnight",
        //"an-old-hype",
        //"hyperpanic",
        "hypercwd",
        "hyper-search",
        "hyper-final-say",
        "hyper-tabs-enhanced",
        "hyperterm-dibdabs"
    ],

    localPlugins: [],

    keymaps: {
        // Example
        // 'window:devtools': 'cmd+alt+o',
    }
};