# FetchMe - System Information Fetcher

## Overview
**FetchMe** is a simple system information fetcher that provides useful details about your system. It is designed to run as a **one-shot systemd service**, ensuring that it executes once and does not continuously restart. The installation script automates the setup, making it easy for users to deploy and use FetchMe.

## Features
- Fetches essential system information.
- Runs as a **one-shot** systemd service.
- Automatically installs and sets up systemd service for easy execution.
- Creates a symbolic link for easier access.
- Logs execution details for debugging and verification.

## Installation
To install FetchMe, follow these steps:

### 1️⃣ Download the Repository
```bash
git clone https://github.com/mradulnatani/fetchme.git
cd fetchme
```

### 2️⃣ Run the Installation Script
Make sure you have **sudo** privileges before running the script.

```bash
chmod +x install_fetchme.sh
sudo ./install_fetchme.sh
```

### 3️⃣ Verify Installation
To check if FetchMe was installed correctly, run:
```bash
fetchme
```
If FetchMe is correctly set up, it should display system information.

## Usage
Once installed, FetchMe can be executed in two ways:

### Run Manually
```bash
fetchme
```

### Check Logs
To view the latest execution logs:
```bash
journalctl -u fetchme --no-pager --lines=20
```

## Uninstallation
If you want to remove FetchMe from your system, follow these steps:
```bash
sudo systemctl stop fetchme.service
sudo systemctl disable fetchme.service
sudo rm -f /etc/systemd/system/fetchme.service
sudo rm -f /usr/local/bin/fetchme
sudo rm -f /usr/bin/fetchme
sudo systemctl daemon-reload
```

## Troubleshooting
- **FetchMe command not found?**
  - Ensure the script has been executed correctly.
  - Try reloading systemd: `sudo systemctl daemon-reload`
- **Service not running?**
  - Check the logs: `journalctl -u fetchme --no-pager`
  - Start the service manually: `sudo systemctl start fetchme.service`

## License
This project is licensed under the MIT License.

## Contributors
- **Your Name** - Mradul Natani

## Contact
For any issues or suggestions, please open an issue on GitHub or reach out via email.

![FetchMe Screenshot](https://github.com/mradulnatani/fetchme/blob/main/Screenshot_29-Mar_02-33-46_6189.png?raw=true)


