#!/bin/bash

# Pastikan socat terpasang
apt install -y socat

# Buat systemd service template untuk WebSocket dropbear
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

# Reload systemd
systemctl daemon-reexec
systemctl daemon-reload

# Daftar port WebSocket
ports=(80 8880 8080 2082 2096)

# Aktifkan service per port
for port in "${ports[@]}"; do
    echo "Aktifkan dropbear-ws di port $port"
    systemctl enable --now dropbear-ws@$port
done
