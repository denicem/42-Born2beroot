# CheetSheet

### Project overview

- **VM**
"Virtual Machine" - is a compute resource, that uses software instead of a physical computer to run programs and deploy apps. Basically a computer in a computer. Each VM runs its own OS and functions separately.
- **Why VMs?**
a safe, sandboxed environment to try and test applications
to run software that requires a different OS
- **Choice of OS — Debian**
easier to install and configure than CentOS → have to install more packages on your own
diffs: CentOS more stable, fewer updates, uses RPM instead of `dpkg`  | Debian more flexible, more updates
- **aptitude vs. apt**
aptitude is a high-level package manager, with GUI | apt is a low-level package manager which can be used by other high-level package members
- **APPArmor**
"**App**lication Armor" - a Linux kernel security model that allows the system admin to restrict programs' capabilties.
- **SSH**
"**S**ecure (Socket) **SH**ell" - is a network protocol that gives users (sys admin) a secure way to access a computer over an unsecured network. e.g. in this case: access to the VM from our physical PC through a terminal.
- **UFW**
**U**ncomplicated **F**ire**w**all - simple way to configure which connections to allow or deny.

---

### Simple setup

login to VM

`sudo status ufw`

`sudo service ssh status`

`uname -a` - gets architecture of OS

### User & Group

check if a user is present and that it belongs to the "sudo" and "user42" groups: `getent group <groupname>`

`sudo adduser <username>` - add user

add password

`(sudo) nano /etc/login.defs` - password expire policy

`(sudo) nano /etc/pam.d/common-password` - password policy

`sudo chage -l <username>` - checking/verifying  password expiry information for user

`sudo addgroup <groupname>`l

`sudo adduser <username> <groupname>` - add user to group

`getent group <groupname>` - get entries from group

### Hostname and partitions

`sudo nano /etc/hostname` - change hostname

`lsblk` - check/list partitions

- **LVM**
"Logical Volume Manager"

### Sudo

`dpkg -l | grep sudo`

`ls /var/log/sudo` 

`cd /var/log/sudo/... && ls` - sudo logs (... → 00/01/2B, etc)

`sudo adduser <username> sudo`

`nano /etc/sudoers.d/sudoconfig` - sudo config files

`ls /etc/sudoers.d`

### UFW

`dpkg -l | grep ufw`

`sudo ufw status`

`sudo ufw allow/deny <port>`

`sudo ufw delete allow/deny <port>`

### SSH

`dpkg -l | grep ssh`

`sudo service ssh status`

`sudo nano /etc/ssh/sshd_config`

`ssh <username>@ipaddress -p 4242` - connect to VM from host (physical machine) via SSH → also try with root! (should not work)

### Script monitoring

`sudo nano monitoring.sh`

### cron

- task manager that lets you execute tasks/commands/scripts at a certain time.
- `sudo crontab *(-u root)* -l` - list schedules
- `sudo crontab  *(-u root)* -e` - edit schedules

run script every 30 seconds:

1. `sudo crontab -u root -e` 
2. comment last line and add after it: `*/1 * * * * sleep 30s && bash /home/<username>monitoring.sh`

<aside>
ℹ️ interrupt crontab schedule by just commenting/removing the line you typed in.

</aside>

### useful command for the eval

`dpkg - l | grep <appname>` - check if app is installed

`sudo aa-status` - AppArmor status

`sudo apt update`

`shasum <VMname>.vdi` - show signature of VM