<div align="center">
  <img src="htmlfiles/logo.png" alt="Wifi-Jammer-NodeMCU Logo" width="200"/>
  
  # Wifi-Jammer-NodeMCU
  
  **The Original ESP8266 WiFi Deauther & Jammer**
  
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
  [![Platform](https://img.shields.io/badge/platform-ESP8266-blue.svg)](https://github.com/esp8266/Arduino)
  [![Legacy](https://img.shields.io/badge/Project-Legacy%20(8y+)-orange.svg)]()
  [![Maintenance](https://img.shields.io/badge/Maintained%3F-Yes-green.svg)]()

  *Developed by **Boubli** | Created ~2016*
</div>

---

## 📜 Project Overview
**Wifi-Jammer-NodeMCU** is a classic, lightweight **WiFi Deauthentication & Jamming tool** specifically engineered for the **NodeMCU (ESP8266)** platform. Created over 8 years ago, this project utilizes raw 802.11 packet injection to perform security audits, network stress testing, and educational demonstrations of WiFi protocol vulnerabilities.

Unlike complex modern suites, this project remains a **simple, standalone solution** that hosts its own web interface, making it perfect for quick deployment and testing on low-cost hardware.

## ✨ Key Features
*   **📡 Precision WiFi Scanning**: Instantly detect all nearby Access Points (APs) and connected clients with real-time signal strength (RSSI) monitoring.
*   **🎯 Targeted Deauthentication**: Surgically disconnect specific devices from a network without affecting others.
*   **💥 Broadcast Jamming**: Disconnect **ALL** clients from a selected network to test reconnection resilience.
*   **🛡️ Beacon Spamming**: Flood the airwaves with dozens of fake WiFi networks (SSIDs) to confuse scanners or hide legitimate networks (Rickroll your neighbors!).
*   **💻 Standalone Web Interface**: No app or internet required. A fully responsive control panel is hosted directly on the ESP8266 at `192.168.4.1`.

## 🛠️ Hardware Requirements
*   **ESP8266 Development Board**:
    *   NodeMCU v2 / v3 (Recommended)
    *   Wemos D1 Mini
    *   Generic ESP-12E/F modules
*   **Micro-USB Cable** (for flashing and power)

## 🚀 Getting Started

### 1. Installation
Clone the repository to your local machine:
```bash
git clone https://github.com/boubli/Wifi-Jammer-NodeMCU.git
```

### 2. Flashing Firmware
1.  Download and install the [Arduino IDE](https://www.arduino.cc/en/software).
2.  Install the **ESP8266 Board Package** via the Boards Manager.
3.  Open `esp8266_deauther/esp8266_deauther.ino`.
4.  Select your board (e.g., `NodeMCU 1.0 (ESP-12E Module)`) and COM port.
5.  Click **Upload**.

### 3. Usage
1.  Power up your NodeMCU.
2.  Connect your phone or laptop to the WiFi network:
    *   **SSID:** `The Plague`
    *   **Password:** `12xx15xx`
3.  Open a web browser and go to `http://192.168.4.1`.
4.  **Scan** -> **Select Target** -> **Attack**.

## ⚠️ Disclaimer
**This project is for educational purposes and authorized security testing ONLY.**
Using this tool against networks you do not own or have explicit permission to test is illegal and punishable by law. The developer (**Boubli**) assumes no liability for any misuse of this software.

## 💾 Development & History
This project was originally built in **2016-2017** as a pioneering exploration into ESP8266 packet injection. It has been recently dusted off and modernized with a new interface and documentation while preserving the original core logic that made it effective.

**Credits:**
*   **Developer:** Boubli
*   **Core Logic:** Based on the early ESP8266 Deauther research.
