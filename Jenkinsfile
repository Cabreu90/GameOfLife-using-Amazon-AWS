pipeline {
     agent any
     stages {

        stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
        stage('Build') { 
              steps { 
                  sh 'run_docker.sh' 
            }
        }
        stage('Security Scan') {
              steps { 
                  aquaMicroscanner imageName: 'site:latest', notCompleted: 'exit 1', onDisallowed: 'fail'
              }
         }  
        stage('Upload Image') {
              steps {
                  sh 'upload_docker.sh'
              }
         }
     }
}