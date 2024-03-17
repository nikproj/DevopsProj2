pipeline {
    agent {
        label 'default'
    }
    stages {
        
        stage('get the code') {
            steps {
                git branch: 'main', url: 'https://github.com/Nikhil-tr/DevopsProj2.git'
            }
        }
        
        stage('build docker image') {
            steps {
                sh 'docker build --file $WORKSPACE/myfiles/dockerfile --tag docker.io/nikhiltr1/devopsproj2:latest $WORKSPACE'
            }
        }
        
        stage('Push to docker-hub') {
            steps {
                echo 'push......'
                withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login docker.io -u nikhiltr1 -p ${dockerhubpwd}'
                    sh 'docker push docker.io/nikhiltr1/devopsproj2:latest'
                }                
            }
        }
        
        stage('Deploy on production') {
            steps {
                sh 'kubectl apply -f $WORKSPACE/myfiles/kube.yaml'
            }
        } 
    }
}
