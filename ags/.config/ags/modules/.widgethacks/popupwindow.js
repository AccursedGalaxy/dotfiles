import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
const { Box, Window } = Widget;


export default ({
    name,
    child,
    showClassName = "",
    hideClassName = "",
    ...props
}) => {
    return Window({
        name,
        visible: false,
        layer: 'top',
        attribute: {
            'stayVisible': false,
            'isFocused': false,
        },
        ...props,
        
        setup: (self) => {
            // Set up focus change tracking for the stayVisible feature
            App.connect('window-toggled', (_, winName, visible) => {
                // If we're this window and we're being hidden but should stay visible
                if (winName === name && !visible && self.attribute.stayVisible) {
                    // Small delay to avoid interfering with the toggle
                    Utils.timeout(50, () => {
                        App.openWindow(name);
                        // Make it non-focusable when it's in pin mode
                        Utils.timeout(100, () => {
                            self.attribute.isFocused = false;
                            self.set_accept_focus(false);
                            self.set_focusable(false);
                            self.lower();
                        });
                    });
                }
            });

            // Set up focus handling
            self.connect('focus-in-event', () => {
                self.attribute.isFocused = true;
                self.set_accept_focus(true);
                self.set_focusable(true);
                return false;
            });

            self.connect('focus-out-event', () => {
                self.attribute.isFocused = false;
                // If pinned and not focused, make it passive
                if (self.attribute.stayVisible) {
                    self.set_accept_focus(false);
                    self.set_focusable(false);
                }
                return false;
            });

            // Set up click handler to make window active again if clicked while passive
            self.connect('button-press-event', () => {
                if (!self.attribute.isFocused && self.attribute.stayVisible) {
                    self.set_accept_focus(true);
                    self.set_focusable(true);
                    self.present();
                    self.attribute.isFocused = true;
                    return true;
                }
                return false;
            });
        },

        child: Box({
            setup: (self) => {
                self.keybind("Escape", () => App.closeWindow(name));
                if (showClassName != "" && hideClassName !== "") {
                    self.hook(App, (self, currentName, visible) => {
                        if (currentName === name) {
                            self.toggleClassName(hideClassName, !visible);
                        }
                    });

                    if (showClassName !== "" && hideClassName !== "")
                        self.className = `${showClassName} ${hideClassName}`;
                }
            },
            child: child,
        }),
    });
}