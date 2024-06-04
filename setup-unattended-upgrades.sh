#!/bin/bash
  
# Update package lists and install unattended-upgrades

sudo apt update

sudo apt install -y unattended-upgrades apt-listchanges


# Enable unattended-upgrades

sudo dpkg-reconfigure -f noninteractive unattended-upgrades
  

# Create /etc/apt/apt.conf.d/20auto-upgrades

sudo bash -c 'cat > /etc/apt/apt.conf.d/20auto-upgrades <<EOF

APT::Periodic::Update-Package-Lists "1";

APT::Periodic::Download-Upgradeable-Packages "1";

APT::Periodic::AutocleanInterval "7";

APT::Periodic::Unattended-Upgrade "1";

EOF'

  
# Configure unattended-upgrades

sudo bash -c 'cat > /etc/apt/apt.conf.d/50unattended-upgrades <<EOF

Unattended-Upgrade::Allowed-Origins {

    "\${distro_id}:\${distro_codename}";

    "\${distro_id}:\${distro_codename}-security";

    "\${distro_id}ESM:\${distro_codename}";

    "\${distro_id}:\${distro_codename}-updates";

    "\${distro_id}:\${distro_codename}-proposed-updates";

};

EOF'

  

# Enable and start the unattended-upgrades service

sudo systemctl enable unattended-upgrades

sudo systemctl start unattended-upgrades

  
echo "Unattended upgrades setup complete."
