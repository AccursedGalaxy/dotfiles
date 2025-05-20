import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';

import { MaterialIcon } from './materialicon.js';

// Notification indicator from the original file
export const NotificationIndicator = (notifCenterName = 'sideright') => {
    const widget = Widget.Revealer({
        transition: 'slide_left',
        transitionDuration: userOptions.animations.durationSmall,
        revealChild: false,
        setup: (self) => self
            .hook(Notifications, (self, id) => {
                if (!id || Notifications.dnd) return;
                if (!Notifications.getNotification(id)) return;
                self.revealChild = true;
            }, 'notified')
            .hook(App, (self, currentName, visible) => {
                if (visible && currentName === notifCenterName) {
                    self.revealChild = false;
                }
            }),
        child: Widget.Box({
            children: [
                MaterialIcon('notifications', 'norm'),
                Widget.Label({
                    className: 'txt-small titlefont',
                    attribute: {
                        unreadCount: 0,
                        update: (self) => self.label = `${self.attribute.unreadCount}`,
                    },
                    setup: (self) => self
                        .hook(Notifications, (self, id) => {
                            if (!id || Notifications.dnd) return;
                            if (!Notifications.getNotification(id)) return;
                            self.attribute.unreadCount++;
                            self.attribute.update(self);
                        }, 'notified')
                        .hook(App, (self, currentName, visible) => {
                            if (visible && currentName === notifCenterName) {
                                self.attribute.unreadCount = 0;
                                self.attribute.update(self);
                            }
                        }),
                })
            ]
        })
    });
    return widget;
};

// Microphone indicator from the original file
export const MicMuteIndicator = () => Widget.Revealer({
    transition: 'slide_left',
    transitionDuration: userOptions.animations.durationSmall,
    revealChild: false,
    setup: (self) => self.hook(Audio, (self) => {
        self.revealChild = Audio.microphone?.stream?.isMuted;
    }),
    child: MaterialIcon('mic_off', 'norm'),
});

// New system indicator that shows a "dashboard" or "settings" icon
export const SystemMenuIndicator = () => Widget.Box({
    className: 'spacing-h-5',
    children: [
        MaterialIcon('dashboard', 'norm', { tooltipText: 'System Dashboard' }),
    ]
});

// New CPU/memory indicator
export const SystemResourceIndicator = () => {
    const cpuIcon = MaterialIcon('memory', 'norm', { tooltipText: 'CPU/Memory Status' });
    
    // Poll system stats periodically
    return Widget.Box({
        className: 'spacing-h-5',
        children: [cpuIcon],
        setup: (self) => self.poll(10000, () => {
            // We're not actually updating anything here, just showing the icon
            // You could update the icon or add a label with actual CPU usage if desired
        }),
    });
};

// Main export - replaces the original StatusIcons
export const CustomStatusIcons = (props = {}, monitor = 0) => Widget.Box({
    ...props,
    child: Widget.Box({
        className: 'spacing-h-15',
        children: [
            MicMuteIndicator(),
            NotificationIndicator(),
            SystemResourceIndicator(),
            SystemMenuIndicator(),
        ]
    })
}); 