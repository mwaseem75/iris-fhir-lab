# Summary
IRIS-FHIR-Lab is a web application to connect and view FHIR resources details from multiple FHIR Servers along with dynamically creating and posting FHIR resources

[![one](https://img.shields.io/badge/Platform-InterSystems%20IRIS-blue)](https://www.intersystems.com/data-platform/) [![one](https://img.shields.io/badge/WebFrameWork-CSP-Orange)](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GCSP) [![one](https://img.shields.io/badge/Interoperability-HL7%20FHIR-yellow)](https://www.hl7.org/fhir/) [![one](https://img.shields.io/badge/Python%20Library-fhirpy-Maroon)](https://pypi.org/project/fhirpy/) [![OEX](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)]() [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/mwaseem75/iris-fhir-lab/blob/main/LICENSE)

## Application Layout
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/3f690a57-b797-4c04-bc10-8950e333c352)

## Online Demo
https://irisfhirlab.demo.community.intersystems.com/csp/fhirlab/index.csp by using SuperUser | SYS

## Features
* Add/Remove any Open FHIR Server
* Dynamically get the list of all FHIR resources
* View full detail of the resources in JSON and Human readable format
* View Patient related resources
* Create and post basic Patient resource

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
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/749cd7bd-0583-40d3-a9a0-35350aa626ea)

### View Resources
Click on the Resources List to view Resource records and further clink on the record to view JSON and Human readable details of selected Resource
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/2291c434-2b23-4132-83a3-bd164ea7b66b)


### View Patient Resources
Select Patient from the main page or navigate to below link to view patient related resources
Navigate to [http://localhost:32783/csp/fhirlab/index.csp](http://localhost:32783/csp/fhirlab/patient.csp) to run the application
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/a3190945-cc31-43d2-89be-45855d8bf8b0)

### Create Patient Resource
Select Create Resource from menu or navigate to below link to create Patient Resource
Navigate to [http://localhost:32783/csp/fhirlab/index.csp](http://localhost:32783/csp/fhirlab/create.csp) to run the application
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/b235fde2-5259-468c-90a1-54561465aac5)



### FHRI Sample data
Two FHIR servers are added by default. You can Add/Remove FHIR server as well.
FHIR sample data is imported already, To view Open Postman and make a GET call for the preloaded Patient:
http://localhost:32783/csp/fhirserver/fhir/r4/Patient/3
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e62ca528-c136-4e16-9c61-20fd05e5ce05)



## Development Resources
[InterSystems IRIS FHIR Documentation](https://docs.intersystems.com/irisforhealth20203/csp/docbook/Doc.View.cls?KEY=HXFHIR)
[FHIR API](http://hl7.org/fhir/resourcelist.html)
[Developer Community FHIR section](https://community.intersystems.com/tags/fhir)

Thanks
