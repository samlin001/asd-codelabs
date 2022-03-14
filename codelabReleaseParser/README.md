# Android Build Artifact Analysis & Release Parser
This code lab explores Android Build artifacts & how to use a tool, Release Parser to extract information to gain insights from a build in concern.  

## 1. Use Release Parser to analyze sdk_phone_x86_64
Build and setup Jar config
1. Build uber jar
- Open up project in Android studio, run Uber jar
2. Make a output folder
- This is where the parced result will be stored

3. Edit jar config
    - -i: Input folder
    - -o: Output folder
    - -a: Andorid version

    ```
     -i ../releaseParcerSrc/tests/resources -o ../out -a 28
    ```
## 2. Explore the CSV files locally
- Hit run
- Find results
Open up the output folder, we are looking for

## 3. Explore analytics on the Cloud


## 4. Extra credit
- Reelase parcer with cloud build
