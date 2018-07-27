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
				
				sh "docker build  -t calculator  ."
				sh "docker tag calculator jcoj2006/calculator:latest"
			}
		}
		stage("Docker push image"){
			steps{
				withCredentials([usernamePassword( credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          				sh "docker login -u ${USERNAME} -p ${PASSWORD}"
          				sh "docker push jcoj2006/calculator:latest"
				}
			}

		}
		stage("Deploy to staging"){
			steps{
				sh "docker run -d --rm -p 8765:8080 --name calculator jcoj2006/calculator"
			}
		}
		stage("Acceptance test"){
			steps{
				sleep 60
				sh "./acceptance_test.sh"
			}
		
		}
	}
	post{
		always {
			sh "docker stop calculator"
		}		
			
	}
	
}
