# Customize your own development environment
This code lab will show you how to create a custom image for ASD from scratch.

## Steps
1. Create a VM
2. Chrome remote desktop
3. Setting up a build environment and build
4. Creating an image from vm
5. Sharing images to the public

### 1. Create a VM to config the development environment
- Understand [the public and custom images](https://cloud.google.com/compute/docs/images).
- Recommended machine specs
  - What are the [Machine types](https://cloud.google.com/compute/docs/machine-types)?
    - How do I [Create a VM instance with a custom machine type](https://cloud.google.com/compute/docs/instances/creating-instance-with-custom-machine-type#create)?
  - Recommend using at least 520 GB for boot disk size, for [better performance](https://cloud.google.com/compute/docs/disks/performance#performance_by_disk_size).
    - If you are using the VM for building Android, it needs at least 400 GB, [250Gb for Android source, 150Gb to build](https://source.android.com/setup/build/requirements#hardware-requirements)
- You can either start with an existing custom image or a public Linux image.

#### Base on an existing custom image
If you just want to add new software or change some configuration, this is a good option for you.
```
gcloud compute instances create <YOUR_VM_NAME> \
    --enable-nested-virtualization \
    --machine-type n1-highcpu-32 \
    --min-cpu-platform="Intel Haswell"
    --image-project=<PROJECT_NAME_OF_THE_IMAGE> \
    --image=<IMAGE_NAME> \
```

#### Base on a Linux public image
To build from scratch, follow the instruction.
```
gcloud compute instances create <YOUR_VM_NAME> \
    --enable-nested-virtualization \
    --machine-type n1-highcpu-32 \
    --min-cpu-platform="Intel Haswell"
    --image-family=ubuntu-1804-lts
    --image-project=ubuntu-os-cloud
    --create-disk size=520,type=pd-standard
```

### 2. Setup Chrome Remote Desktop(CRD) to acess GUI
Use Cinnamon for better result
- [Installing Chrome Remote Desktop on the VM instance](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#installing_chrome_remote_desktop_on_the_vm_instance)
- [Installing Cinnamon desktop environment](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#installing_an_x_windows_system_desktop_environment)
- [Configuring and starting the Chrome Remote Desktop service](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#configuring_and_starting_the_chrome_remote_desktop_service)
- (Optional) Changing terminal scheme
  - Edit > Prefrences > Colors > Built-in schemes: Green on black
### Install softwares
- [Setup environment](https://source.android.com/setup/build/initializing)
```
   sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
   ```
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
- qemu-system-x86 (Only for Ubuntu 18.04)
  ```
  sudo apt update
  sudo apt install qemu-system-x86
  ```
- qemu-kvm (Only for Ubuntu 18.04)
  ```
  sudo apt install qemu-kvm
  sudo adduser $USER kvm
  ```
- Visual Studio Code (Todo: add to script)
  - VS allows user to edit documents without using vim
  - [Install Visual Studio on Linux](https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions)
  - Todo: Move to WS and chown.
- Android studio (Todo: add to script)
  - Follow the instructions to [install Android studio on Linux](https://developer.android.com/studio/install#linux)
  - After installing, open up Android Studio and create a blank project, this will speed up the setup for others.
  - Move Android studio into /ws folder

### 3. Pre-build Android
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

### Clean up
- Remove yourself from KVM group
  ```
  sudo deluser $USER kvm
  ```
- Cleanup the downloaded package and temporary files
  ```
  apt clean
  rm -rf /tmp/* ~/.bash_history
  ```
- Change owner and permission of /ws
  ```
  sudo chown -R ${USER}:${USER} /ws
  ```
- [Deauthorize Chrome Remote Desktop for the instance](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#deauthorize_chrome_remote_desktop_for_the_instance)

### 4. Create and publish an image
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
