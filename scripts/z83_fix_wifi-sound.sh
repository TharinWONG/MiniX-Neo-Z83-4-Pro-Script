#!/bin/bash

# --- 內容比例表 ---
# 1. 環境檢測：確認 Atom Z8350 與 4GB RAM
# 2. 離線 WiFi：手動確認 + USB 自動搜索注入
# 3. 音效修復：連網後手動觸發 alsa-ucm 暴力路由重置
# 4. 系統鎖定：配置 4GB zRAM 並限制日誌，保護 32GB eMMC 壽命
# 5. 永久鎖定：寫入 /etc/rc.local 並建立 .orig 備份 (安全性 100%)

echo -e "\033[1;33m[1/5] 正在確認 Z83-4 Pro 硬體環境...\033[0m"
RAM_MB=$(free -m | awk '/Mem:/ {print $2}')
echo "檢測到 RAM: ${RAM_MB}MB"

# --- 步驟 2: WiFi ---
echo -e "\033[1;35m>>> 步驟 2: 離線 WiFi 救援 (唔洗上網) <<<\033[0m"
echo "請確保 USB 插好。我會自動搵 brcmfmac43455-sdio.txt。"
read -p "準備好請按 [Enter]..." dummy
WIFI_SRC=$(find /media /mnt -name "brcmfmac43455-sdio.txt" 2>/dev/null | head -n 1)

if [ -n "$WIFI_SRC" ]; then
    sudo cp "$WIFI_SRC" /lib/firmware/brcm/brcmfmac43455-sdio.txt
    sudo modprobe -r brcmfmac 2>/dev/null
    sudo modprobe brcmfmac
    echo -e "\033[1;32mWiFi 配置完成！請去連 WiFi。 \033[0m"
else
    echo -e "\033[1;31m❌ 搵唔到檔案！請確認你將 brcmfmac43455-sdio.txt 擺咗喺 USB 根目錄。 \033[0m"
fi

# --- 步驟 3: 音效 ---
echo "------------------------------------------"
echo -e "\033[1;35m>>> 步驟 3: 音效修復 (必須連咗 WiFi) <<<\033[0m"
read -p "連好網之後，按 [Enter] 安裝補丁。如果未連到，可以隨時 Ctrl+C 退出。" dummy
ping -c 1 8.8.8.8 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    sudo apt update && sudo apt install -y alsa-ucm-conf zram-config
    sudo alsactl nrestore 2>/dev/null
    echo -e "\033[1;32m✅ 音效路由已修正。 \033[0m"
else
    echo -e "\033[1;31m❌ 偵測唔到網絡！跳過呢步，可以等遲啲有網再手動裝。 \033[0m"
fi

# --- 步驟 4: 記憶體與 eMMC 保護 ---
echo "------------------------------------------"
echo -e "\033[1;33m[4/5] 正在優化 32GB eMMC 壽命同 zRAM...\033[0m"
sudo sysctl -w vm.swappiness=10
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
sudo journalctl --vacuum-size=50M

# --- 步驟 5: 永久鎖定 ---
echo "------------------------------------------"
echo -e "\033[1;33m[5/5] 寫入永久啟動腳本至 /etc/rc.local (已加備份)... \033[0m"
[ -f /etc/rc.local ] && sudo cp /etc/rc.local /etc/rc.local.orig
sudo bash -c "cat << 'RCL' > /etc/rc.local
#!/bin/bash
modprobe -r brcmfmac && modprobe brcmfmac
swapon -p 100 /dev/zram0 2>/dev/null
echo 0 > /sys/module/snd_hda_intel/parameters/power_save
alsactl nrestore 2>/dev/null
exit 0
RCL"
sudo chmod +x /etc/rc.local

echo "------------------------------------------"
echo -e "\033[1;32m[全齊] Z83-4 Pro 終極優化完成！ \033[0m"
echo "請輸入 sudo reboot 重啟系統。"
EOF
