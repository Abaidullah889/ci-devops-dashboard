pipeline {
    agent any

    environment {
        BASH = "C:\\Program Files\\Git\\bin\\bash.exe"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                bat "\"${BASH}\" -c 'pip install -r requirements.txt'"
            }
        }

        stage('Run Tests') {
            steps {
                bat "\"${BASH}\" -c 'chmod +x ci/run_tests.sh && ./ci/run_tests.sh'"
            }
        }

        stage('Archive Results') {
            steps {
                archiveArtifacts artifacts: '**/results.json', fingerprint: true
            }
        }
        stage('Debug') {
            steps {
                bat "\"${BASH}\" -c 'cat ci/run_tests.sh && ls -l && cat results.json'"
            }
}

    }

    post {
        success {
            echo '✅ Build and tests passed!'
        }
        failure {
            echo '❌ Build or tests failed!'
        }
    }
}
