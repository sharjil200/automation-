pipeline {
    agent {
        label 'lala-agent'
    }

    environment {
        IMAGE_NAME = 'proteus-site'
        CONTAINER_NAME = 'proteus'
        HOST_PORT = '80'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Docker') {
            steps {
                sh '''
                if ! command -v docker >/dev/null 2>&1; then
                    echo "Installing Docker..."
                    sudo apt update
                    sudo apt install -y docker.io
                    sudo systemctl enable docker
                    sudo systemctl start docker
                else
                    echo "Docker is already installed."
                fi

                sudo systemctl start docker || true
                docker --version || sudo docker --version
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                if docker ps -aq -f name=${CONTAINER_NAME} | grep -q .; then
                    docker rm -f ${CONTAINER_NAME}
                fi
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker run -d \
                    --name ${CONTAINER_NAME} \
                    -p ${HOST_PORT}:80 \
                    ${IMAGE_NAME}
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                docker ps
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
