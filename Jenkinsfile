pipeline {

     environment {
        registry = "cabreu90/site"
        registryCredential = 'dockerhub'
        dockerImage = ''
        greenOrBlue= "green"
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
                   dockerImage= docker.build registry + ":$greenOrBlue"   
                  }
            }
        }
        stage('Security Scan') {
              steps { 
                  aquaMicroscanner imageName: registry+":$greenOrBlue", notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'string'
                  sh 'echo "Security Scanning Image"'    
              }
         } 
    }
}