#!/bin/bash

echo "sfdx force:package:version:create --package CDL_Logs_Open --path force-app --installationkey #CustomDebugLogs123 --wait 10 --targetdevhubusername myApps"
sfdx force:package:version:create --package CDL_Logs_Open --path force-app --installationkey \#CustomDebugLogs123 --wait 10 --targetdevhubusername myApps