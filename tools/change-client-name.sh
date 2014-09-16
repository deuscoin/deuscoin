cd ~/deuscoin/src
sudo find ./ -type f -exec sed -i 's/CLIENT_NAME(\"Satoshi\")/CLIENT_NAME(\"DeusCli\")/g' {} \;