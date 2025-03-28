#!/bin/bash

set -e  

if [[ ! -f /usr/local/bin/fetchme ]]; then
    sudo mv fetchme /usr/local/bin/fetchme
fi
sudo chmod +x /usr/local/bin/fetchme

# Create systemd service file
SERVICE_FILE="/etc/systemd/system/fetchme.service"

echo "[Unit]
Description=FetchMe System Info Command
After=network.target

[Service]
ExecStart=/usr/local/bin/fetchme
Type=simple
StandardOutput=journal
StandardError=journal
Restart=always

[Install]
WantedBy=default.target" | sudo tee $SERVICE_FILE > /dev/null

# Reload systemd, enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable fetchme.service
sudo systemctl start fetchme.service

# Create a symlink in /usr/bin for easy execution
if [[ ! -f /usr/bin/fetchme ]]; then
    sudo ln -s /usr/local/bin/fetchme /usr/bin/fetchme
fi

# Display logs to confirm successful execution
journalctl -u fetchme --no-pager --lines=20
