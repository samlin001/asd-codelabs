This code lab will walk you through how to create a VM and setup a Android development enviroment on Google Cloud Platform(GCP) from scratch.
## Steps
1. Create a VM to config the development environment
2. Enable KVM
3. Setup Chrome Remote Desktop(CRD) to acess GUI
4. Install softwares
5. Prepare VM for image
6. Create and publish an image
7. Transfer ownership of project
8. Delete project/VM

### 1. Create a VM to config the development environment
- Understand [the public and custom images](https://cloud.google.com/compute/docs/images).
- Recommended machine specs
  - What are the [Machine types](https://cloud.google.com/compute/docs/machine-types)?
    - How do I [Create a VM instance with a custom machine type](https://cloud.google.com/compute/docs/instances/creating-instance-with-custom-machine-type#create)?
  - You can either start with an existing custom image or a public Linux image.
  - To set a generic name, e.g. **avd**, follow 1-3 setps at [Changing the default username](https://cloud.google.com/compute/docs/ssh-in-browser#changing_the_default_username).
  Which will affect for the next VM you create.
  
#### Create VM with public image
The following command will create a Debian 10 VM with 100G of storage
- The ``` create-disk``` line is modified so the user will not need to mount the storage themselves.
	```
	gcloud compute instances create asd-vm \
		--enable-nested-virtualization \
		--machine-type=n1-highcpu-16 \
		--min-cpu-platform="Intel Haswell" \
		--create-disk=auto-delete=yes,boot=yes,device-name=asd-vm,image=projects/debian-cloud/global/images/debian-10-buster-v20220118,mode=rw,size=100,type=projects/asdimage/zones/us-west1-b/diskTypes/pd-standard \
		--zone=us-west2-a
	```
	
### 2. Enable KVM
The KVM group is used for nested virtualization, this will take around 1 min to do:
1. Install qemu-kvm
	```
	sudo apt install qemu-kvm
	```
2. To check the current user name
	```
	who
	```
3. Add your user to the kvm group
	```
	sudo adduser [USERNAME] kvm
	```
### 3. Setup Chrome Remote Desktop(CRD) to acess GUI

Use Cinnamon for better result, this will take around 5~10 minute.
- [Installing Chrome Remote Desktop on the VM instance](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#installing_chrome_remote_desktop_on_the_vm_instance)
- [Installing Cinnamon desktop environment](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#installing_an_x_windows_system_desktop_environment)
- [Configuring and starting the Chrome Remote Desktop service](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#configuring_and_starting_the_chrome_remote_desktop_service)
- [Disable screensavers, lock screens, and passwords](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#cinnamon_1)
to avoid locking out & requiring a password, which is never set.
- (Optional) Changing terminal scheme
  - Edit > Prefrences > Colors > Built-in schemes: Green on black
- [Disable screensaver, screenlock, and adding password](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#disable_screensavers_lock_screens_and_passwords)
- ToDo: [Automate the installing process](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#automating_the_installation_process)

### 4. Install softwares
- Android studio (Todo: add to script)
  - Follow the instructions to [install Android studio on Linux](https://developer.android.com/studio/install#linux)
  - After installing, open up Android Studio and create a blank project, this will speed up the setup for others.
  - Move Android studio into /ws folder
  

### 5. Prepare VM for image
  ```
  echo "Remove the user from KVM group"
  sudo deluser $USER kvm
  sudo apt clean
  sudo rm -rf /tmp/* ~/.bash_history
  rm -rf ~/.local/share/Trash/*

  sudo ls /home
  echo "Del additional dirs if needed: sudo rm -rf /home/adir"

  ```

- [Deauthorize Chrome Remote Desktop for the instance](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#deauthorize_chrome_remote_desktop_for_the_instance)

### 6. Create and publish an image
1. Read about [Compute image User role](https://cloud.google.com/compute/docs/access/iam#compute.imageUser)
    - When making the image public, we are granting all users permission to list and read images.
2. Exit out of cloud shell and stop the instance
3. Create an image
    - ```--licenses``` is added to enable nested virtulization
```
gcloud compute images create <YOUR_IMAGE_NAME> \
    --source-disk=<YOUR_DISK_NAME> \
    --source-disk-zone=<YOUR_DISK_ZONE> \
    --licenses https://compute.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx
    --force
```
4. Making the image public
```
gcloud compute images add-iam-policy-binding <YOUR_IMAGE_NAME> \
    --member='allAuthenticatedUsers' \
    --role='roles/compute.imageUser'
```

### 7. Transfer ownership of project
This is usded for transfering images
1. Navigate to your project at https://console.cloud.google.com/
2. Click the "hamburger" menu button. Click Menu Button
3. Select "IAM" under "Access" Click IAM
4. At the top, click "ADD" Click ADD
5. Name the new Owner and select "Owner" under "Project" Select Owner under Project
6. Instruct your new Owner to Accept the Invitation
7. On new Owner's account, go to Billing in the "hamburger" menu and either link the project to an existing billing account or set up a new Billing account to link the project to.
8. On the new Owner's account, go back to the IAM section and delete your account from the list by clicking the pencil on the right and then the trash can icon. Pencil Trash can



### 8. Delete project/VM
Important: You will still be charged even after deleteing the VM, if you have a image stored in GCP
- Delete the VM:
1. In VM instance page, select the VM you want to delete
2. Click on the three dots to the right, besides SSH
3. Click delete
- Delete the project:
1. In the Cloud Console, go to the Projects page.
2. Click the trash can icon to the right of the project name.
