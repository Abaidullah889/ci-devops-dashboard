pipeline {
    agent any

    environment {
        BASH = '"C:\\Program Files\\Git\\bin\\bash.exe"'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                bat "${BASH} -c \"pip install -r requirements.txt\""
            }
        }

        stage('Run Tests') {
            steps {
                bat "${BASH} ./ci/run_tests.sh"
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
            echo '✅ Build and tests passed!'
        }
        failure {
            echo '❌ Build or tests failed!'
        }
    }
}
