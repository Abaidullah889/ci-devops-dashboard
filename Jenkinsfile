pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/YOUR_USERNAME/ci-devops-dashboard.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                sh './ci/run_tests.sh'
            }
        }

        stage('Archive Results') {
            steps {
                archiveArtifacts artifacts: 'results.json', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Build and test passed!'
        }
        failure {
            echo '❌ Build or test failed!'
        }
    }
}
