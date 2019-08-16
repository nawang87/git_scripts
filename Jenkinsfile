pipeline {
  agent none
  stages {
    stage('build') {
      steps {
        sleep 10
      }
    }
    stage('review') {
      steps {
        build 'linux'
      }
    }
  }
}