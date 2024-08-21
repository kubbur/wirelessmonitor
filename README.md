# Wireless Monitor

This project provides a script and service to monitor your Raspberry Pi's desktop, stream it, and cast it to a Chromecast.

## Features

- Streams desktop activity to a Chromecast
- Automatically starts on boot with systemd
- Simple setup and configuration

## Installation

1. Copy the `wirelessmonitor.sh` script to `/usr/local/bin/`.
2. Copy the `wirelessmonitor.service` file to `/etc/systemd/system/`.
3. Reload systemd with `sudo systemctl daemon-reload`.
4. Enable the service with `sudo systemctl enable wirelessmonitor`.
5. Start the service with `sudo systemctl start wirelessmonitor`.

## Usage

The service will automatically start on boot. To manually control the service:

- Start: `sudo systemctl start wirelessmonitor`
- Stop: `sudo systemctl stop wirelessmonitor`
- Restart: `sudo systemctl restart wirelessmonitor`

## License

[Your preferred license]
