//jenkins service account
userid = "Jenkins Service Account name"

properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3')), disableConcurrentBuilds()])

node {      
  try 
  {
     env.PATH = "${tool 'ant'}\\bin;${env.PATH}" 
  
     def commitId=0
     def rc = 0
     currentBuild.result = 'SUCCESS'
    
     stage ('Checkout Changes')
   		{
              if(SCMCommitId != '')
              {
                commitId= SCMCommitId

               checkout([$class: 'GitSCM', branches: [[name: "${commitId}" ]],
               userRemoteConfigs: [[credentialsId:  'nlsvc-jenkins-docker', url: "${SCMURL}"]]])
              }
              else
              {
                cho = checkout(scm)
                commitId = cho.GIT_PREVIOUS_SUCCESSFUL_COMMIT
                
                if (commitId == null || commitId =='' || commitId == 0)
                {
                	commitId1 = sh returnStdout: true, script: "git rev-list --max-parents=0 HEAD"
                   // commitId1 = sh returnStdout: true, script: "git rev-list HEAD | tail -n 1"
                  
                  echo "commitId1"
             	  echo commitId1.toString()  
                  commitId = commitId1.toString();
                }
              }
		  echo "commitId"
             echo commitId        	 
          
            
               //rc = sh returnStatus: true, script: "'chmod -R 755 /var/jenkins_home/workspace/SFDC DevOps Demo/SFDC_Jenkins_Pipeline_Demo_GitLabCognizant'"
 	           rc = sh returnStatus: true, script: "scripts/manifest_jenkins.sh ${commitId} "
               
               if(rc != 0)
                {
                  echo "Build Failure"
                  currentBuild.result = 'FAILURE'
                }
              else
                {
                   echo "Executing scripts/buildproject.sh..."
                   rc = sh returnStatus: true, script: "scripts/buildproject.sh project-manifest.txt"
                }
              
               
               
            
           
        }// End stage Checkout changes
    
       
    	
		if(rc != 0)
            {
              currentBuild.result = 'FAILURE'
            }
        else
            {
              stage ('Deploy to CI')
                 {
                    rc = sh returnStatus: true, script: "ant generatePackage"
					
                    if(rc != 0)
                    {
                      currentBuild.result = 'FAILURE'
                    }
                    else
                    {
                      rc = sh returnStatus: true, script: "ant deploy -Dusername=${sfusernameci} -Dpassword=${sfpasswordci} -Dserverurl=${sfserverurl} -DmaxPoll=20 -Ddeployroot=src -Dproxyhost=proxy.cognizant.com -Dproxyport=6050"	
                    }
                                   
                         
                  }// End of stage Deploy to CI
            }   
         if(rc != 0)
           {
             currentBuild.result = 'FAILURE'
           }
          else
            {   
              currentBuild.result = 'SUCCESS'
            }
   
    
    }// End of try
    catch (any) 
    {
        currentBuild.result = 'FAILURE'
        throw any //rethrow exception to prevent the build from proceeding
    } 
    finally 
    {

    }
   
}

