- Enter an item name : petclinic-ci-job
- Select an item type: Freestyle project
- Description > GitHub project > Project url: https://YOUR_GITHUB_PETCLINIC_PROJECT_REPO_URL
- Source Code Management > Git > Repositories > Repository URL: https://YOUR_GITHUB_PETCLINIC_PROJECT_REPO_URL.git
- Branches to build > Branch Specifier (blank for 'any'): - */dev** 

- Triggers: GitHub hook trigger for GITScm polling
- Environment: Add timestamps to the Console Output
- Build Steps:
      Add build step: Execute Shell
      Command:
              echo 'Petclinic Microservice Project Test'
              docker run --rm \
                -v "$HOME/.m2":/root/.m2 \
                -v "$(pwd)":/application \
                -w /application \
                maven:3.9.6-eclipse-temurin-17 \
                mvn clean test
