terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.6.7"
    }
  }
}

provider "proxmox" {
    pm_api_url = "https://127.0.0.1:8006/api2/json"
    pm_user = "tfuser@pve"
    pm_tls_insecure = true
    pm_log_enable = true
}

resource "proxmox_lxc" "file_server" {
  target_node  = "proxmox"
  hostname     = "file-server"
  ostemplate   = "http://mirror.turnkeylinux.org/turnkeylinux/images/proxmox/debian-10-turnkey-fileserver_16.0-1_amd64.tar.gz"
  password     = "container"
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-zfs"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}

