pipeline {
     agent any
     stages {
        stage('Cluster Context Set Up'){
            steps {
                withAWS(credentials: 'aws-static', region: 'us-west-2') {
                    sh 'echo "Deploying Image/Creating Cluster"'
                    //sh "eksctl create cluster -f /var/lib/jenkins/workspace/meOfLife-using-Amazon-AWS_master/Conf/clusterConf.yml"
                    sh "aws eks --region us-west-2 update-kubeconfig --name mcluster"
                }
            }
         }
         stage('Green/Blue Conntroller') { 
            steps {
                    withAWS(credentials: 'aws-static', region: 'us-west-2') {
                      
                      sh "kubectl apply -f /var/lib/jenkins/workspace/meOfLife-using-Amazon-AWS_master/Conf/greenController.yml" 
                    sh 'echo "Green/Blue Conntroller"'
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
                        //sh "kubectl apply -f /var/lib/jenkins/workspace/meOfLife-using-Amazon-AWS_master/Conf/BGService.yml"
                        //sh "kubectl create deployment firstdeploy2 --image=$registry:45"
                        sh "kubectl get svc"
                        sh "kubectl get nodes"
                        sh "kubectl get pods"
                        sh "kubectl config get-contexts"
                        //sh 'echo "Update Service"'
                  }
            }
        }
        stage('Clean Up') { 
              steps { 
                  sh "docker rmi $registry:blue"
                  
                  withAWS(credentials: 'aws-static', region: 'us-west-2') {
                    //sh "eksctl delete cluster --name=mcluster --wait"
                    sh 'echo "Clean Up"'
                  }
            }
        }
     }
    post {
        always {
            //sh "docker rmi $registry:blue"
            sh 'docker system prune'
            sh 'echo "Garbage collected"'
        }
    }
}