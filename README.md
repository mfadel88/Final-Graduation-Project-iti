
# Graduation project
This project to deploy backend application on kubernetes cluster using CI/CD
jenkins pipeline on Google cloud provider using terraform.

# project Chart
![Final-project-iti](https://user-images.githubusercontent.com/93100689/202308616-cd3d5a50-4ce8-49cd-8fe2-bdaaa6f9702d.png)

# Tools
- ### Terraform
   - Infrastructure as a code to execute the app Infrastructure. 
- ### GCP
   - The Google cloud provider which we will use it through our project.
- ### K8s
   - Is an open-source system for automating deployment and management of our containerized applications.
- ### jenkins
   - An open source automation server which we will use to build, test, and deploy our app or software.
- ### GitHub
   - This is the source of our code that al the developers push their code on it.
- ### Docker
   -The platform which we use to build the app image.
## Terraform script structure section by section
### 1- cloudProvider
   - To define the cloud provider which we will run the script on it and you should to run the below command to sync with cloud platform.
    -  #terraform init  
![1](https://user-images.githubusercontent.com/93100689/202312687-98152351-c2e7-49ce-8a05-ab5a2dbb936b.png)

### 2- Main-VPC
   - That contain all of our Infrastructure.
   ![2](https://user-images.githubusercontent.com/93100689/202312999-da74cf17-9184-40b2-83d1-ad0052230f53.png)

### 3- Subnets
   - #### private-mangment-subnet.
     contain the cluster, worker nodes, jenkins, and slave1.
   - #### restricted-subnet.
     Contain the private-VM that we will use to connecy on the cluster.

 ![3](https://user-images.githubusercontent.com/93100689/202313522-a3c4a311-e522-45da-affc-e64e6add738f.png)

### 4- Service account
   - This service account will be with Role "container.admin" which we will give it to our VM and Jenkins to Access our GKE Cluster.
![4](https://user-images.githubusercontent.com/93100689/202313957-ef7523d9-704f-4ef2-89e2-574134a306e0.png)

### 5- Router
   - For nat
![5](https://user-images.githubusercontent.com/93100689/202314300-71e89b45-8912-4a66-ad4e-0b5965a9642c.png)

### 6- NAT
   - To allow the cluster and private-vM reach out to internet
![6](https://user-images.githubusercontent.com/93100689/202314584-95a1e338-8b14-4613-8554-44b519bd51bc.png)
### 7- Private-VM
   - This is a Bastion VM in order to connect on the cluster through it.
![7](https://user-images.githubusercontent.com/93100689/202314877-91eae36f-424b-4d36-b85b-3a0b139de4ef.png)

### 8- Firewall
   - This Firewall to allow ssh connection from bastion VM to the cluster.
![8](https://user-images.githubusercontent.com/93100689/202315086-ced581e1-ae27-4be1-bddf-4ae715123706.png)

### 9- private-k8s-cluster
![9](https://user-images.githubusercontent.com/93100689/202315410-9e38db34-0a04-4a3e-86f3-2d257e837bfa.png)

![10](https://user-images.githubusercontent.com/93100689/202315417-57552855-f6c9-411c-b45c-860e2f8c739f.png)

### 10- Node pool
![11](https://user-images.githubusercontent.com/93100689/202315832-6f7c6834-dcec-42b1-9004-918682327955.png)
![12](https://user-images.githubusercontent.com/93100689/202315836-b4f39ec3-8305-4e59-aa7d-75a648c39f76.png)

### Test and Execute
   - To test the file code syntax run the below command
    -  #terraform plan
   - To execute the file code run the below command
    -  #terraform apply
   then you have to get that apply complete successfully as below
   ![13](https://user-images.githubusercontent.com/93100689/202318830-03ef0161-8f3e-4013-920f-401d82d7bf37.png)
   
#### Note: Then we will find that all our infra has been deployed on GCP.

## Then we will access and configur cluster from the private-vm to install jenkins component
   - SSH connect on private-vm then we will install kubectl by the following command
    - sudo apt install kubectl
   - then we will authenticate my account to be able to access the project recources
    - gcloud auth login
then it will give you URL in order to navigate then you will copy the pass code and past it as shown below
![14](https://user-images.githubusercontent.com/93100689/202320979-1569a6ea-7dcb-4c03-93ec-796c5b0e1275.png)

   - now We need to access the K8s cluster so We will go to the GCP console then navigate to private-k8s-cluster> click connect
   ![15](https://user-images.githubusercontent.com/93100689/202322113-63a91e99-4327-4c1d-98d1-f13ef1a4bd9f.png)

   - Take the command that will appear to you and copy and run it on private-vm
    - gcloud container clusters get-credentials private-k8s-cluster --zone us-central1-a --project final-proj-fadel
![16](https://user-images.githubusercontent.com/93100689/202322125-75d43661-d413-44d7-bed8-95b6babd4215.png)

   - Note: if you faced an issue warning running this command, try to run it first.
    - sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
![18](https://user-images.githubusercontent.com/93100689/202324056-a9ff8d7e-1ba9-4f85-a381-1776ff08b45e.png)

### Note: now we are able to connect and run kubectl from peivate vm successfully.

______________________________


## The next stage is Jenkins deployment
 - In this stage we will deploy Jenkins Master and slave on the cluster which we deployed but in different name space.
## jenkins folder content
### 1- jenkins Master deployment and service file
   - this is the jenkins master deployment and it's service we will Create deploy and service file and as shown through the code then we will copy the file to the private vm and we will apply the file to deploy the jenkins master deployment and service.
    - kubectl apply -f jenkins-deploy.yml
    - kubectl get svc
![19](https://user-images.githubusercontent.com/93100689/202324759-888e7eab-88b8-4dcc-b207-cfdbbdfeeed2.png)

Note: then we will find that service up and running and now we can access jenkins master through http as shown below.
![20](https://user-images.githubusercontent.com/93100689/202326098-9a08bc51-eceb-4dae-a6e7-feb42ee4c2ca.png)
### 1- jenkins slave1 deployment and service file.
   - this is the jenkins slave1 deployment and it's service we will Create deploy and service file and as shown through the code then we will copy the file to the private vm and we will apply the file to deploy the jenkins slave1 deployment and service.
    - kubectl apply -f jenkins-deploy.yml
    - kubectl get svc
![21](https://user-images.githubusercontent.com/93100689/202445809-bc6e6b0b-ed47-4a57-bc6e-6b0f222d9e01.png)
   - We wil navigateto the jenkins GUI and configer the slave and comine it with Jenkins master.
   ![23](https://user-images.githubusercontent.com/93100689/202446212-fbec1042-625e-4c4e-b3f8-a9797da76f1c.png)

   - Then we will exec the slave and complete it's prerequiest what may make us to face an issues during build the back eend app.
    - chmod 777 /var/run/docker.sock
    - apt-get update
    - apt-get install -y gettext-base
    - exit

![25](https://user-images.githubusercontent.com/93100689/202446499-cc29a308-23ad-4d65-a42c-5405851ac810.png)
### Everything related to the jenkins master and slave should be ok.


##  Creating credentials
  - Then we will create the "dockerHub, slave-key, and slave-user" which we will use it in jenkins file during build the back end app 
 ![24](https://user-images.githubusercontent.com/93100689/202447927-915464a6-35fc-4079-a499-f210d18b10c1.png)

## pipeline building
  - We will build the pipeline which we will use to build the back end app.
  ![28](https://user-images.githubusercontent.com/93100689/202448311-8181407c-5960-4aa0-a70d-2fc12a774098.png)

## checking the back-end App service
  - Check the service URL 

![26](https://user-images.githubusercontent.com/93100689/202448785-0d42919d-7c66-441f-83c7-a32b8ab9b49f.png)

## Finally we will hit the service IP
![27](https://user-images.githubusercontent.com/93100689/202448769-d8aea3d1-8764-4385-a931-414fadc198e3.png)
![29](https://user-images.githubusercontent.com/93100689/202449712-69063097-2eb6-47ce-9e70-caec9bdc3ee1.png)
