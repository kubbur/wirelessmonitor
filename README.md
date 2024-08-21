## Wireless Monitor

Wireless Monitor is a script designed to stream the Raspberry Pi desktop to a Chromecast. It also supports streaming to other devices via HTTP.

### Prerequisites

The following dependencies are required:
- `VLC`
- `FFmpeg`
- `Python3`

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kubbur/wirelessmonitor.git
   cd wirelessmonitor
   ```

2. Run the setup script:
   ```bash
   sudo ./install.sh
   ```
   The script will:
   - Install necessary dependencies.
   - Set up the `wirelessmonitor.sh` script and service.
   - Configure the system to run the service automatically at startup.

### Configuration

Before running the script, update the `CHROMECAST_IP` variable in the `wirelessmonitor.sh` script:
```bash
CHROMECAST_IP="your_chromecast_ip_here"
```

### Managing the Service

To manage the service, use the following commands:
- **Start the service:** `sudo systemctl start wirelessmonitor`
- **Stop the service:** `sudo systemctl stop wirelessmonitor`
- **Restart the service:** `sudo systemctl restart wirelessmonitor`
- **Enable the service at startup:** `sudo systemctl enable wirelessmonitor`
- **Disable the service at startup:** `sudo systemctl disable wirelessmonitor`

### Troubleshooting

Common issues and their solutions will be documented here.

### Contributing

Feel free to submit issues and pull requests to help improve the project.

### License

This project is licensed under the MIT License.
