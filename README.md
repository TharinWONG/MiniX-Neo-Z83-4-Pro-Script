# MiniX Neo `Z83 4` & `Pro` Script
此腳本由Gemini AI生成，本人是Linux 小白，不會複雜命令。如果內容跟實際情況有誤差，敬請見諒

---

## [1] 把 **轉圈圈載入畫面** 改為 **Verbose噴字** 模式
### 針對 **轉圈圈一直卡住載入畫面** 問題
既然進不去桌面，我們要在開機的一瞬間攔截它：
1.  先把 **`.sh`** 執行檔移動到USB
1.  **強制重啟**：長按電源鍵關機，再開機。
1.  **進入 GRUB 選單**：在看到電腦品牌 Logo 時，瘋狂按 **`Esc`**（或 `Shift`）。
1.  **進入編輯模式**：看到選單後，選中第一項 `Linux Mint 22.3 Cinnamon/Xfce`，然後按鍵盤上的 **`e`** 進入編輯。
1.  **啟動**：按 **`Ctrl + X`** 或 **`F10`**。
1.  如成功進入桌面後，把 **`z834_fix_boot.sh`** 執行檔放在桌面，右鍵選Terminal，
    然後輸入： **`chmod +x z834_fix_boot.sh`** 和 **`sudo ./z834_fix_boot.sh`** 命令。
    ```
    chmod +x final_z83_auto_boot.sh
    sudo ./final_z83_auto_boot.sh
    ```
1.  樣就能解決，一直卡住載入LOGO不會進入桌面問題。就能 **把轉圈圈載入畫面改為Verbose噴字模式** 。

---

## [2] 離線修復 WiFi 驅動 和 修復音效 ^如適用
### 不用修請在被詢問是否繼續下一步 `Enter` 之前按 **`Ctrl C`** 中止執行音效修復

因為 **Z83-4** 安裝完 Linux 之後通常是**完全沒有 WiFi** 的，如果你不先搞定 WiFi，你根本沒辦法上網下載任何東西。所以這份腳本的設計邏輯是：

1.  你先用另一台電腦下載好 **[brcmfmac43455-sdio.txt](https://raw.githubusercontent.com/reMarkable/brcmfmac-firmware/refs/heads/master/brcmfmac43455-sdio.txt)** 驅動設定檔 和 下載 **`z834_fix_wifi-sound.sh`** 。
1.  將兩個檔案放入 **USB 隨身碟** 放在 USB 的根目錄裡面。
1.  插上 Z83-4 主機，然後執行這份 **`z834_fix_wifi-sound.sh`** 腳本
1.  把 **`z834_fix_wifi-sound.sh`** 執行檔放在桌面，右鍵選Terminal，然後輸入： **`chmod +x z834_fix_wifi-sound.sh`** 和 **`sudo ./z834_fix_wifi-sound.sh`** 命令。
    ```
    chmod +x z834_fix_wifi-sound.sh
    sudo ./z834_fix_wifi-sound.sh
    ```
1.  腳本會自動在 USB 隨身碟裡面**「搜尋」**這個檔案並直接注入系統。

---

- 為什麼會把`MiniX Neo Z83-4 Pro`把它 `Windows 10 Pro` 系統換成 `Linux Mint 22.3`?
  - 因本機給家人使用 `Windows 10` 長期處於空間不足，決定嘗試安裝`Linux Mint 22.3 XCFE` 版本。
  - 但是安裝好系統，有一個問題解釋不到，也找不到解決方法，連Gemini AI 的腳本也沒辦法解決
```diff
- Mini PC 插入HDMI聽不到電視發出的聲音，只能用3.5mm插在Speaker收聽。
```
- 請教了Gemini  AI 解決不到，看有沒有人能幫我解決這個問題。

---

### 我當時的Z83-4 Pro Mini PC是官方贊助。
> MiniX Neo Z83-4 Pro 是 2017年那時 香港MINIX總部有職員以Mail經Youtube Channel聯絡我。
> 當期時還在讀高中因個人無聊喜歡玩冷門的研究(怎樣用Kodi安裝和那些教程影片)，正好當時是樂視盒子和Kodi興起時期。
> 我的影片大多數沒有聲音，影片剪輯跟現在的剪片技術一樣屎(劣差)，但有一眾曾經支持過我的觀眾。
> 在MAIL約見 這樣就開始了，0$收入用他們產品贊助方式去錄製國中品質影片。
> (沒合作之後才知道很多人都會收取費用拍攝，當時我太年輕了，而且沒有想太多 XD 只是為了好奇和興趣研究...)
