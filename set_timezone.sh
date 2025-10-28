#!/bin/bash
# Script tự động set timezone container khi start

# Chọn timezone
TIMEZONE=${TIMEZONE:-Asia/Seoul}

# Cài tzdata nếu chưa có
if ! command -v timedatectl &> /dev/null; then
    echo "Installing tzdata..."
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
fi

# Thiết lập timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo $TIMEZONE > /etc/timezone

# Thông báo
echo "Timezone set to $TIMEZONE"
date
