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
                  sh 'echo "Security Scanning Image"'    
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
        stage('Cluster Context Set Up'){
            steps {
                withAWS(credentials: 'aws-static', region: 'us-west-2') {
                    sh "aws eks --region us-west-2 update-kubeconfig --name mcluster"
                }
            }
         }
         stage('Green/Blue Conntroller') { 
            steps {
                    withAWS(credentials: 'aws-static', region: 'us-west-2') {                      
                      sh "kubectl apply -f /var/lib/jenkins/workspace/meOfLife-using-Amazon-AWS_master/Conf/greenController.yml"
                      sh "kubectl apply -f /var/lib/jenkins/workspace/meOfLife-using-Amazon-AWS_master/Conf/blueController.yml" 
                    }
            }
        }
        stage('User Test') { 
              steps { 
                  sh 'echo "User Test"'
            }
        }
        stage('Deploy') { 
              steps {
                  withAWS(credentials: 'aws-static', region: 'us-west-2') {
                        sh "kubectl apply -f /var/lib/jenkins/workspace/meOfLife-using-Amazon-AWS_master/Conf/BGService.yml"
                        sh "kubectl get svc"
                        sh "kubectl get nodes"
                        sh "kubectl get pods"
                        sh "kubectl config get-contexts"
                        sh "kubectl describe pods"
                        sh "kubectl describe services/my-service"
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
            sh 'docker system prune'
        }
    }
}