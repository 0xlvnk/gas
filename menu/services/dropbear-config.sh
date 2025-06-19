#!/bin/bash
cat > /etc/default/dropbear << EOF
NO_START=0
DROPBEAR_PORT=127.0.0.1:109
DROPBEAR_EXTRA_ARGS="-p 127.0.0.1:143 -p 127.0.0.1:69 -p 127.0.0.1:222 -p 127.0.0.1:777"
EOF

systemctl restart dropbear
