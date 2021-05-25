# Set Up A System Development Environment on The Cloud
In this code lab, you will learn how to create a virtual machine on
Google Cloud Platform(GCP) and access it by Chrome Remote Desktop(CRD) for
Android system development.

## Android developement on the cloud
![Android Developement on the cloud](res/Android%20System%20Development%20On%20The%20Cloud.png)

## 1. Create a new GCP project
In this example, we will create a new project: **ASD Codelab1**.
Alternatively, You can use an existing project if it fits better.

1. Follow the instructions for [Creating a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project)
    - Project name: **ASD Codelab1**
    - Project ID: **asd-codelab1**
      - Need to click **Edit** in order to change ***Project ID*** as it can
    not be changed later.
      - This is what it should look like before you hit Create:
<img src="res/startProj.png" width="300">

2. If you've not enabled billing yet, follow [Enable billing](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project).
So you can add VMs later.

3. [Enabling APIs](https://cloud.google.com/apis/docs/getting-started#enabling_apis)
    - This step requires you to have enabled billing
    - Go to [Cloud Console API libary](https://console.cloud.google.com/apis/library?project=_&_ga=2.166883581.251529828.1621789213-1106651503.1621789213)
    - Select **ASD Codelab1**

      <img src ="res/SelectProj.png" width="300">
    - Enter compute and select Compute Engine API

      <img src="res/compute.png" width="300">

    - Click enable

4. Use ***Cloud Shell*** to verify the project exists.
     - Follow [Starting a new session](https://cloud.google.com/shell/docs/using-cloud-shell#starting_a_new_session)
  to use Cloud Shell.
     - If [Cloud Shell](https://cloud.google.com/shell) is new to you, take the
  time to get familiar with it, because you are going to use it to complete
  the code labs.
    - To verify asd-codelab1 is created, use the following command to list and grab the project name.
    ```
    gcloud projects list | grep asd-codelab1
    ```
    - You can set the project as a default for the section by the following command.
    ```
    gcloud config set project asd-codelab1
    ```

## 2. Createing a VM
This creates a VM with a custom image for development.

The custom image have all the software required for Android system development:
  - Python 2.7 as repo depend on it.
  - ToDo: other installed

### Steps:
1. Use the following command in ***Cloud Shell***.
```
    gcloud compute instances create asd-codelab1-vm \
        --image-project=asd-codelab1 \
        --image=asd-android11-qpr2 \
        --custom-extensions --custom-cpu=4 --custom-memory=450 \
        --zone=us-west1-b
```

2. Check the VM is created at [VM instances](https://console.cloud.google.com/compute/instances), e.g.

    <img src="res/VerifyVMCreation.png" width="300">

## 3. Conecting your local computer to the VM on the cloud
There are two ways to connect the VM on the cloud:

#### SSH
In VM instances, click on **SSH**, the following window should pop up, everything after this will be inputted inside the window.

<img src="res/SSH.png" width="300">

#### Chrome Remote Desktop
Chrome Remote Desktop provides GUI which is easier to use. However, it requires more bandwith than SSH, as well as additional setup.

- Setup Chrome Remote Desktop
    - Follow the instructions for [Configuring and starting the Chrome Remote Desktop service](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#configuring_and_starting_the_chrome_remote_desktop_service)
    - Note: The Windows app for chrome remote desktop is no longer supported, use the web app

## 4. Explore the development enviroment
1. Find android tree
  - Todo: ws\android Screenshot
2. Codelab project location
    ```
    cd ws
    git clone https://github.com/samlin001/asd-codelabs.git
    ```
3. Run emulator with Android studio

### Stopping and re-start VM
If a VM is kept running it will constantly be charged, to prevent such, stop your VM when you are done with a sesstion

To do so, go to [VM instances](https://console.cloud.google.com/compute/instances) and click on STOP to shut it down. The VM can be resumed with the rusume button

<img src="res/Stop_resume.png" width="500">


#### Cleanup
If the VM is no longer needed, you can
- There are three ways to do so, [disable application](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#disabling_your_application), [disable billing](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#disabling_billing), or [deleteing project](https://cloud.google.com/appengine/docs/standard/python3/building-app/cleaning-up#deleting_your_project)

## Reference
- [The gcloud command-line tool cheat sheet](https://cloud.google.com/sdk/docs/cheatsheet)
- [Linux cheat sheet](https://linoxide.com/images/linux-cheat-sheet-612x792.png)
- [Script cheat sheet](https://cheatography.com/beersj02/cheat-sheets/linux-bash-and-system-administration/)
- [Building your first app](https://developer.android.com/training/basics/firstapp) with Android studio
