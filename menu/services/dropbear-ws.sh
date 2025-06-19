#!/bin/bash

# Install socat jika belum ada
apt install -y socat

# Buat ulang dropbear-ws@.service
cat > /etc/systemd/system/dropbear-ws@.service << EOF
[Unit]
Description=Dropbear WebSocket via socat on port %%i
After=network.target

[Service]
ExecStart=/usr/bin/socat TCP-LISTEN:%%i,reuseaddr,fork TCP:127.0.0.1:109
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd dan aktifkan port
systemctl daemon-reexec
systemctl daemon-reload

ports=(80 8880 8080 2082 2096)
for port in "${ports[@]}"; do
    systemctl enable --now dropbear-ws@${port}
done
