pipeline { 
    agent any 
environment { 
registry = '358904724000.dkr.ecr.ap-south-1.amazonaws.com/jenkins-repo'
    registryCredential = 'aws-cred'
    dockerImage = ''
    IMAGE_NAME= '358904724000.dkr.ecr.ap-south-1.amazonaws.com/jenkins-repo:latest'
    TRIVY_REPORT_FILE='trivy-report.html'
    
    } 
parameters { 
	string(name: 'GITHUB_URL', defaultValue: 'https://github.com/ashwini-chimkode/junti-jacoco-new.git', description: 'GitHub URL of your project') 
	string(defaultValue: "main", description: 'Branch Specifier', name: 'BRANCH_SPECIFIER') 
	booleanParam( name: 'CLEAN_WORKSPACE', defaultValue: true, description: 'Do you want to clean last workspace?') 
// 	string(name: 'SONARQUBE_URL', defaultValue: 'http://3.111.43.66:9000', description: 'SonarQube URL for your project') 
//     string(name: 'SONARQUBE_TOKEN', defaultValue: '', description: 'SonarQube authentication token for your project')
    string(name: 'IMAGE_NAME', defaultValue: '', description: '')
} 
stages {
 stage('Clean workspace'){
 when {
 expression { return params.CLEAN_WORKSPACE }
 } 
steps{ 
echo "-=- ===== Cleaning up the workspace"
 deleteDir()
 echo "-=- ===== Finished cleaning workspace ..." 
echo "-=- ==================================================================================== -=-" 
} 
}

// stage('Install AWS CLI') {
//       steps {
//           sh' whoami'
//         sh 'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'
//         sh 'unzip -o awscliv2.zip'
//         sh 'pwd'
//       // sh 'chmod -R 755 /usr/local/aws-cli/'
//         sh 'sudo ./aws/install --update'
 
//       }
//     }
stage('Git Checkout ') {
      steps {
checkout([$class: 'GitSCM', branches: [[name: "${params.BRANCH_SPECIFIER}"]], extensions: [], userRemoteConfigs: [[url: "${params.GITHUB_URL}"]]])
      }
}

// stage('Class Compiler') { 
//     steps { 
//             sh 'mvn compiler:compile' 
            
//     } 
// }

stage('Build') { 
    steps { 
        // sh 'whoami'
        // sh 'sudo chmod -R 775 /var/lib/jenkins/workspace/' 
        // sh 'chown -R jenkins:jenkins /var/lib/jenkins/workspace/' 
        // sh 'chgrp -R jenkins /var/lib/jenkins/workspace/' 
        // sh 'mvn clean install'
        // sh 'mvn clean package' 
        //sh 'mvn package -DskipTests=true' 
        sh 'mvn war:war'
        
        echo "***** Artifact Build successfully completed *****" 
    } 
}

//   stage('Unit-Test') { 
//       steps { 
//           sh 'mvn test' 
//           //sh 'junit "target/surefire-reports/*.xml" '
//           //sh 'mvn jacoco:report -debug'
          
//       } 
//      } 
     
//      stage("code coverage"){
//      steps{
         
//          sh 'mvn jacoco:report -debug'
//         // junit "target/surefire-reports/junitreports/*.xml"
//          step( [ $class: 'JacocoPublisher' ] )
//          echo "***** successfully completed *****" 
// }
// }
// stage('Sonarqube Analysis') {
//     steps {
        
//     withSonarQubeEnv('sonarqube') {
//     //  sh 'mvn sonar:sonar'
//      // sh "mvn clean package sonar:sonar -Dsonar.projectKey=java-demo -Dsonar.projectName=java-demo"
//      // "mvn clean package sonar:sonar -Dsonar.login=${params.SONARQUBE_TOKEN} -Dsonar.host.url=${params.SONARQUBE_URL}"  
//   //sh 'mvn sonar:sonar -Dsonar.projectKey=jenkins-coverage -Dsonar.host.url=http://3.111.43.66:9000 -Dsonar.login=7a487b262722826775841a883908897de3255202'

// sh 'mvn sonar:sonar -Dsonar.projectKey=new-pipeline -Dsonar.host.url=http://3.111.43.66:9000 -Dsonar.login=a7035b6ba28da33abd30b2e6a2caef5a2c9eb1b8'
        
//     }
// }
// }
// stage("Quality gate") {
//     steps {
//         sleep(15)
//                 timeout(time: 3, unit: 'MINUTES') {
//             waitForQualityGate abortPipeline: true
            
//         }
          
//      }
    
// }
//  stage('OWASP Dependency Check (SCA)') { 
//       steps { 
//         sh ' mvn clean install dependency-check:check -Dformat=XML package ' 
//         dependencyCheckPublisher pattern: 'target/dependency-check-report.xml' 
//         } 
//     }

 stage('Publish build info') {
        steps {
            
            echo "***** Artifact Info*****" 
                rtServer (
                    id: "Artifactory" ,
                    url: "http://65.1.3.148:8082/artifactory/Jenkins-Artifactory",
                      username:"admin" ,
                      password:"Admin@5499" ,
                      bypassProxy: true ,
                      timeout: 300
                )
             }
         }

 stage('Upload Artifact to Artifact Repository') {
     steps {
         
         echo "***** Artifact uploaded successfully *****" 
         rtUpload (
            serverId: 'Artifactory',
            spec: '''{
                "files": [
                    {
                "pattern": "*.war",
                "target": "Jenkins-Artifactory/"
                    }
                ]
            }''',
        buildName: 'jfrog',
        buildNumber: '01'
        )
    }
}
  
//  stage('Publish build info') {
//         steps {
            
//             echo "***** Artifact Info*****" 
//                 // rtServer (
//                 //     id: "jfrog123" ,
//                 //     url: "http://10.53.96.169:8082/artifactory/jfrogrepo/",
//                 //       username:"admin" ,
//                 //       password:"@Dmin123" ,
//                 //       bypassProxy: true ,
//                 //       timeout: 300
//                 // )
//              }
//          }

//  stage('Upload Artifact to Artifact Repository') {
//      steps {
         
//          echo "***** Artifact uploaded successfully *****" 
//         //  rtUpload (
//         //     serverId: 'jfrog123',
//         //     spec: '''{
//         //         "files": [
//         //             {
//         //         "pattern": "Spring*.war",
//         //         "target": "jfrogrepo/"
//         //             }
//         //         ]
//         //     }''',
//         // buildName: 'spring1',
//         // buildNumber: '01'
//         // )
//     }
// }

//   stage ('Deploy-To-Dev Env-Tomcat') { 
//       steps{ 
//           sshagent(['SSH-Key']) { 
//           sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@3.111.43.66:/opt/tomcat/apache-tomcat-9.0.72/webapps' 
//          } 
//     } 
// } 

//  stage ('Deployment validation') {
//       steps{ 
//           sh 'sh checkdeployment.sh'
//          } 
//     } 
    
// stage('build docker image') {
//       steps{
//         script {
//           dockerImage = docker.build registry 
//         }
//       }
//     }

// stage('Install Trivy') {
//       steps {
//         sh 'wget https://github.com/aquasecurity/trivy/releases/download/v0.19.2/trivy_0.19.2_Linux-64bit.tar.gz'
//         sh 'tar zxvf trivy_0.19.2_Linux-64bit.tar.gz'
//         sh 'sudo mv trivy /usr/local/bin'
//       }

//     }
    
// stage('container security') {
//       steps {
//         sh 'trivy image ${IMAGE_NAME}'
//         sh 'trivy image -o ${TRIVY_REPORT_FILE} ${IMAGE_NAME}'
//         // sh 'trivy image java_project_ingress.okts.tk'
//         // sh 'trivy image mysql:5.6'
//       }

//     }    
// stage('Push docker image to AWS-ECR') {
//         steps{
//             script{
//                 docker.withRegistry("https://" + registry, "ecr:ap-south-1:" + registryCredential) {
//                     dockerImage.push()
//                 }
//             }
//         }
//     }  
     
//      stage('Deploy TO QA-ECS Cluster') {
//         steps{
//             script{
//                 sh ' aws ecs update-service --cluster Jenkins-Cluster --service Jenkins-Service --task-definition jenkins-task-def'
//             }
            
//         }
//     }
    
// stage('Functional Test') {
// steps {
// sh ' mvn clean test '
// // sh ' mvn test -Dtest=LoginPageTest '
// // This command helpfull for purpose of run specific test cases.
// // sh 'mvn test -Dtest=AccountsPageTest'
// //perfReport filterRegex: '', showTrendGraphs: true, sourceDataFiles: 'target/vinod-Selenium-Test/*.xml'

// }
// }

// stage('Performence Test') {
// steps {
// sh ' mvn clean verify '
// perfReport filterRegex: '', showTrendGraphs: true, sourceDataFiles: 'target/jmeter/results/*.csv'
// //perfReport filterRegex: '', showTrendGraphs: true, sourceDataFiles: 'target/jmeter/results/*.html'
// //perfReport filterRegex: '', showTrendGraphs: true, sourceDataFiles: 'target/jmeter/results/*.jtl'
// }
// }
     
 } 
 }
