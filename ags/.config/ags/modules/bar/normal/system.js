// This is for the right pills of the bar.
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
const { Box, Label, Button, Overlay, Revealer, Scrollable, Stack, EventBox } = Widget;
const { exec, execAsync } = Utils;
const { GLib } = imports.gi;
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import { MaterialIcon } from '../../.commonwidgets/materialicon.js';
import { AnimatedCircProg } from "../../.commonwidgets/cairo_circularprogress.js";
import { setupCursorHover } from '../../.widgetutils/cursorhover.js';

const BarBatteryProgress = () => {
    const _updateProgress = (circprog) => { // Set circular progress value
        circprog.css = `font-size: ${Math.abs(Battery.percent)}px;`

        circprog.toggleClassName('bar-batt-circprog-low', Battery.percent <= userOptions.battery.low);
        circprog.toggleClassName('bar-batt-circprog-full', Battery.charged);
    }
    return AnimatedCircProg({
        className: `bar-batt-circprog ${userOptions.appearance.borderless ? 'bar-batt-circprog-borderless' : ''}`,
        vpack: 'center', hpack: 'center',
        extraSetup: (self) => self
            .hook(Battery, _updateProgress)
        ,
    })
}

const time = Variable('', {
    poll: [
        userOptions.time.interval,
        () => GLib.DateTime.new_now_local().format(userOptions.time.format),
    ],
})

const date = Variable('', {
    poll: [
        userOptions.time.dateInterval,
        () => GLib.DateTime.new_now_local().format(userOptions.time.dateFormatLong),
    ],
})

const BarClock = () => Widget.Box({
    vpack: 'center',
    className: 'spacing-h-4 bar-clock-box',
    children: [
        Widget.Label({
            className: 'bar-time',
            label: time.bind(),
        }),
        Widget.Label({
            className: 'txt-norm txt-onLayer1',
            label: '•',
        }),
        Widget.Label({
            className: 'txt-smallie bar-date',
            label: date.bind(),
        }),
    ],
});

const UtilButton = ({ name, icon, onClicked }) => Button({
    vpack: 'center',
    tooltipText: name,
    onClicked: onClicked,
    className: `bar-util-btn ${userOptions.appearance.borderless ? 'bar-util-btn-borderless' : ''} icon-material txt-norm`,
    label: `${icon}`,
    setup: setupCursorHover
})

const Utilities = () => Box({
    hpack: 'center',
    className: 'spacing-h-4',
    children: [
        UtilButton({
            name: getString('Screen snip'), icon: 'screenshot_region', onClicked: () => {
                Utils.execAsync(`${App.configDir}/scripts/grimblast.sh copy area`)
                    .catch(print)
            }
        }),
        UtilButton({
            name: getString('Color picker'), icon: 'colorize', onClicked: () => {
                Utils.execAsync(['hyprpicker', '-a']).catch(print)
            }
        }),
        UtilButton({
            name: getString('Toggle on-screen keyboard'), icon: 'keyboard', onClicked: () => {
                toggleWindowOnAllMonitors('osk');
            }
        }),
    ]
})

const BarBattery = () => Box({
    className: 'spacing-h-4 bar-batt-txt',
    children: [
        Revealer({
            transitionDuration: userOptions.animations.durationSmall,
            revealChild: false,
            transition: 'slide_right',
            child: MaterialIcon('bolt', 'norm', { tooltipText: "Charging" }),
            setup: (self) => self.hook(Battery, revealer => {
                self.revealChild = Battery.charging;
            }),
        }),
        Label({
            className: 'txt-smallie',
            setup: (self) => self.hook(Battery, label => {
                label.label = `${Number.parseFloat(Battery.percent.toFixed(1))}%`;
            }),
        }),
        Overlay({
            child: Widget.Box({
                vpack: 'center',
                className: 'bar-batt',
                homogeneous: true,
                children: [
                    MaterialIcon('battery_full', 'small'),
                ],
                setup: (self) => self.hook(Battery, box => {
                    box.toggleClassName('bar-batt-low', Battery.percent <= userOptions.battery.low);
                    box.toggleClassName('bar-batt-full', Battery.charged);
                }),
            }),
            overlays: [
                BarBatteryProgress(),
            ]
        }),
    ]
});

const BarGroup = ({ child }) => Widget.Box({
    className: 'bar-group-margin bar-sides',
    children: [
        Widget.Box({
            className: `bar-group${userOptions.appearance.borderless ? '-borderless' : ''} bar-group-standalone bar-group-pad-system`,
            children: [child],
        }),
    ]
});
const BatteryModule = () => Stack({
    transition: 'slide_up_down',
    transitionDuration: userOptions.animations.durationLarge,
    children: {
        'laptop': Box({
            className: 'spacing-h-4', children: [
                BarGroup({ child: Utilities() }),
                BarGroup({ child: BarBattery() }),
            ]
        }),
        'desktop': Box({
            className: 'spacing-h-4', children: [
                BarGroup({ child: Utilities() }),
            ]
        }),
    },
    setup: (stack) => Utils.timeout(10, () => {
        if (!Battery.available) stack.shown = 'desktop';
        else stack.shown = 'laptop';
    })
})

const switchToRelativeWorkspace = async (self, num) => {
    try {
        const Hyprland = (await import('resource:///com/github/Aylur/ags/service/hyprland.js')).default;
        Hyprland.messageAsync(`dispatch workspace r${num > 0 ? '+' : ''}${num}`).catch(print);
    } catch {
        execAsync([`${App.configDir}/scripts/sway/swayToRelativeWs.sh`, `${num}`]).catch(print);
    }
}

export default () => Widget.EventBox({
    onScrollUp: (self) => switchToRelativeWorkspace(self, -1),
    onScrollDown: (self) => switchToRelativeWorkspace(self, +1),
    onPrimaryClick: () => App.toggleWindow('sideright'),
    child: Widget.Box({
        className: 'spacing-h-4',
        children: [
            BarGroup({ child: BarClock() }),
            BatteryModule(),
        ]
    })
});
