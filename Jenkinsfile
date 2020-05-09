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
                   dockerImage= docker.build registry + ":$BUILD_NUMBER"   
                  }
            }
        }

        stage('Upload Image') {
              steps {
                  script {
                      docker.withRegistry( '', registryCredential ) {
                          dockerImage.push()
                           }
                  }
              }
         }
        stage('Clean Up') { 
              steps { 
                  sh 'make clean'
            }
        }
     }
    post {
        always {
            sh 'docker image rm site'
            sh 'docker system prune'
        }
    }

}