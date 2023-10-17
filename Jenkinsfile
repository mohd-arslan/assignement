pipeline {
    agent any
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mvn"
        // jdk "JAVA_HOME"
    }
 

    stages {

        stage('Code checkout according to environment') {
            steps {
                script{
                    if(params.ENVIRONMENT=='DEVELOPMENT'){
                        git url:'https://github.com/mohd-arslan/assignement.git', branch :'dev'
                        // checkout scmGit(branches: [[name: 'dev']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/mohd-arslan/assignement.git']])
                    }
                    else if(params.ENVIRONMENT=='PRODUCTION'){
                        git url:'https://github.com/mohd-arslan/assignement.git', branch :'Prod'
                        // checkout scmGit(branches: [[name: 'Prod']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/mohd-arslan/assignement.git']])
                    }
                    else{
                        error('Invalid choice')
                    }
                }
            }
        } 
        stage("Build the code"){
            steps{
                sh "ls -a"
                sh "whoami"
                sh "mvn clean package"
            }

        }
        stage("Deploying on tomcat server"){
            steps{
                sh "ls -a"
                sh "cp target/Assignment.war /usr/local/tomcat/webapps"

            }

        }
        


        stage("SonarQube Analysis")
        {
            steps
            {
                withSonarQubeEnv("sonar")
                {
                    sh 'mvn -f pom.xml clean verify sonar:sonar -Dsonar.projectKey=Pipeline-jenkins -Dsonar.projectName=Mini-assignment'
                }
            }
        }

        stage("Upload artifacts")
        {
            steps
            {
                rtUpload(
                    serverId: 'artifactory',
                    spec:'''{
                        "files":[
                        {
                            "pattern": "*.war",
                            "target": "artifactory-server/"
                        }
                    ]
                    }''',
                    )
                    rtPublishBuildInfo( serverId:"artifactory" )

            }
        }

}
post{
            always{
                mail to: "mohd.arslan@nagarro.com", 
                subject: "Test Email",
                body: "Hiii, Here is your pipeline status: ${currentBuild.result}"
                }
            }}
