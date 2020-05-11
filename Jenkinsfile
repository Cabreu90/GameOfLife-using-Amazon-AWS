pipeline {

     environment {
        registry = "cabreu90/site"
        registryCredential = 'dockerhub'
        dockerImage = ''
        }

     agent any
     stages {

        stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
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
             //sh 'make build'
             sh 'make test'
            }
         }
         stage('Green/Blue Conntroller') { 
              steps { 
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
        stage('Update Service') { 
              steps { 
                  
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