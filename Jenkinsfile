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
				sh "docker build -H=127.0.0.1:2375 -t jcoj2006/calculator."
			}
		}
			
	}
}
