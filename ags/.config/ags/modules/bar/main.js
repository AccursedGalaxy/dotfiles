const { Gtk } = imports.gi;
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';

import WindowTitle from "./normal/spaceleft.js";
import Indicators from "./normal/spaceright.js";
import Music from "./normal/music.js";
import System from "./normal/system.js";
import { enableClickthrough } from "../.widgetutils/clickthrough.js";
import { RoundedCorner } from "../.commonwidgets/cairo_roundedcorner.js";
import { currentShellMode } from '../../variables.js';

const NormalOptionalWorkspaces = async () => {
    try {
        return (await import('./normal/workspaces_hyprland.js')).default();
    } catch {
        try {
            return (await import('./normal/workspaces_sway.js')).default();
        } catch {
            return null;
        }
    }
};

const FocusOptionalWorkspaces = async () => {
    try {
        return (await import('./focus/workspaces_hyprland.js')).default();
    } catch {
        try {
            return (await import('./focus/workspaces_sway.js')).default();
        } catch {
            return null;
        }
    }
};

export const Bar = async (monitor = 0) => {
    const SideModule = (children) => Widget.Box({
        className: 'bar-sidemodule',
        children: children,
    });
    
    // Prepare content modules
    const windowTitleContent = await WindowTitle(monitor);
    const workspacesContent = await NormalOptionalWorkspaces();
    const focusWorkspacesContent = await FocusOptionalWorkspaces();
    const musicContent = Music();
    const systemContent = System();
    const indicatorsContent = Indicators(monitor);
    
    // Create all three separate bar windows with identical structure
    const leftBar = Widget.Window({
        monitor,
        name: `bar-left-${monitor}`,
        anchor: ['top', 'left'],
        exclusivity: 'exclusive',
        visible: true,
        margins: [10, 10, 0, 10], // [top, right, bottom, left]
        child: Widget.Stack({
            homogeneous: false,
            transition: 'slide_up_down',
            transitionDuration: userOptions.animations.durationLarge,
            children: {
                'normal': Widget.Box({
                    className: 'bar-bg bar-floating',
                    children: [windowTitleContent],
                }),
                'focus': Widget.Box({
                    className: 'bar-bg-focus bar-floating',
                    children: [Widget.Box({})],
                }),
                'nothing': Widget.Box({
                    className: 'bar-bg-nothing bar-floating',
                }),
            },
            setup: (self) => self.hook(currentShellMode, (self) => {
                self.shown = currentShellMode.value[monitor];
            })
        }),
    });

    const centerBar = Widget.Window({
        monitor,
        name: `bar-center-${monitor}`,
        anchor: ['top'],
        exclusivity: 'exclusive',
        visible: true,
        margins: [10, 10, 0, 10], // [top, right, bottom, left]
        child: Widget.Stack({
            homogeneous: false,
            transition: 'slide_up_down',
            transitionDuration: userOptions.animations.durationLarge,
            children: {
                'normal': Widget.Box({
                    className: 'bar-bg bar-floating',
                    halign: 'center',
                    children: [
                        Widget.Box({
                            className: 'spacing-h-4',
                            children: [
                                SideModule([musicContent]),
                                Widget.Box({
                                    homogeneous: true,
                                    children: [workspacesContent],
                                }),
                                SideModule([systemContent]),
                            ]
                        })
                    ],
                }),
                'focus': Widget.Box({
                    className: 'bar-bg-focus bar-floating',
                    halign: 'center',
                    children: [
                        Widget.Box({
                            className: 'spacing-h-4',
                            children: [
                                SideModule([]),
                                Widget.Box({
                                    homogeneous: true,
                                    children: [focusWorkspacesContent],
                                }),
                                SideModule([]),
                            ]
                        })
                    ],
                    setup: (self) => {
                        self.hook(Battery, (self) => {
                            if (!Battery.available) return;
                            self.toggleClassName('bar-bg-focus-batterylow', Battery.percent <= userOptions.battery.low);
                        })
                    }
                }),
                'nothing': Widget.Box({
                    className: 'bar-bg-nothing bar-floating',
                }),
            },
            setup: (self) => self.hook(currentShellMode, (self) => {
                self.shown = currentShellMode.value[monitor];
            })
        }),
    });

    const rightBar = Widget.Window({
        monitor,
        name: `bar-right-${monitor}`,
        anchor: ['top', 'right'],
        exclusivity: 'exclusive',
        visible: true,
        margins: [10, 10, 0, 10], // [top, right, bottom, left]
        child: Widget.Stack({
            homogeneous: false,
            transition: 'slide_up_down',
            transitionDuration: userOptions.animations.durationLarge,
            children: {
                'normal': Widget.Box({
                    className: 'bar-bg bar-floating',
                    children: [indicatorsContent],
                }),
                'focus': Widget.Box({
                    className: 'bar-bg-focus bar-floating',
                    children: [Widget.Box({})],
                }),
                'nothing': Widget.Box({
                    className: 'bar-bg-nothing bar-floating',
                }),
            },
            setup: (self) => self.hook(currentShellMode, (self) => {
                self.shown = currentShellMode.value[monitor];
            })
        }),
    });

    // Return an array of the three bar windows
    return [leftBar, centerBar, rightBar];
}

export const BarCornerTopleft = (monitor = 0) => Widget.Window({
    monitor,
    name: `barcornertl${monitor}`,
    layer: 'top',
    anchor: ['top', 'left'],
    exclusivity: 'normal',
    visible: false,
    child: RoundedCorner('topleft', { className: 'corner', }),
    setup: enableClickthrough,
});
export const BarCornerTopright = (monitor = 0) => Widget.Window({
    monitor,
    name: `barcornertr${monitor}`,
    layer: 'top',
    anchor: ['top', 'right'],
    exclusivity: 'normal',
    visible: false,
    child: RoundedCorner('topright', { className: 'corner', }),
    setup: enableClickthrough,
});
