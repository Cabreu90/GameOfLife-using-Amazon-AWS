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
        stage('Security Scan') {
              steps { 
                  aquaMicroscanner imageName: registry+":$BUILD_NUMBER", notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'string'
              sh 'echo "Sucurity scanned"'
              }
         } 
        stage('Upload Image') {
              steps {
                  script {
                      docker.withRegistry( '', registryCredential ) {
               //           dockerImage.push()
                           }
                  }
              }
         }
        stage('Clean Up') { 
              steps { 
                  sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
     }
    post {
        always {
            //sh "docker rmi $registry"
            sh 'docker system prune'
        }
    }

}