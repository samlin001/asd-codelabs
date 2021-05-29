# Set Up a System Development Environment on the Cloud
In this code lab, you will learn how to create a virtual machine on
Google Cloud Platform(GCP) and access it by Chrome Remote Desktop(CRD) for
Android system development.

The whole code lab should take around 30 minutes

## Android development on the cloud
![Android Development on the cloud](res/Android%20System%20Development%20On%20The%20Cloud.png)

## Create a new GCP project
In this example, we will create a new project: **ASD Codelab1**.
Alternatively, You can use an existing project if it fits better.

1. Follow the instructions for [Creating a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project)
    - Project name: **ASD Codelab1**
    - Keep the Project ID handly as it's the unique identifier for your project.
    **my-project-id** is used as an example. Which should be replaced with the
     Project ID.

<img src="res/startProj.png" width="400">

2. If you never enable billing, [Enable billing](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project)
first. So, you can proceed with the following steps.

3. Enable Compute Engine API
    - In [GCP Console](http://console.cloud.google.com/), select the project: **ASD Codelab1**
    - Search **compute** to select **Compute Engine API**
    - Select **Enable**

<img src ="res/SelectProj.png" width="800">
<img src="res/compute.png" width="800">

4. Check the project by [Cloud Shell](https://cloud.google.com/shell)
    - Read [Using Cloud Shell](https://cloud.google.com/shell/docs/using-cloud-shell)
    if Cloud Shell is new to you.
    - Take the time to get familiar with
    [Running gcloud commands with Cloud Shell](https://cloud.google.com/shell/docs/running-gcloud-commands),
    because you are going to use it a lot in the code labs.
    - To verify if the project exists, you can list & grep the ID in [Cloud Shell Editor](https://shell.cloud.google.com).
     Remember to replace **asd-codelab1** to the Project ID above.
```
export PROJECT_ID="my-project-id"
gcloud projects list | grep ${PROJECT_ID}

echo "Set the default project for the section"
gcloud config set project ${PROJECT_ID}
```

## Create a VM
Now, let's create a VM with a custom image for development. By using a custom
image you can skip many setup steps. In this example, we use the custom image:
**asd-android11-qpr2**. Wich includes all the software required for Android
system development:
  - Linux: ubuntu 18.04
  - Python 2.7 as repo depends on it.
  - Set up for [Downloading Android Source](https://source.android.com/setup/build/downloading)
    - repo in /ws/bin
    - android11-qpr2-release source code in /ws/android
  - [Android Studio 4.2.1](https://developer.android.com/studio)
    - Android Studio in /ws/android-studio
    - Android Sdk in /ws/Android/Sdk
  - ASD codelabs in /ws/asd-codelabs

### Steps
1. Read [Create a VM from a custom image](https://cloud.google.com/compute/docs/instances/create-start-instance#create_a_vm_from_a_custom_image).

2. Create a VM:**asd-vm1** by the custom image: **asd-android11-qpr2** by
Cloud Shell.
    - The command reference: [gcloud compute instances create](https://cloud.google.com/sdk/gcloud/reference/compute/instances/create).
    - [The map of Cloud locations](https://cloud.google.com/about/locations#regions).
    - How to pick a zone: [Available regions and zones](https://cloud.google.com/compute/docs/regions-zones), e.g. us-west2-a for California.

In [Cloud Shell Editor](https://shell.cloud.google.com):
```
gcloud compute instances create asd-vm1 \
  --image-project=asd-codelab1 \
  --image=asd-android11-qpr2 \
  --custom-extensions --custom-cpu=8 --custom-memory=32GB \
  --min-cpu-platform "Intel Haswell" \
  --zone=us-west2-a

echo "List VMs"
gcloud compute instances list
```

3. You can also check it at the console: [VM instances](https://console.cloud.google.com/compute/instances).

<img src="res/VerifyVMCreation.png" width="800">

## Connect to the VM
There are 2 ways to connect to the VM on the cloud to use it: 1) SSH and 2)
Chrome Remote Desktop(CRD). For the first time setup, you need to use both in that
order. After the setup, you can use CRD for most of work.

1. SSH
    - In [VM instances](https://console.cloud.google.com/compute/instances), click
**SSH**,  a web page will be opne & connect to the VM via SSH.

    - One-time setup of a new VM
        - Even the custom image includes all software, there are still a few
         steps required to make a new VM ready.
        - Make yourself as the new owner of /ws/* & get the latest asd-codelabs.
         This will take about 3 min.
        ```
        echo "Make ${USER} as the owner for /ws"
        sudo chown -R ${USER}:${USER} /ws

        echo "Update asd-codelabs"
        cd /ws/asd-codelabs && git reset --hard HEAD && git pull
        ```
        - Use [asd.sh](../asd.sh) setupVm function to do the rest of setup steps
         automatically.
        ```
          echo ".bashrc is the setup script for each new shell section.
          tail ~/.bashrc
          echo "Avoid Windows Newline issues." && sed -i -e 's/\r$//' /ws/asd-codelabs/asd.sh
          /ws/asd-codelabs/asd.sh setupVm
          tail ~/.bashrc
          echo "You should see new lines added & the last line is: export PATH=..."
        ```
        - Stop and then Start the VM in [VM instances](https://console.cloud.google.com/compute/instances).

<img src="res/SSH.png" width="800">

2. Chrome Remote Desktop
    - Chrome Remote Desktop provides GUI, which is easier to use. However, it
     requires more bandwidth than SSH & additional setup.
    - Set it up by [Configuring and starting the Chrome Remote Desktop service](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#configuring_and_starting_the_chrome_remote_desktop_service)
    - To copy & paste between your local machine & the VM, [Enable Clipboard Synchronization](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#enable_clipboard_synchronization).
    - For Windows users: the Windows app for chrome remote desktop is no longer
     supported, use the web app instead.

## Explore the development environment
1. Check the one-time setup
    ```
    echo "List development command alias & you should see studio, etc." && alias
    echo "List functions in asd.sh & you should see asd.sh avdInfo, etc." && asd.sh
    ```
2. Find prebuilt Android tree in **/ws/android** in **Terminal**
    ```
    ls -l /ws/android
    echo "Open it in File Manager"
    xdg-open /ws/android
    ```

3. asd-codelabs project is cloned in **/ws/asd-codelabs** in **Terminal**
    ```
    ls -l /ws/asd-codelabs
    echo "Open it in File Manager"
    xdg-open /ws/asd-codelabs
    ```

4. Run emulator with Android studio

    - Launch Android Studio & [set it up](https://developer.android.com/studio/install#linux)
      ```
      /ws/android-studio/bin/studio.sh
      ```
    - Start [AVD Manager](https://developer.android.com/studio/run/managing-avds)
     from **Welcome to Android Studio** dialog box -> Configure -> AVD Manager.
     Create a Pixel AVD as needed.
    - Double-click the Pixel AVD to run it.

    <img src="res/startAVDManager.png" width="400">
    <img src="res/pixelAVD.png" width="400">

### Stop & Restart VMs
You should stop a VM whenever you don't need it running, and restart as needed,
to reduce [the change](https://cloud.google.com/compute/docs/instances/instance-life-cycle#comparison_table).

- Get to know [VM instance life cycle](https://cloud.google.com/compute/docs/instances/instance-life-cycle).
- To manage it, go to [VM instances](https://console.cloud.google.com/compute/instances),
to click STOP, START &, etc. as fit, e.g.

<img src="res/Stop_resume.png" width="800">

#### Cleanup
If a VM is no longer needed, you can [delete it](https://cloud.google.com/compute/docs/instances/deleting-instance).

## Troble shooting

## Extra Credits
- [The gcloud command-line tool cheat sheet](https://cloud.google.com/sdk/docs/cheatsheet)
- [Linux cheat sheet](https://linoxide.com/images/linux-cheat-sheet-612x792.png)
- [Script cheat sheet](https://cheatography.com/beersj02/cheat-sheets/linux-bash-and-system-administration/)
- [Building your first app](https://developer.android.com/training/basics/firstapp) with Android studio
