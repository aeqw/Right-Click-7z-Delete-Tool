# Right-Click 7z & Delete Tool (右鍵選單 7z 壓縮並刪除工具)

這是一個輕量級、可攜的 Windows 小工具，可以為您的滑鼠右鍵選單新增一個「加入壓縮檔(.7z)並刪除」的功能。對於需要快速封存並清理專案檔案、日誌或任何資料的使用者來說，這是一個非常實用的效率工具。

This is a lightweight, portable utility for Windows that adds a "Compress to .7z & Delete" option to the context menu. It's a handy tool for users who need to quickly archive and clean up project files, logs, or any other data.

![示意圖](./Right-Click-7z-Delete-Tool.jpg)

---

## ✨ 功能特色 (Features)

* **一鍵操作**：在選取的檔案或資料夾上點擊右鍵，即可完成壓縮與刪除。
* **極致輕量**：使用 7-Zip 的極簡核心版 `7zr.exe`，不依賴任何大型程式。
* **完全可攜**：整個工具包可以放在任何地方，包括 USB 隨身碟，隨插即用。
* **靜默執行**：壓縮過程在背景執行，不會跳出任何干擾視窗。
* **安全可靠**：具備錯誤處理機制，只有在壓縮成功後才會刪除來源檔案。
* **乾淨卸載**：提供反安裝腳本，可以一鍵清除在系統中建立的右鍵選單。

---

## 📂 檔案結構 (File Structure)

這個工具包由以下 4 個檔案組成：

* **`7zr.exe`**: 7-Zip 壓縮引擎 (The compression engine)
* **`zip_and_delete.vbs`**: 核心功能腳本 (The core logic script)
* **`Install_Menu.bat`**: 安裝右鍵選單 (The installer)
* **`Uninstall_Menu.bat`**: 移除右鍵選單 (The uninstaller)

---

## 🚀 如何使用 (How to Use)

### 1. 首次安裝 (First-time Setup)

1.  將這四個檔案 (`7zr.exe`, `zip_and_delete.vbs`, `Install_Menu.bat`, `Uninstall_Menu.bat`) 放在同一個資料夾內。
2.  將這個資料夾移動到您打算長期存放的位置 (例如 `D:\Tools\7z-Util`)。
3.  在 `Install_Menu.bat` 檔案上**點擊右鍵**，選擇「**以系統管理員身分執行**」。
4.  在跳出的確認視窗中點擊「是」。
5.  安裝完成！右鍵選單中現在應該會出現「加入壓縮檔(.7z)並刪除」的選項。

### 2. 日常使用 (Daily Use)

1.  選取一個或多個您想要壓縮的檔案或資料夾。
2.  點擊右鍵，選擇「**加入壓縮檔(.7z)並刪除**」。
3.  滑鼠游標會短暫顯示忙碌狀態，隨後壓縮檔會出現在同一個目錄下，而原始檔案會被自動刪除。

### 3. 移除工具 (Uninstall)

1.  在 `Uninstall_Menu.bat` 檔案上**點擊右鍵**，選擇「**以系統管理員身分執行**」。
2.  右鍵選單中的選項將會被乾淨地移除。
3.  之後您可以隨時刪除整個工具資料夾。

---

### ⚠️ 已知限制與解決方案 (Known Limitations & Workaround)

* **問題**：對於某些受 Windows 系統高度整合的檔案類型（例如 `.img`, `.iso` 等磁碟映像檔），雖然本工具的選項會出現在右鍵選單中，但點擊後**可能不會執行壓縮，而是觸發系統預設的「開啟」或「掛載」動作**。這是因為這些檔案類型的預設動作，擁有比本工具更高的執行優先級。
* **解決方案**：遇到這種情況時，最簡單的方法是：**建立一個新資料夾，將該檔案移入資料夾中，然後對該資料夾點擊右鍵**，即可使用本工具進行壓縮。

---

## 🛠️ 技術細節 (Technical Details)

* **核心引擎**：使用 `7zr.exe`，這是 7-Zip 的獨立命令列版本，僅支援 `.7z` 格式，體積最小。
* **主要邏輯**：由 `zip_and_delete.vbs` 腳本驅動。它負責接收右鍵選單傳來的檔案路徑、組合 7-Zip 指令、在背景執行壓縮，並根據執行結果決定是否刪除來源檔案。
* **系統整合**：`Install_Menu.bat` 和 `Uninstall_Menu.bat` 透過修改 Windows 登錄檔 (`HKEY_CLASSES_ROOT`) 來動態新增或移除右鍵選單的項目。

---

## 致謝 (Acknowledgements)

本工具的核心壓縮功能由 `7zr.exe` 提供，該程式來自於 [7-Zip](https://www.7-zip.org/) 專案，由 Igor Pavlov 開發。

7-Zip 專案主要基於 GNU LGPL 授權。更多詳細資訊請參閱 [7-Zip 官網授權頁面](https://www.7-zip.org/license.html)。

The core compression functionality of this tool is provided by `7zr.exe`, a utility from the 7-Zip project, developed by Igor Pavlov. The 7-Zip project is licensed mostly under the GNU LGPL. For more information, please visit the [7-Zip license page](https://www.7-zip.org/license.html).

---

## ⚠️ 注意事項 (Disclaimer)

* 此工具包含自動刪除檔案的功能，雖然有防呆機制，但仍建議**首次使用時先用不重要的檔案進行測試**。
* 作者不對任何因使用此工具而造成的資料遺失負責。請謹慎使用。

## 授權 (License)

此專案採用 [MIT License](LICENSE)。
