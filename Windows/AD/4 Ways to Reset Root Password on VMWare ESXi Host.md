If you forgot or lost the root password of an ESXi host, you may lose control of it and will not be able to log into its console via [SSH](https://vmblog.ru/kak-vklyuchit-ssh-v-vmware-esxi-6 -x/) if there are problems with the operating system or the need to run diagnostics on the host. In this article, I will show 4 different ways to reset a forgotten root password on a VMware ESXi v6.7 host. The password reset method is also applicable to ESXi 6.x and 5.x versions ([how to find out the ESXi version](https://vmblog.ru/kak-uznat-versiyu-sborki-esxi-s-pomoshhyu-web-client-6 -5/)).

From VMWare's point of view, the only correct way to reset the root password on an ESXi host is to reinstall the OS (but this leads to loss of configuration and data on local disks). All other methods may lead to host failure, or the system being transferred to an unsupported configuration, because ESXi does not have a service console and you cannot reset the password through single-user mode like in Linux.

Let's say you forgot the root password for one of your ESXi hosts. In this case, 2 scenarios are possible: 1. your host has been added to vCenter and you can still be managed by it 2. you forgot the password for the standalone ESXi host (or for the free edition of VMware [Hypervisor](https://vmblog.ru/ustanovka-klyucha-licenzii-na-servere-vmware-esxi/)


## Reset ESXi password using VMware Host Profile

Most ESXi hosts in large companies are managed through vCenter Server. Even if you forgot your root password, vCenter can easily manage host settings because... you have already linked the host to vCenter and you simply do not need the root password. If you remove the host from vCenter (it's better not to do this) and try to add it again, you will need to specify the root password. Therefore, while your host is managed by vCenter, you can reset the root password using the VMware Host Profile. 

[The root password on the vCenter Server Appliance is reset](https://vmblog.ru/kak-sbrosit-parol-root-na-vcenter-server-appliance-6-5/) differently. A host profile is a set of ESXi settings you define that can be applied to any host to quickly configure it. Typically a host profile is created after configuring a generic ESXi host and exporting its configuration to the Host profile. The administrator can apply this profile to any other host.

1 - Launch vSphere Web Client and log in to vCenter.

2 - On the home page, select Host Profile 

3 - Click the **Extract Profile from a host button to** extract the ESXi host profile with the root password you know. ![word-image-11.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-11.png) 4. Select the ESXi host and click Next. ![word-image-12.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-12.jpeg) 5. Specify the name of the profile (it is advisable to indicate its description). ![word-image-13.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-13.jpeg) 6. Once the new profile is created, edit it. ![word-image-14.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-14.jpeg) 

7 - Using the built-in search, find the parameter named root (located in the Security and Services -> Security Settings -> Security -> User Configuration -> Root section). Select the **“Fixed Password Configuration”** option and enter a new root password. ![word-image-15.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-15.jpeg) 8. All other settings in the profile must be disabled. Click Finish. ![word-image-16.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-16.jpeg) 9. Now you need to bind this profile to your ESXi host on which you need to reset the password. From the Actions menu, select **Attach/Detach Hosts. ![word-image-17.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-17.jpeg) ** 10. Select your ESXi host (on which you want to reset the password) and click the **Attach button. ![word-image-18.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-18.jpeg) ** 11. Go to the **Host profile -> Monitor -> Compliance** tab and click the **Remediate button. ![word-image-19.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-19.jpeg) ** 12. After the check is completed, the new settings will be applied to the host and it will have the Complaint status (i.e. the host configuration matches the assigned profile). In previous versions of ESXi, in order to apply a profile to a host, it must be put into Maintenance Mode and the host must be rebooted. ![word-image-20.jpeg](https://vmblog.ru/wp-content/uploads/2019/03/word-image-20.jpeg)
## Resetting the root password using Active Directory and vCenter

You can also reset the root password on an ESXi host if you use vCenter to add your host to an Active Directory domain. Once you join ESXi to a domain, you can log into it using a domain account and reset the local root user password.

Launch the **Active Directory Users and Computers** snap-in and create a new [domain group](https://vmblog.ru/tipy-grupp-active-directory-kak-sozdat-novuyu/) with the name ESX Admins (this is the name groups). [Add to the group](https://vmblog.ru/add-adgroupmember-dobavit-polzovatelya-v-gruppu-ad/) a user account whose 
password you know. ![word-image-1.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-1.png) Now you need to add the host to the domain. In the vCenter console, select the host, go to Configure -> Authentication Services -> Join Domain. Specify the domain name and an account with rights to add computers to the domain. ![word-image-2.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-2.png) Now open the web interface of your ESXi host and log in to it using the account that you added to the [ESX admins group](https://vmblog.ru/vmware-esxi-4-1-nastrojka-integracii-c-active-directory /) (the account name must be specified in the format User@Domain or Domain\User). ![word-image-3.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-3.png) After authorization, go to the **Host** -> **Manage** -> **Security & users -> Users section and reset the local user** root password. After this, you can exclude ESXi from the Leave Domain. ![word-image-4.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-4.png) To apply the changes, reboot the host. 

## Resetting the root password on a single ESXi host

In this section, we will show how to reset the root password on a standalone ESXi server that is not added to vCenter. This password reset method will require rebooting the host and shutting down all virtual machines running on it. To reset, you will need a boot disk, for example, an iso image of Ubuntu GNOME. This image needs to be written to a USB flash drive, which can be made [bootable using the Rufus utility](https://vmblog.ru/rufus-sozdaem-zagruzochnuyu-usb-fleshku-s-windows/). ![word-image-5.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-5.png) Then you need to boot ESXi from this flash drive, connect local storage from the ESXi host, unpack the archive and change the password file. 

Then you need to replace the file, reboot the host and try to log in to ESXi using the root account with an empty password. 

## Reset ESXi password in shadow file

For security reasons, the ESXi host stores the password encrypted in shadow. We need to change the root password in this file. Among all the partitions on the ESXi host, we only need /dev/sda5 (/bootbank). It is in this partition of the disk that the OS image and configuration is stored. 

After you have booted from the bootable USB flash drive, run the command: 
`# sudo su` 

Let's display a list of disks: 
`# fdisk –l | grep /dev/sda*` 
![word-image-6.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-6.png) We need a **/dev/sda5** partition with a size of 250 MB. Create a mount point:
`# mkdir /mnt/sda5` 

Create a temporary directory: 
`# mkdir /temp` 

Mount the /dev/sda5 partition:
`# mount /dev/sda5 /mnt/sda5` 

We need an archive file named **state.tgz** (inside it is the local.tgz file we need):
`# ls -l /mnt/sda5/state.tgz` 

Unpack the files **state.tgz** and **local.tgz:** 
`# tar -xf /mnt/sda5/state.tgz –C /temp/` `# tar -xf /temp/local.tgz –C /temp/` 

Archive files can now be deleted: 
`# rm /temp/.tgz` 

The shadow file should appear in the temporary directory. Open the file with any text editor:
`# vi /temp/etc/shadow` 

This is what the contents of the shadow files look like. As you can see, it contains all local accounts and their passwords (encrypted): To reset the root password to blank, simply delete everything between the first two colons and save the file. ![word-image-8.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-8.png) Change to directory: `# cd /temp` 

Now you need to pack the shadow file in reverse order:
`# tar -czf local.tgz etc` `# tar -czf state.tgz local.tgz` 

Now move the new archive to the original ESXi image directory: 
`# mv state.tgz /mnt/sda5/` 

Unmount the partition:
`# umount /mnt/sda5` 

Now you can reboot the host:
`#reboot` 

When ESXi boots, it will unpack the local.tgz archive and copy the configuration files (including shadow) to the /etc/ directory. Try logging into the server via DCUI without a password. The system will indicate that the root password has not been set and for security reasons it needs to be changed. ![word-image-9.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-9.png) Select the **Configure Password** menu item and enter a new password. ![word-image-10.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-10.png) 

## Replacing the password in the shadow file
As one of the options for resetting a password on an ESXi host discussed above, you can not reset, but replace the shadow file with a file from another ESXi host (with a known password). You can [use WinSCP to copy the file](https://vmblog.ru/kopirovanie-fajlov-mezhdu-vmware-esxi-6-5-i-windows/) shadow from another ESXi host to your bootable USB flash drive. ![word-image-11.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-11.png) 
Boot your ESXi host from your bootable USB drive (Ubuntu GNOME in my example). And run the following commands: 
`# sudo su` 

Let's display a list of disks: 
`# fdisk –l | grep sd` 

Let's create two temporary folders.
`# mkdir /mnt/sda5` `# mkdir /mnt/sdb1` 

Mount the partition with the ESXi image and your USB disk on which the shadow file copied from another host is located: 
`# mount /dev/sda5 /mnt/sda5` `# mount /dev/sdb1 /mnt/sdb1` 

Create temporary directories: 
`# mkdir /temp` `# mkdir /mnt/sdb1/save`

Find the required file in the archive: 
`# ls -l /mnt/sda5/state.tgz` 

Copy the archive:
`# cp /mnt/sda5/state.tgz /mnt/sdb1/save` 

Unpack the archives: 
`# tar -xf /mnt/sda5/state.tgz –C /temp/` `# tar -xf /temp/local.tgz –C /temp/` 

Make sure you unzip the /etc directory. 
`# ls –l /temp`

Delete the local.tgz archive.
`#rm/temp/local.tgz` 

Replace the original shadow file with the one you copied from another host: 
`# cp /mnt/sdb1/shadow /temp/etc` 

![word-image-12.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-12.png) You can look at the contents of the file shadow. 
`# vi /temp/etc/shadow` 

Remove unnecessary accounts that you do not need (except for standard accounts). In my example, I will delete the Test user. Save the file shadow. ![word-image-13.png](https://vmblog.ru/wp-content/uploads/2019/03/word-image-13.png) `# cd /temp` 

Let's pack the contents of the /etc directory. 

`# tar -czf local.tgz etc` 
`# tar -czf state.tgz local.tgz` 

Copy the state.tgz archive to the partition with the ESXi image: 
`# mv state.tgz /mnt/sda5/` 

Unmount the sda5 partition: 
`# umount /mnt/sda5` 

Reboot the host:
`#reboot` 

That's all, now we can log in to the ESXi host using a known password. I think someone will be interested. [Source](https://vmblog.ru/sbros-paroyal-root-v-vmware-esxi/)


URLS SAVED OF THE BLOGS:
[kak-vklyuchit-ssh-v-vmware-esxi-6-x](https://web.archive.org/web/20240519102802/https://vmblog.ru/kak-vklyuchit-ssh-v-vmware-esxi-6-x/)
[root-na-vcenter-server-appliance-6-5](https://web.archive.org/web/20230201015324/https://vmblog.ru/kak-sbrosit-parol-root-na-vcenter-server-appliance-6-5/)
[domain_group](https://web.archive.org/web/20230130151253/https://vmblog.ru/tipy-grupp-active-directory-kak-sozdat-novuyu/)
[add to the group](https://web.archive.org/web/20230924074044/https://vmblog.ru/add-adgroupmember-dobavit-polzovatelya-v-gruppu-ad/)
[Rufus booteable](https://web.archive.org/web/20231129051845/https://vmblog.ru/rufus-sozdaem-zagruzochnuyu-usb-fleshku-s-windows/)
[use WinSCP to copy the file](https://web.archive.org/web/20231129061609/https://vmblog.ru/kopirovanie-fajlov-mezhdu-vmware-esxi-6-5-i-windows/)
