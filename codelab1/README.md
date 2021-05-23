# Set Up A System Development Environment on The Cloud
In this code lab, you will learn how to create a virtual machine on
Google Cloud Platform(GCP) and access it by Chrome Remote Desktop(CRD) for
Android system development.

## 1. Create a new GCP project
In this example, we will create a new project: **ASD Codelab1**.
Alternatively, You can use an existing project if it fits better.

1. Follow the instructions for [Creating a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project)
    - Project name: **ASD Codelab1**
    - Project ID: **asd-codelab1**
      - Need to click **Edit** in order to change ***Project ID*** as it can
    not be changed later.
      - This is what it should look like before you hit Create:

![](https://user-images.githubusercontent.com/22556115/118602389-7822e780-b767-11eb-86fd-16e1a645acf4.png)

2. If you've not enabled billing yet, follow [Enable billing](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project).
So you can add VMs later.

3. [Enabling APIs](https://cloud.google.com/apis/docs/getting-started#enabling_apis)
    - This step requires you to have enabled billing
    - Go to [Cloud Console API libary](https://console.cloud.google.com/apis/library?project=_&_ga=2.166883581.251529828.1621789213-1106651503.1621789213)
    - Select **ASD Codelab1**
  ![](https://raw.githubusercontent.com/Alwin-Lin/asd-codelabs/main/SelectProj.png)
    - Enter compute and select Compute Engine API
  ![](https://raw.githubusercontent.com/Alwin-Lin/asd-codelabs/main/compute.png)
    - Click enable

4. Use ***Cloud Shell*** to verify the project exists.
     - Follow [Starting a new session](https://cloud.google.com/shell/docs/using-cloud-shell#starting_a_new_session)
  to use Cloud Shell.
     - If [Cloud Shell](https://cloud.google.com/shell) is new to you, take the
  time to get familiar with it, because you are going to use it to complete
  the code labs.
    - To verify the creation of your project, paste the following inside cloud shell:
    ```
    gcloud projects list
    gcloud config set project asd-codelab1
    ```
  If no error occored, feel free to proceed
## 2. Create a VM
- To create a new VM, use the following command in ***Cloud Shell***. And, wait
for it to finish.
```
    gcloud compute instances create asd-codelab1-vm \
        --image-project=gcpsample-311822 \
        --image=aosp-env \
        --custom-extensions --custom-cpu=4 --custom-memory=450 \
        --zone=us-west1-b
```

- Open [VM instances](https://console.cloud.google.com/compute/instances). This
is what you should see once everything is complete:
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
## 4. Chrome Remote Desktop
- install wget and chrome desktop for Debian

```
sudo apt update \
sudo apt-get install --assume-yes wget \
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb \
sudo dpkg --install chrome-remote-desktop_current_amd64.deb \
sudo apt install --assume-yes --fix-broken
```
- Follow the instructions for [Configuring and starting the Chrome Remote Desktop service](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#configuring_and_starting_the_chrome_remote_desktop_service)

## 5. Cleanup
- There are three ways to do so, [disable application](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#disabling_your_application), [disable billing](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#disabling_billing), or [deleteing project](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#deleting_your_project)

## Reference
- Todo: useful materials to explore more
