pipeline {
    agent { label 'lala-agent' }

    environment {
        IMAGE_NAME = 'proteus-site'
        CONTAINER_NAME = 'proteus'
        HOST_PORT = '8083'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                    if [ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]; then
                        docker rm -f ${CONTAINER_NAME}
                    fi
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:80 ${IMAGE_NAME}'
            }
        }

        stage('Verify') {
            steps {
                sh 'docker ps -f name=${CONTAINER_NAME}'
            }
        }
    }

    post {
        success {
            echo 'Proteus site deployed successfully. Visit http://<EC2-public-IP> to view it.'
        }
        failure {
            echo 'Build or deployment failed. Check the stage logs above.'
        }
    }
}
