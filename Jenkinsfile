pipeline {
  agent any

  environment {
    IMAGE_NAME = 'rajijay/jenkins-demo-app'
    TAG = 'latest'
    DOCKERHUB_USER = credentials('dockerhub-creds').username
    DOCKERHUB_PASS = credentials('dockerhub-creds').password
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'cd app && npm install'
      }
    }

    stage('Run Tests') {
      steps {
        sh 'cd app && npm test'
      }
    }

    stage('Docker Build & Push') {
      steps {
        script {
          sh """
          docker build -t $IMAGE_NAME:$TAG .
          echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin
          docker push $IMAGE_NAME:$TAG
          """
        }
      }
    }

    stage('Deploy') {
      steps {
        sh 'docker-compose -f deploy/docker-compose.deploy.yml up -d'
      }
    }
  }
}
