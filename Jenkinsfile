pipeline {

     environment {
        registry = "cabreu90/site"
        registryCredential = 'dockerhub'
        dockerImage = ''
        }

     agent any
     options {
            withAWS(profile:'myProfile')
     }
     stages {

        stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
                  //Do: hadolint Dockerfile
              }
         }
        stage('Build Image') { 
              steps { 
                  script {
                   //dockerImage= docker.build registry + ":$BUILD_NUMBER"   
                   sh 'echo "Building Image"'
                  }
            }
        }
        stage('Security Scan') {
              steps { 
                  //aquaMicroscanner imageName: registry+":$BUILD_NUMBER", notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'string'
                  sh 'echo "Security Scanning Image"'    
              }
         } 
        stage('Upload Image') {
              steps {
                  script {
                //      docker.withRegistry( '', registryCredential ) {
               //           dockerImage.push()
                        sh 'echo "Uploading Image"'
                           }
                  }
              }
        stage('Cluster Context Set Up'){
            steps {
             sh 'echo "Deploying Image/Creating Cluster"'
            sh "eksctl create cluster -f Conf/clusterConf.yaml"
             //sh 'make test'
            }
         }
         stage('Green/Blue Conntroller') { 
              steps {
                 // sh "kubectl apply -f ./greenController.yml" 
                  sh 'echo "Green/Blue Conntroller"'
            }
        }
        stage('Traffic Routing') { 
              steps { 
                  sh 'echo "Traffic Routing"'
            }
        }
        stage('User Test') { 
              steps { 
                  
                  sh 'echo "User Test"'
            }
        }
        stage('Deploy') { 
              steps { 
                  // kubectl apply -f ./BGService.yml
                  sh 'echo "Update Service"'
            }
        }
        stage('Clean Up') { 
              steps { 
                  //sh "docker rmi $registry:$BUILD_NUMBER"
                  sh 'echo "Clean Up"'
            }
        }
     }
    post {
        always {
            //sh "docker rmi $registry:$BUILD_NUMBER"
            //sh 'docker system prune'
            sh 'echo "Garbage collected"'
        }
    }

}