pipeline {
     agent any
     stages {

        stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
        stage('Build Image') { 
              steps { 
                  sh 'make build'
            }
        }
        stage('Security Scan') {
              steps { 
                  aquaMicroscanner imageName: 'site:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'string'
              }
         } 
        stage('Upload Image') {
              steps {
                  sh 'echo "Image Uploaded";'
              }
         }
        stage('Clean Up') { 
              steps { 
                  sh 'make clean'
            }
        }
     }
}