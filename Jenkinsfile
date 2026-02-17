pipeline {
    agent { 
        label "${LABEL_NAME}" 
    }

    options {
        timestamps()
        buildDiscarder(logRotator(
            artifactDaysToKeepStr: '',
            artifactNumToKeepStr: '',
            daysToKeepStr: '1',
            numToKeepStr: '2'
        ))
    }

    environment {
        IMAGE_NAME     = "iammay786/myimg"
        IMAGE_TAG      = "${BUILD_NUMBER}"
        CONTAINER_NAME = "webapp"
        DOCKER_CREDS   = credentials('dockerhub-creds')
    }

    stages {

        stage('CODE') {
            steps {
                git url: "https://github.com/iammay786/dockerimgpush.git",
                    branch: "main"
            }
        }

        stage('BUILD') {
            steps {
                sh """
                    docker build -t $IMAGE_NAME:$IMAGE_TAG .
                    docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
                """
            }
        }

        stage('IMAGE_CHECK') {
            steps {
                sh """
                    trivy image --severity CRITICAL \
                    --exit-code 1 \
                    $IMAGE_NAME:$IMAGE_TAG
                """
            }
        }

        stage('IMAGE_PUSH') {
            steps {
                sh """
                    echo $DOCKER_CREDS_PSW | docker login \
                    -u $DOCKER_CREDS_USR --password-stdin

                    docker push $IMAGE_NAME:$IMAGE_TAG
                    docker push $IMAGE_NAME:latest
                """
            }
        }

        stage('DEPLOY') {
            steps {
                sh """
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true

                    docker run -d \
                        --name $CONTAINER_NAME \
                        --restart always \
                        -p 80:5000 \
                        $IMAGE_NAME:$IMAGE_TAG
                """
            }
        }
    }

    post {
        success {
            echo "Deployment Successful ✅"
        }
        failure {
            echo "Deployment Failed ❌ - Please Check Logs"
        }
    }
}
