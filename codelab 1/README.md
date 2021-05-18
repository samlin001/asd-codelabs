# Set Up A System Development Environment on The Cloud
In this code lab, you will learn how to create a virtual machine on Google Cloud Platform(GCP) and access it by Chrome Remote Desktop(CRD) for system development.
## 1. Create a new GCP project
You can use an existing project if it fits better. In this example, we will create a new project: **ASD Codelab1**
1. Follow the instructions for [Creating a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project)
    - Project name: **ASD Codelab1**
    - Project ID: **asd-codelab1**
        - Make sure to click **Edit** to change the project id, since it can not be changed later.
        - This is what it should look like before you hit Create:
![](https://user-images.githubusercontent.com/22556115/118602389-7822e780-b767-11eb-86fd-16e1a645acf4.png)
2. Make sure to [Enabel billing](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project).
3. Use Cloud Shell to verify the project exists
    - Follow [Starting a new session](https://cloud.google.com/shell/docs/using-cloud-shell#starting_a_new_session) to launch Cloud Shell
## 2. Create a VM
Paste the following command into Cloud Shell, wait for it to finish, then navigate to [VM instances](https://console.cloud.google.com/compute/instances)

    gcloud compute instances create asd-codelab1-vm \
        --image-project=gcpsample-311822 \
        --image=aosp-env \
        --custom-extensions --custom-cpu=4 --custom-memory=450 \
        --zone=us-west1-b
        
This is what you should see once everything is complete:
![](https://user-images.githubusercontent.com/22556115/118602391-78bb7e00-b767-11eb-826b-5ae0b3e23e07.png)
## 3. Dev. Env Setup
- In VM instances, click on **SSH**, the following window should pop up, everything after this will be inputted inside the window.
![](https://user-images.githubusercontent.com/22556115/118602390-78bb7e00-b767-11eb-852d-c4645186c750.png)
-  [Setup environment](https://source.android.com/setup/build/initializing)

```
sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```
- Install Python, repo, Java, and libncurses
``` 
  sudo apt-get install python
  sudo apt-get install libncurses5
  sudo apt-get install repo
  sudo apt update
  sudo apt install default-jre
```
- Since the VM is created from an image, everything will be already set up already
## Chrome Remote
- install wget and chrome desktop for Debian

``` 
sudo apt update \
sudo apt-get install --assume-yes wget \
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb \
sudo dpkg --install chrome-remote-desktop_current_amd64.deb \
sudo apt install --assume-yes --fix-broken
``` 
- Follow the instructions for [Configuring and starting the Chrome Remote Desktop service](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#configuring_and_starting_the_chrome_remote_desktop_service)

## Cleanup
- There are three ways to do so, [disable application](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#disabling_your_application), [disable billing](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#disabling_billing), or [deleteing project](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#deleting_your_project)
