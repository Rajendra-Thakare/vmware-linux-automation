#!/bin/bash
# ==============================================================================
# Script Name: check_ntp_sync.sh
# Description: Simulates an audit of NTP time synchronization across a 
#              pool of enterprise infrastructure hosts.
# ==============================================================================

# Generic, sanitized internal time sources (Allowed NTP Servers)
AUTHORIZED_NTP_1="10.10.10.5"
AUTHORIZED_NTP_2="10.10.10.6"

# A generic array of mock infrastructure hosts to check
HOSTS=("esxi-node-01" "esxi-node-02" "esxi-node-03")

echo "=========================================================="
echo " Starting Enterprise Hypervisor NTP Audit Profile         "
echo "=========================================================="
echo "Authorized NTP Sources: $AUTHORIZED_NTP_1, $AUTHORIZED_NTP_2"
echo "----------------------------------------------------------"

for TARGET in "${HOSTS[@]}"; do
    echo -n "[*] Auditing time synchronization on $TARGET... "
    
    # Simulating a check (Node 03 simulates a mock drift/misconfiguration)
    if [ "$TARGET" == "esxi-node-03" ]; then
        echo "FAILED"
        echo "    --> CRITICAL: Host clock drifted by +12 seconds!"
        echo "    --> REMEDIAL ACTION: Re-syncing with $AUTHORIZED_NTP_1..."
        echo "    --> STATUS: Restored to compliant state."
    else
        echo "COMPLIANT"
        echo "    --> Synchronized with $AUTHORIZED_NTP_1 (Stratum 2)"
    fi
    echo "----------------------------------------------------------"
done

echo "NTP Infrastructure Audit Completed successfully."
echo "=========================================================="
