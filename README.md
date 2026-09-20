# Extra applets for the g13 driver

An applet is the definition of a screen: where each widget sits on the pad's 160x43 display, and which value feeds
it. The driver ships twelve of them and they arrive with it, so this repository is only for the ones that need
something else installed, or that only make sense with one particular game.

| applet | what it draws | what it needs |
|---|---|---|
| [`cp2077-hud`](applets/cp2077-hud.json) | Cyberpunk 2077's health, stamina, level, street cred, objective, district and heading | Cyberpunk 2077 with Cyber Engine Tweaks, and [g13-hud](https://github.com/npc-nathan/g13-hud) to write the game's numbers out |

## Installing one

1. Copy the applet into your config folder: `~/.config/g13/applets/` (create it if it is not there).
2. If it contains a `{GAME}`, replace that with the folder your game is installed in - the one holding
   `Cyberpunk2077.exe`. `cp2077-hud` carries it in every source, and
   [g13-hud's installer](https://github.com/npc-nathan/g13-hud) does the substitution for you.
3. Open the g13 window, go to the **Menu** tab, tick **on the pad** for the applet, and the pad walks to it with
   **LR** - the same as any screen the driver ships.

Check one before you rely on it, with the driver's own checker:

```bash
g13 applet check cp2077-hud
# cp2077-hud checks out: 6 widget(s), 2 screens, every source answered.
```

## Writing one

The quickest way is the window: the **Applets** tab has an inspector and a field grid, so a screen can be built and
previewed on the pad before it is saved. Every applet that ships with the driver is also a plain JSON file in
`/usr/share/g13/defaults/applets/`, which is a reasonable thing to copy and edit.

Whatever you start from, the rules this repository checks are the same ones the driver applies:

- one file per applet, named after its own `name` field: `cp2077-hud.json` defines `"name": "cp2077-hud"`
- it parses, and every source it names is a form the driver knows (`json:`, `file:`, `cmd:`, `http:`, …)
- `./check.sh` passes, which is what CI runs

## Adding one here

Copy your applet into `applets/`, run `./check.sh`, and open a pull request. An applet that needs another program or
mod should say so in this README's table, in the same words the applet itself would.

## Licence

MIT OR Apache-2.0 - see [LICENSE-MIT](LICENSE-MIT) and [LICENSE-APACHE](LICENSE-APACHE). The same as the driver, and
the same as the mods these applets are written for.

## The three pieces

This repository is one of three that go together:

| repository | what it is |
|---|---|
| [logitech-g13-linux-driver](https://github.com/npc-nathan/logitech-g13-linux-driver) | the driver: it reads the pad, sends keys, draws on the 160x43 screen, and configures it from a window - **install this first**, it is what draws any of these applets |
| **[logitech-g13-applets](https://github.com/npc-nathan/logitech-g13-applets)** | **this one** - extra screens for the pad, the ones that need something else installed to be worth drawing |
| [g13-hud](https://github.com/npc-nathan/g13-hud) | Cyberpunk 2077's health, objective and district, written out by a Cyber Engine Tweaks mod for the driver to draw |

An applet is only the definition of a screen: without the program or mod it reads from, it draws a gap rather than
a number, which is why each one here says what it needs.
