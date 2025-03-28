#!/bin/bash

set -e  # Exit on error

if [[ -f ./fetchme ]]; then
    sudo mv ./fetchme /usr/local/bin/fetchme
fi
sudo chmod +x /usr/local/bin/fetchme

SERVICE_FILE="/etc/systemd/system/fetchme.service"

# Create or overwrite systemd service file
sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=FetchMe System Info Command
After=network.target

[Service]
ExecStart=/usr/local/bin/fetchme
Type=oneshot
RemainAfterExit=true
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 644 "$SERVICE_FILE"

# Reload systemd and start the service
sudo systemctl daemon-reload
sudo systemctl start fetchme.service

# Create a symlink in /usr/bin for easy execution
if [[ ! -L /usr/bin/fetchme ]]; then
    sudo ln -s /usr/local/bin/fetchme /usr/bin/fetchme
fi

# Display logs to confirm successful execution
journalctl -u fetchme --no-pager --lines=20
