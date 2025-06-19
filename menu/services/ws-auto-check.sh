#!/bin/bash
echo "=== STATUS WEBSOCKET (SOCAT) ==="
for port in 80 8880 8080 2082 2096; do
    if systemctl is-active --quiet dropbear-ws@${port}; then
        echo "✔️  WS aktif di port $port"
    else
        echo "❌  WS TIDAK aktif di port $port"
    fi
done

echo ""
echo "=== STATUS DROPBEAR ==="
if systemctl is-active --quiet dropbear; then
    echo "✔️  Dropbear aktif"
else
    echo "❌  Dropbear TIDAK aktif"
fi

echo ""
echo "=== CEK PORT DROPBEAR ==="
ss -tunlp | grep dropbear || echo "Tidak ditemukan proses dropbear aktif."

echo ""
echo "=== CEK PORT SOCAT ==="
ss -tunlp | grep socat || echo "Tidak ditemukan proses socat aktif."
