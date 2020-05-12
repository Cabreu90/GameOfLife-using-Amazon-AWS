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
                withAWS(credentials: 'aws-static', region: 'us-west-2') {
                    sh 'echo "Deploying Image/Creating Cluster"'
                    //sh "eksctl create cluster -f /var/lib/jenkins/workspace/meOfLife-using-Amazon-AWS_master/Conf/clusterConf.yml"
                    //sh 'make test'
                }
            }
         }
         stage('Green/Blue Conntroller') { 
            steps {
                withAWS(credentials: 'aws-static', region: 'us-west-2') {
                    sh "kubectl apply -f /var/lib/jenkins/workspace/meOfLife-using-Amazon-AWS_master/greenController.yml" 
                    sh 'echo "Green/Blue Conntroller"'
                }
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
                  sh "kubectl apply -f ./BGService.yml"
                  sh 'echo "Update Service"'
            }
        }
        stage('Clean Up') { 
              steps { 
                  //sh "docker rmi $registry:$BUILD_NUMBER"
                  sh 'echo "Clean Up"'
                  withAWS(credentials: 'aws-static', region: 'us-west-2') {
                  //sh "eksctl delete cluster --name=mcluster"
                  }
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