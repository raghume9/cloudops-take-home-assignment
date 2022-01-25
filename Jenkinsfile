pipeline {
    agent {
        label 'docker-maven-slave'
    }
    stages{
        stage("Init") {
            steps {
                echo "Initialize docker"
                script{
                    with credentials([[$class        : 'UsernamePasswordMultiBinding',
                                        credentailId : '<<Jenkins Credential ID'>>,
                                        usernameVariable: 'DOCKER_USER',passwordVariable: 'DOCKER_PASS']])
                {
                        def loginCmd = "docker login --username $DOCKER_USER --password $DOCKER_PASS 'https://hub.docker.com' \n"
                        command(loginCmd)
                }
            }
        }

        stage('Docker Build') {
            steps {
                echo "Building docker image"
                script {
                   with credentials([[$class        : 'UsernamePasswordMultiBinding',
                                                           credentailId : '<<Jenkins Credential ID'>>,
                                                           usernameVariable: 'DOCKER_USER',passwordVariable: 'DOCKER_PASS']])
                   {
                        docker image = docker.build("hub.docker.com/App")
                        image.push("https://hub.docker.com/app")
                   }
                }
            }

        }
        stage("Deploy to EC2") {
            steps {
                echo " Deploying to cloud"
                withCredentials([string[credentailId:"CredentialID"], variable: "token"),
                string(credentailId: "${containerspace}", variable: "container_space")]) {
                command "*"
                prepare_deployment(){
                //prepare the deployment to cloud or Kubernetes
                //for AWS we can define code deploy
                //For Kubernetes we can define deployment.json, services.json and networkpolicies.json
                }
                launch_deployment(){
                //To apply the changes and launch the K8S environment includes the PoDs
                }
                }
            }
        }
    }
 }