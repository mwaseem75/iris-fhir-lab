# Summary
IRIS-FHIR-Lab is a web application to connect view multiple FHIR Servers and view resources details along with dynamically creating and posting FHIR resources

[![one](https://img.shields.io/badge/Platform-InterSystems%20IRIS-blue)](https://www.intersystems.com/data-platform/) [![one](https://img.shields.io/badge/WebFrameWork-CSP-Orange)](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GCSP) [![one](https://img.shields.io/badge/Interoperability-HL7%20FHIR-yellow)](https://www.hl7.org/fhir/) [![one](https://img.shields.io/badge/Python%20Library-fhirpy-Maroon)](https://pypi.org/project/fhirpy/) [![OEX](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)]() [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/mwaseem75/iris-fhir-lab/blob/main/LICENSE)

## Application Layout
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/fbaff0aa-5cc0-4ccd-b6de-e372f113fb96)


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

## Run Application
Navigate to [http://localhost:32783/csp/fhirlab/index.csp](http://localhost:32783/csp/fhirlab/index.csp) to run the application
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/749cd7bd-0583-40d3-a9a0-35350aa626ea)

two FHIR servers are added by default. You can Add/Remove FHIR server.

FHIR sample data is imported already, To view Open Postman and make a GET call for the preloaded Patient:
http://localhost:32783/csp/fhirserver/fhir/r4/Patient/3
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/e62ca528-c136-4e16-9c61-20fd05e5ce05)


## Development Resources
[InterSystems IRIS FHIR Documentation](https://docs.intersystems.com/irisforhealth20203/csp/docbook/Doc.View.cls?KEY=HXFHIR)
[FHIR API](http://hl7.org/fhir/resourcelist.html)
[Developer Community FHIR section](https://community.intersystems.com/tags/fhir)

Thanks
