pipeline {
    agent {
        label 'lala-agent'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t sharjil:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f myapp || true
                docker run -d --name myapp -p 80:80 sharjil:latest
                '''
            }
        }
    }
}
