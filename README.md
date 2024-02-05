# Summary
IRIS-FHIR-Lab is a web application that connects to the FHIR server, gets and lists all the resources, dynamically lists down resource details and displays FHIR resource details both in JSON and human-readable format. The application also has the functionality to Create Patient/Patient observation resources, transform FHIR messages to HL7 V2 and HL7 V2 messages to FHIR

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
* Transform FHIR message to HL7 V2.
* Transform HL7 V2 message to FHIR
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


### Add/Remove any Open FHIR Server
As part of the default setup, two servers are pre-configured with the below configuration:
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e57f59b6-129a-4886-9f70-228efd8b9c10)

However, to add other open FHIR Server, click on the add server button
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/cab8131f-1a67-4f49-a464-25d4184dd9e2)

Enter the information and select the add server button
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/7e9c12bd-6878-4b51-bcba-700bea4de58f)

To Remove the server just click on the Delete link
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e2b08927-465f-4393-8e8a-3c7ae51653f8)
after the confirmation, the server will be deleted
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/24767167-743f-45c5-b609-68c31151faf1)

### View Resources
Click on the Resources List to view Resource records of connected FHIR Server and further clink on the record itself to view JSON and Human readable details of selected Resource
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/751d7d05-e9e5-4b3d-a7b1-a2c939cc826e)


### Search Resources
To search, type resource in the search field
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/8903a73b-9558-4700-bde6-557bfc92d923)


### View Patient Resources
Click on the Patient resource and then click on patient ID in the patient resource detail list
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/83e87290-bfba-4265-80be-24aacbdccccf)
The system will list patent-related resources
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/c9473e71-7bb2-4e5c-ac2e-641dd6be92b7)
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/afc398a4-18d6-46cf-abda-e8748274a64c)


### Create Patient Resource
Select Create Resource from the menu, enter patient information, and click the post resource button 
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/ce7809da-e2af-4bb4-ba2c-9e3e2e69dbf3)
To view the added patient resource, click on the Patient Resources menu
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/10e9e7cd-bac9-42d1-ac39-d8d65203a0a3)

### Create Patient Observation Resource
Select Create Observation from the menu and enter observation resource data, Click Post Observation to create an observation
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e5c3c1fa-9cb7-4877-8044-6a7ab9cd2c1e)

To view created observation, navigate to the Patient Resources menu and select Patient ID then select Observation
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/ecea0c81-70a7-4d7b-9fec-92358ec94b56)

## FHIR to HL7 V2 transformation
Select the Patient Resource, then select the FHIR HL7 tab or Resource detail tab and click on the "Transform FHIR to HL7 V2" button.
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/3fefe2b9-fee2-45b6-9d93-c5e584822248)

Application will get the transformation message HL7 V2 with the help of FHIR Server production.
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/cd3d5a6d-e8e4-4f46-ac35-abdba0d6bded)

Transformation is utilizing IRIS Digital Health Interoperability to convert the FHIR message to the HL7 V2 message.

HS.FHIRServer.Interop.Service Business Service sends FHIR message to the FHIRRouter business process,
FHIRRouter business process sends FHIR message to the FHIR_SDA business process,
FHIR_SDA business process sends SDA message to the SDA_HL7 business process which finally converts SDA message to HL7 V2 message. 

![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/44abbfb0-e29e-4103-8d2c-446400acb730)

FHIRRouter Business Process
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/a0727f12-e7a6-4608-8544-493c6f2ee70f)

Visual Trace
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/c4cd6f6f-94c5-40da-9213-6698e67e0709)

## HL7 V2 to FHIR transformation 
Select HL7 to FHIR from the menu and enter HL7 V2 data, Click the convert button to transform HL7 message to FHIR message
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e674506f-6498-4a1e-979e-5dc998dbd46c)

HL7 to FHIR Transformation is also using production to convert the HL7 V2 message to the FHIR message.

HL7_Http_Service Business Service sends HL7 message to HL7_SDA process and then HL7_SDA sends SDA data to SDA_FHIR process, which finally converts it to FHIR
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e032854d-dffa-43b9-a2d4-33418aaca3ea)


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
