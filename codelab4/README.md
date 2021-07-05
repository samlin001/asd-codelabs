# Customize your own development environment
This code lab guides you to create a custom image to set up ASD development
environment.

## Steps
1. Create a VM to config the development environment
2. Setup Chrome Remote Desktop(CRD) to acess GUI
3. Install softwares
4. Pre-build Android
5. Clean up
6. Create and publish an image

### 1. Create a VM to config the development environment
- Understand [the public and custom images](https://cloud.google.com/compute/docs/images).
- Recommended machine specs
  - What are the [Machine types](https://cloud.google.com/compute/docs/machine-types)?
    - How do I [Create a VM instance with a custom machine type](https://cloud.google.com/compute/docs/instances/creating-instance-with-custom-machine-type#create)?
  - Recommend using at least 520 GB for boot disk size, for [better performance](https://cloud.google.com/compute/docs/disks/performance#performance_by_disk_size).
    - If you are using the VM to build Android, it needs at least 400 GB, [250Gb for Android source, 150Gb to build](https://source.android.com/setup/build/requirements#hardware-requirements)
- You can either start with an existing custom image or a public Linux image.
  - To set a generic name, e.g. **avd**, follow 1-3 setps at [Changing the default username](https://cloud.google.com/compute/docs/ssh-in-browser#changing_the_default_username).
  Which will affect for the next VM you create.

#### Base on an existing custom image
If you just want to add new software or change some configuration, this is a good option for you.
```
gcloud compute instances create gas-oem-avd \
  --enable-nested-virtualization \
  --machine-type n1-highcpu-16 \
  --min-cpu-platform="Intel Haswell" \
  --image-project=asd-codelab1 \
  --image=asd-android11-qpr2 \
  --zone=us-west2-a
```
- Reference: [gcloud compute instances create](https://cloud.google.com/sdk/gcloud/reference/compute/instances/create)

#### Base on a Linux public image
To build from scratch, follow the instruction.
```
gcloud compute instances create <YOUR_VM_NAME> \
  --enable-nested-virtualization \
  --machine-type n1-highcpu-16 \
  --min-cpu-platform="Intel Haswell" \
  --image-family=debian-10 \
  --image-project=debian-cloud \
  --create-disk size=520,type=pd-standard \
  --zone=us-west2-a
```

### 2. Setup Chrome Remote Desktop(CRD) to acess GUI
Use Cinnamon for better result
- [Installing Chrome Remote Desktop on the VM instance](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#installing_chrome_remote_desktop_on_the_vm_instance)
- [Installing Cinnamon desktop environment](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#installing_an_x_windows_system_desktop_environment)
- [Configuring and starting the Chrome Remote Desktop service](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#configuring_and_starting_the_chrome_remote_desktop_service)
- [Disable screensavers, lock screens, and passwords](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#cinnamon_1)
to avoid locking out & requiring a password, which is never set.
- (Optional) Changing terminal scheme
  - Edit > Prefrences > Colors > Built-in schemes: Green on black
- [Disable screensaver, screenlock, and adding password](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#disable_screensavers_lock_screens_and_passwords)
- ToDo: [Automate the installing process](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#automating_the_installation_process)

### 3. Install softwares
- Python 2.7
  - Note: Stick with 2.7 for now, using python 3 can cause problems when using repo
  ```
  sudo apt-get install python

  ```
- Libncurses
  ```
  sudo apt-get install libncurses5

  ```
- [repo](https://source.android.com/setup/develop#installing-repo)
  ```
  mkdir /ws
  cd /ws
  mkdir /ws/bin
  PATH=/ws/bin:$PATH
  curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
  chmod a+x ~/bin/repo

  ```
- Java
  ```
  sudo apt update
  sudo apt install default-jre

  ```
- Android studio (Todo: add to script)
  - Follow the instructions to [install Android studio on Linux](https://developer.android.com/studio/install#linux)
  - After installing, open up Android Studio and create a blank project, this will speed up the setup for others.
  - Move Android studio into /ws folder

#### To add
- Visual Studio Code
  - VS Code allows users to edit documents easier without learning vim.
  - Read [Install Visual Studio on Linux](https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions).
  ```
  echo "Download .deb"
  xdg-open https://code.visualstudio.com/

  echo "Install the .deb file"
  sudo apt install ~/Downloads/code_1.57.1-1623937013_amd64.deb
  ```
- Google Cloud SDK
  - Download google-cloud-sdk-345.0.0-linux-x86_64.tar.gz or newer from [Installing Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
  - Unzip it to /ws/google-cloud-sdk


### 4. Pre-build Android
Here we will downlaod [android11-qpr2-release](https://android.googlesource.com/platform/manifest/+/refs/heads/android11-qpr2-release). If you wish to download a specific branch, change the tag after ```-b```

   The list of tags can be found on [Source code tags and builds](https://source.android.com/setup/start/build-numbers#source-code-tags-and-builds), as well as [Branches](https://android.googlesource.com/platform/manifest/+refs)

  - Config Git environment
    ```
    git config --global user.name <YOUR_NAME>
    git config --global user.email <YOUR@EMAIL.COM>
    ```
  - Download source
  ```
  mkdir /ws/android
  cd /ws/android
  repo init -u https://android.googlesource.com/platform/manifest -b android11-qpr2-release
  repo sync -c -j 64
  ```

- Building Android
   ```
   source build/envsetup.sh
   ```
   - Build target
     - Use ``` lunch ``` with no additional arguments to check all available variants.
     - This process can take around 3~5 hours to finish depending on the computing power
     - You can speed up the build process by adding additional threads, that however is limited by computing engine
   ```
   lunch aosp_x86_64 \
   m -j 64
   ```

### 5. Clean up
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
