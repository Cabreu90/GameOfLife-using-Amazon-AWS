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
     }
}