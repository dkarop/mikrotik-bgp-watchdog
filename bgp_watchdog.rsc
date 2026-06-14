# MikroTik RouterOS Script: BGP Peer State Watchdog
# Schedule this script to run every 1 minute
# Written by: D. Karopoulos

:local botToken "YOUR_TELEGRAM_BOT_TOKEN";
:local chatID "YOUR_TELEGRAM_CHAT_ID";

# Iterate through all BGP peers
/routing bgp peer
:foreach peer in=[find] do={
    :local peerName [get $peer name];
    :local peerState [get $peer state];
    :local peerDisabled [get $peer disabled];
    
    # Check only enabled peers
    :if ($peerDisabled = false) do={
        :if ($peerState != "established") do={
            
            :local logMsg ("CRITICAL: BGP Peer " . $peerName . " is currently " . $peerState . "! Routing may be affected.");
            
            # Log locally for Syslog/Splunk ingestion
            :log error $logMsg;
            
            # Send Telegram Alert for immediate IT Operations response
            :local tgUrl ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $logMsg);
            /tool fetch url=$tgUrl keep-result=no;
        }
    }
}
