#!/bin/bash

# --- 內容比例表 ---
# 1. 自動備份：/etc/default/grub.orig (出事可以隨時還原)
# 2. 暴力拔除：移除 quiet splash，換成 Atom 穩定參數
# 3. 倒數鎖定：5 秒自動啟動，無視上次是否死機
# 4. 文字模式：強制 Terminal Console 模式噴字
# 5. 永久更新：sudo update-grub 寫入系統

echo -e "\033[1;33m[1/5] 正在備份啟動配置...\033[0m"
[ -f /etc/default/grub ] && sudo cp /etc/default/grub /etc/default/grub.orig

echo -e "\033[1;33m[2/5] 拔除轉圈圈，改為 Verbose 噴字模式...\033[0m"
# 暴力替換：確保 nomodeset 同 intel_idle 參數喺度，防止 Atom 睡死
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="nomodeset intel_idle.max_cstate=1"/' /etc/default/grub

echo -e "\033[1;33m[3/5] 設定 5 秒自動倒數 (無視 Recordfail)... \033[0m"
sudo sed -i 's/GRUB_TIMEOUT=[0-9]*/GRUB_TIMEOUT=5/' /etc/default/grub
# 加入 Recordfail 鎖定，防止卡死後停喺選單
if ! grep -q "GRUB_RECORDFAIL_TIMEOUT" /etc/default/grub; then
    echo "GRUB_RECORDFAIL_TIMEOUT=5" | sudo tee -a /etc/default/grub
fi

echo -e "\033[1;33m[4/5] 鎖定純文字終端 (禁止 Logo 啟動)... \033[0m"
sudo sed -i 's/#GRUB_TERMINAL=console/GRUB_TERMINAL=console/' /etc/default/grub

echo -e "\033[1;33m[5/5] 正在更新 GRUB 寫入硬盤...\033[0m"
sudo update-grub

echo "------------------------------------------"
echo -e "\033[1;32m[全齊] Z83-4 暴力自動開機配置完成！ \033[0m"
echo "重啟後：見選單倒數 5 秒 -> 自動噴白字 -> 直入桌面。"
echo "請輸入: sudo reboot"
EOF
