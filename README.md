# Summary
IRIS-FHIR-Lab is a web application that connects to FHIR server, get and list all the resources, dynamically list down resource details and display FHIR resource details both in JSON and human-readable format. The application also has the functionality to Create Patient/Patient observation resources and to transform FHIR messages to HL7 V2

[![one](https://img.shields.io/badge/Platform-InterSystems%20IRIS-blue)](https://www.intersystems.com/data-platform/) [![one](https://img.shields.io/badge/WebFrameWork-CSP-Orange)](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GCSP) [![one](https://img.shields.io/badge/Interoperability-HL7%20FHIR-yellow)](https://www.hl7.org/fhir/) [![one](https://img.shields.io/badge/Python%20Library-fhirpy-Maroon)](https://pypi.org/project/fhirpy/) [![OEX](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)]() [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/mwaseem75/iris-fhir-lab/blob/main/LICENSE)

## Application Layout
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/614f1ce7-c708-44fe-8e2e-5fa7e0f92f0a)

## Online Demo
https://irisfhirlab.demo.community.intersystems.com/csp/fhirlab/index.csp by using SuperUser | SYS

## Features
* Add/Remove any Open FHIR Server
* Dynamically get the list of all FHIR resources
* View full details of the resources in JSON and Human readable format
* View Patient related resources
* Transform FHIR messages to HL7 V2.
* Post basic Patient resources.
* Post Patient Observation resources.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 

### Docker (e.g. for dev purposes)

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/mwaseem75/iris-fhir-lab.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d
```

### IPM

Open IRIS for Health installation with IPM client installed. Call in any namespace:

```
USER>zpm "install iris-fhir-lab"
```

## Run the Application
Navigate to [http://localhost:32783/csp/fhirlab/index.csp](http://localhost:32783/csp/fhirlab/index.csp) to run the application
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/c5b861ee-4b93-4471-b682-77a086c069fe)


### View Resources
Click on the Resources List to view Resource records and further clink on the record to view JSON and Human readable details of selected Resource
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/9d0d10df-3693-4818-b60f-618ad488d578)



### View Patient Resources
Select Patient from the main page or navigate to the below link to view patient-related resources
Navigate to [http://localhost:32783/csp/fhirlab/index.csp](http://localhost:32783/csp/fhirlab/patient.csp) to run the application
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/6279a4e6-1a7d-4374-ae3f-bb4b3f47a96c)


### Create Patient Resource
Select Create Resource from the menu or navigate to the below link to create a Patient Resource
Navigate to [http://localhost:32783/csp/fhirlab/create.csp](http://localhost:32783/csp/fhirlab/create.csp) to run the application
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/ce7809da-e2af-4bb4-ba2c-9e3e2e69dbf3)

### Create Patient Observation Resource
Select Create Observation from the menu or navigate to the below link to create a Patient Resource
Navigate to [http://localhost:32783/csp/fhirlab/createobs.csp](http://localhost:32783/csp/fhirlab/createobs.csp) to run the application
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e5c3c1fa-9cb7-4877-8044-6a7ab9cd2c1e)
Click Post Observation to create an observation.

To view created observation, navigate to the Patient Resources menu and select Patient ID then select Observation
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/ecea0c81-70a7-4d7b-9fec-92358ec94b56)

## FHIR to HL7 V2 transformation
Select the Patient Resource, then select the FHIR tab and click on the "Transform FHIR to HL7 V2" button.
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/3fefe2b9-fee2-45b6-9d93-c5e584822248)

Application will get the transformation message HL7 V2 with the help of FHIR Server production.
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/361122b0-5559-4234-be2e-5a9e81de3a6c)

Transformation is utilizing FHIRRouter ->  FHIR_SDA -> SDA_HL7 Processes to convert FHIR message to HL7 V2 message 
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/44abbfb0-e29e-4103-8d2c-446400acb730)
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/c4cd6f6f-94c5-40da-9213-6698e67e0709)

## Development Resources
[InterSystems IRIS FHIR Documentation](https://docs.intersystems.com/irisforhealth20203/csp/docbook/Doc.View.cls?KEY=HXFHIR)
[FHIR API](http://hl7.org/fhir/resourcelist.html)
[Developer Community FHIR section](https://community.intersystems.com/tags/fhir)

## FHRI Sample data
Two FHIR servers are added by default. You can Add/Remove the FHIR server as well.
FHIR sample data is imported already, To view Open Postman and make a GET call for the preloaded Patient:
http://localhost:32783/csp/fhirserver/fhir/r4/Patient/3
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e62ca528-c136-4e16-9c61-20fd05e5ce05)

## Special Thanks to:
Guillaume Rongier for: [iris-healthtoolkit-service](https://openexchange.intersystems.com/package/iris-healthtoolkit-service) template for guidance

Thanks
