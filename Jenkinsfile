pipeline {

	agent any
	triggers {
		pollSCM('* * * * *')
	}
	stages {
		stage("compile") {
			steps {
				sh "./gradlew compileJava"
			}
		}	 

		stage("Unit test") {
			steps {
				sh "./gradlew test"
			}
		}
		stage("Code coverage"){
			steps{
				sh "./gradlew jacocoTestReport"
				publishHTML(target: [
					reportDir: 'build/reports/jacoco/test/html',
					reportFiles: 'index.html',
					reportName: 'Jacoco Report'
					])
				sh "./gradlew jacocoTestCoverageVerification"
			}

		}
		stage("Static code analysis"){
			steps {
				sh "./gradlew checkstyleMain"
				publishHTML(target: [
					reportDir: 'build/reports/checkstyle/',
					reportFiles: 'main.html',
					reportName: "checkStyle Report"
				])
			}
		}
		stage("Package"){
			steps{
				sh "./gradlew build"
			}
		} 
		stage("Docker Build"){
			steps{
				
				sh "docker build  -t jcoj2006/calculator ."
			}
		}
		stage("Docker push image"){
			steps{
			  withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'docker-hub-credentials-Password', usernameVariable: 'docker-hub-credentialsUser')]) {
          				sh "docker login -u ${env.docker-hub-credentialsUser} -p ${env.docker-hub-credentialsPassword}"
          				sh 'docker push jcoj2006/calculator:latest'
				}
			}

		}
	
	}
}
