# AWS Architecture

## Goal

> We have a set-up on the production floor where a machine produces large number of files. These files need to be shown in a web app where a user can log in and group the files in a particular way. The files need to be in a data lake and all the operations happening in the app need to be logged. Which AWS services would you suggest employing for each element in this architecture and why? If unfamiliar with AWS, please suggest alternative solutions.

## Technical Requirements
- File Storage
- Deployment of web app
- IAM
- Logging

## Additional non-technical (and unknown) requirements
- Availability
  - How reliable does the service need to be
  - Redundancy
- Portability
  - Using open-source components where possible vs using highly integrated, but quicker, AWS services
- Security
  - Local user management vs integration with existing enterprise IAM

  
## Solutions
The possible architectures depend highly on the additional requirements.

On the smaller scoped end, using AWS services:
- File Storage: AWS S3
- Deployment: AWS EC2 or Fargate
- IAM: Amazon Cognito or manually in web app
- Logging: AWS CloudWatch

The obvious choice for the file storage is AWS S3.
The web app should be available as a OCI (Docker) image and can be easily deployed using EC2 or even Fargate as a serverless option. 
EC2 easily sends log outputs to CloudWatch, where it can be queried, as well as alerts set up.

There is also newer, even more low-code services for deploying and evend developing web apps, like AWS App Runner and AWS Amplify, that could be worth exploring.


On the larger scoped end, deploying on a Kubernetes cluster:
- File Storage: AWS S3
- Deployment AWS Elastic Kubernetes Service
- IAM: DEX to integrate with enterprise IdP, like Azure AD
- Logging: Prometheus, Grafana

This option is more flexible and portable (avoiding vendor lock-in), as it's heavily relying on open-source CNCF projects, but also more complex to set up and maintain.
