# Wifi-Jammer-NodeMCU

**Developer:** Boubli  
**Project Status:** Active / Legacy  
**Platform:** ESP8266 (NodeMCU)

## Overview
This project is a tailored WiFi Deauthentication & Jamming tool designed for the NodeMCU (ESP8266). It leverages the raw packet injection capabilities of the ESP8266 to perform security testing and network auditing. It allows you to scan for WiFi networks, selecting targets, and launching deauthentication attacks to test network resilience.

## Features
*   **WiFi Scanning:** Detects nearby Access Points (APs) and Clients.
*   **Deauthentication Attack:**
    *   **Targeted:** Disconnect specific clients from a network.
    *   **Broadcast:** Disconnect all clients from a selected network.
*   **Beacon Spam:** Floods the area with fake WiFi Access Points (SSIDs) to confuse scanners or hide legitimate networks.
*   **Web Interface:** Fully standalone web control panel hosted on the ESP8266 (IP: `192.168.4.1`).

## Getting Started

### Hardware Required
*   NodeMCU v2 or v3 (or any ESP8266-based board like Wemos D1 Mini).
*   Micro-USB cable.

### Installation
1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/boubli/Wifi-Jammer-NodeMCU.git
    ```
2.  **Open in Arduino IDE:**
    *   Open `esp8266_deauther/esp8266_deauther.ino`.
3.  **Install Dependencies:**
    *   Ensure you have the ESP8266 Board Manager installed in Arduino IDE.
4.  **Flash:**
    *   Select your board (e.g., NodeMCU 1.0).
    *   Select the correct COM port.
    *   Upload the sketch.

### Usage
1.  Power on the NodeMCU.
2.  Connect to the WiFi network named **"The Plague"** (Password: `12xx15xx`).
3.  Open your web browser and navigate to `http://192.168.4.1`.
4.  Use the interface to scan for networks and start attacks.

## Disclaimer
This project is for educational purposes and security testing only. Use it only on networks you own or have permission to test. The developer (Boubli) is not responsible for any misuse of this software.

## Credits
*   **Developer:** Boubli
*   **Original Core:** Based on the ESP8266 Deauther project.
