```bash
#!/bin/bash

# SELinux Access Denial Practical
# Student Name:
# Register Number:

echo "===== SELinux Status ====="
getenforce
sestatus

echo
echo "===== Creating Web Directory ====="
sudo mkdir -p /web
sudo chmod 755 /web

echo
echo "===== Creating HTML File ====="
echo "<html><body><h1>SELinux Practical</h1></body></html>" | sudo tee /web/index.html > /dev/null
sudo chmod 644 /web/index.html

echo
echo "===== Setting Linux Permissions ====="
sudo chown -R root:root /web
sudo chmod 755 /web
sudo chmod 644 /web/index.html
ls -l /web

echo
echo "===== Checking Initial Context ====="
ls -Zd /web
ls -Z /web/index.html

echo
echo "===== Assigning Wrong SELinux Context ====="
# Deliberately assign an incorrect SELinux type
sudo chcon -t var_t /web/index.html

echo
echo "===== Checking Wrong Context ====="
ls -Z /web/index.html

echo
echo "===== Checking AVC Denials ====="
sudo ausearch -m AVC -ts recent 2>/dev/null || \
sudo journalctl -t setroubleshoot --no-pager -n 20

echo
echo "===== Correcting SELinux Context ====="
# Restore the default SELinux context for the file
sudo restorecon -v /web/index.html

echo
echo "===== Checking Correct Context ====="
ls -Z /web/index.html

echo
echo "===== Practical Completed ====="
echo "SELinux context was intentionally changed and then restored."
```
