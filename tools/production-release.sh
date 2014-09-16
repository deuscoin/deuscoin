cd ~/deuscoin
sudo find ./ -type f -exec sed -i 's/CLIENT\_VERSION\_IS\_RELEASE\, false/CLIENT\_VERSION\_IS\_RELEASE\, true/g' {} \;
sudo find ./ -type f -exec sed -i 's/CLIENT\_VERSION\_IS\_RELEASE  false/CLIENT\_VERSION\_IS\_RELEASE  true/g' {} \;