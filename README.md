```markdown
# MikroTik BGP Peer Watchdog

## Overview
A lightweight and efficient RouterOS script designed for High Availability (HA) enterprise networks. This watchdog script continuously monitors the state of all configured BGP peers on a MikroTik router. If a peer state changes from "established" to anything else (indicating a link or routing failure), it immediately alerts the IT Operations team.

## Features
* **Real-time Monitoring:** Iterates through enabled BGP peers and verifies their connection state.
* **Instant Notifications:** Integrates with the Telegram API to push critical alerts directly to a NOC/IT team channel.
* **Syslog Integration:** Logs errors locally for ingestion by SIEM or central Syslog servers (e.g., Splunk, Graylog).

## Prerequisites
* MikroTik RouterOS (v6 or v7).
* A valid Telegram Bot Token and Chat ID.
* Router must have DNS and internet access to reach the Telegram API.

## Installation & Scheduling
1. Open WinBox or SSH into your MikroTik router.
2. Navigate to `System` -> `Scripts` and create a new script named `BGP_Watchdog`.
3. Paste the contents of `bgp_watchdog.rsc` into the source field.
4. Replace `YOUR_TELEGRAM_BOT_TOKEN` and `YOUR_TELEGRAM_CHAT_ID` with your actual Telegram credentials.
5. Create a Scheduler to run the script every 1 minute:
   ```routeros
   /system scheduler
   add name=Run_BGP_Watchdog interval=1m on-event=BGP_Watchdog
