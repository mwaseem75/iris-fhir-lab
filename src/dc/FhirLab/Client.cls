Class dc.FhirLab.Client Extends %SwizzleObject
{

// init function invoked while initilizign container which add 2 detault servers (Intersystem/SmartHealthIT)

ClassMethod Init() As %Integer
{
	if $DATA(^$GLOBAL("^FhirLabServer"))= 0 
	{
		// initilize global variable which will use throught the application
		Set ^FhirLabServer = 1
	}
	//if server id 1 is not already created then create server with ID 1
	Set obj = ##class(dc.FhirLab.Server).%OpenId(1)
	if $isobject(obj) = 0
	{
		set obj = ##class(dc.FhirLab.Server).%New()
		set obj.ServerName = "InterSystem FHIR Server"
		set obj.Endpoint = "http://localhost:52773/csp/fhirserver/fhir/r4/"
		set obj.Sys = "Y"
		//set obj.ApiKey = "CDqtU2GjQUaICOC65Ilgv1LHQIEDr4Vn12nnlmMY"
		//set obj.EndpointOAuth = "https://fhirauth.83z8498j30i6.static-test-account.isccloud.io/oauth2"
		set sts = obj.%Save()
		if sts '= 1
		{
			
			Quit "Error while creating server ID1"
			
		}
	} 
	//if server id 2 is not already created then create server with ID 1
	Set obj = ##class(dc.FhirLab.Server).%OpenId(2)
	if $isobject(obj) = 0
	{
		set obj = ##class(dc.FhirLab.Server).%New()
		set obj.ServerName = "SmartHealthIT Open FHIR Server"
		set obj.Endpoint = "https://r4.smarthealthit.org"
		set obj.Sys = "Y"
	
		set sts = obj.%Save()
		if sts '= 1
		{
			Quit "Error while creating server ID2"
		}
	}
	
	Quit $$$OK
}

// Get resource details 

ClassMethod ResourceJSON(resourceName As %String, rowid As %String) As %String
{
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{ 	  
	  Set data = ..ResourceJSONP(resourceName,rowid,obj.Endpoint,obj.ApiKey) 
	}
	//Active Server data is not defined
  	else
  	{ 
  		Quit "Not able to get server Info.."
  	}
  	return data
}

// Python funtion to return resource details

ClassMethod ResourceJSONP(resourceName, rowid, url, apikey) [ Language = python ]
{
	import requests,json
	contentType = "application/fhir+json"
	headers = {"Content-Type":contentType,"x-api-key":apikey}
	if url[-1]!="/":
		url=url+"/"
	x = requests.get(url+resourceName+"/"+rowid,headers=headers)
	data =x.json()	 
	return json.dumps(data, indent=4)
}

// Display FHIR resource in Human format

ClassMethod ResourceJSONHuman(resourceName As %String, rowid As %String) As %String
{
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{ 	  
	  Set data = ..ResourceJSONHumanP(resourceName,rowid,obj.Endpoint,obj.ApiKey) 
	}
	//Active Server data is not defined
  	else
  	{ 
  		Quit "Not able to get server Info.."
  	}
  	return data
}

// Python function to Display FHIR resource in Human format

ClassMethod ResourceJSONHumanP(resourceName, rowid, url, apikey) [ Language = python ]
{
	import requests,json,human_json
	contentType = "application/fhir+json"	
	headers = {"Content-Type":contentType,"x-api-key":apikey}
	if url[-1]!="/":
		url=url+"/"
	x = requests.get(url+resourceName+"/"+rowid,headers=headers)
	data =x.json()	 
	return( human_json.to_human_json(data))
}

ClassMethod TransformHL7(resourceName As %String, rowid As %String) As %String
{
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{ 	  
	  Set data = ..TransformHL7P(resourceName,rowid,obj.Endpoint,obj.ApiKey) 
	}
	//Active Server data is not defined
  	else
  	{ 
  		Quit "Not able to get server Info.."
  	}
  	return data
}

// Transform FHIR to HL7 V2

ClassMethod TransformHL7P(resourceName, rowid, url, apikey) [ Language = python ]
{
	import requests,json
	contentType = "application/fhir+json"
	headers = {"Content-Type":contentType,"x-api-key":apikey}
	if url[-1]!="/":
		url=url+"/"
	aa = url+resourceName+"/"+rowid
	x = requests.get(aa,headers=headers)

	data =x.json()	 
	json_string = json.dumps(data)

	json_string = "{\"resourceType\": \"Bundle\",\"type\": \"transaction\",\"entry\": [{ \"resource\":" + json_string + '}]}'

	data =  json.loads(json_string)

	response = requests.post(url+resourceName+"/hl7", json=data, headers=headers)
	
	return response.content
}

// Resigter server by using FhirServer persistent Class

ClassMethod SaveServer(ServerName As %String, Endpoint As %String, ApiKey As %String = "", EndpointOAuth As %String = "") As %String
{
	//Create global fhirServer reference variable if not created
	if $DATA(^$GLOBAL("^FhirLabServer"))= 0 
	{
		Set ^FhirLabServer = 1
	}
	//Add New FhirServer
	set obj = ##class(dc.FhirLab.Server).%New()
	set obj.ServerName = ServerName
	set obj.Endpoint = Endpoint
	set obj.ApiKey = ApiKey
	set obj.EndpointOAuth = EndpointOAuth
	set sts = obj.%Save()
	if sts = 1
	{
		
		   Quit " "
			
	}
	else
	{
			Quit "Error while registring FHIR Server"
	}
}

// Get Server List

ClassMethod ServerList() As %Integer
{

	//Print Servier List
	SET qry = "SELECT ID, ServerName, Endpoint,ApiKey FROM dc_FhirLab.Server"
	SET tStatement = ##class(%SQL.Statement).%New()
	SET qStatus = tStatement.%Prepare(.qry)
    IF qStatus =1 {
             SET rsetD = tStatement.%Execute()
            
                    //DO rset.%Display()
    WRITE "------------------------------------------------------------------",!           
    WRITE "Registered FHIR Servers",!           
    WRITE "------------------------------------------------------------------",!  
    WHILE rsetD.%Next() {
	                    IF rsetD.%GetData(1)= ^FhirLabServer
    { 
        SET STS = "Active"
    }    
    ELSE
    {
	     SET STS = "Not Active"
	    }
             
              WRITE "ID", ?12,rsetD.%GetData(1),!
              WRITE "Name", ?12,rsetD.%GetData(2),!
              WRITE "EndPoint", ?12,rsetD.%GetData(3),!
              WRITE "ApiKey", ?12,rsetD.%GetData(4),!
              WRITE "EPOAuth2", ?12,rsetD.%GetData(5),!
              WRITE "ISActive", ?12,STS,!
             
              WRITE "------------------------------------------------------------------",!           
              
                                                
                        }
                 }
	Quit $$$OK
}

// Get Server List. Used in CSP application

ClassMethod GetServerList() As %String
{

	//Print Servier List
	SET qry = "SELECT ID, ServerName FROM dc_FhirLab.Server"
	SET tStatement = ##class(%SQL.Statement).%New()
	SET qStatus = tStatement.%Prepare(.qry)
    IF qStatus =1 {
         SET rsetD = tStatement.%Execute()
            
             
   set dtbl  = ""
       WHILE rsetD.%Next() {
	IF rsetD.%GetData(1)= ^FhirLabServer
    { 
        SET STS = "Active"
    }    
    ELSE
    {
	     SET STS = "Not Active"
	    }
                       
            set dtbl = dtbl_"<tr><td>"_ rsetD.%GetData(1) _"</td><td>"_ rsetD.%GetData(2) _"</td><td>"_ STS _"</td></tr>"
                   
                                                
                        }
                        return dtbl
                 }
                 return ""
}

// Set Current FHIR Server

ClassMethod SetFhirServer(serverid As %Integer) As %Status
{
	Set obj = ##class(dc.FhirLab.Server).%OpenId(serverid)
	//If Server is already register then activate it
	if $isobject(obj)  
	{
		Set ^FhirLabServer = serverid
		Return $$$OK

		//Write "Server id Activated Successfully"
	}
	ELSE
	{
		Write "FHIR Server Not registered!"
		Quit 0
	}
}

// Delete registered server

ClassMethod DeleteServer(serverid As %Integer) As %Status
{
	Set obj = ##class(dc.FhirLab.Server).%OpenId(serverid)
	//If Server is already register then activate it
	if $isobject(obj)  
	{
		Set sc = ##class(dc.FhirLab.Server).%DeleteId(serverid)
		Return sc

		//Write "Server id Activated Successfully"
	}
	ELSE
	{
		Write "FHIR Server Not registered!"
		Quit 0
	}
}

// Get FHIR server details based on ID

ClassMethod GetFhirServer(serverid As %Integer) As %String
{
	Set obj = ##class(dc.FhirLab.Server).%OpenId(serverid)
	//If Server is already register then activate it
	if $isobject(obj)  
	{		
		Return obj.ServerName _";"_ obj.Endpoint_";"_ obj.ApiKey_";"_ obj.EndpointOAuth
	}
	ELSE
	{
		Write "FHIR Server Not found"
		Quit 0
	}
}

// Method invoked from CSP Application to get Resource HTML

ClassMethod GetResourceHTML(resource As %String, patid As %String) As %String
{
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{  
	  //Call Embedded Python Function to get Number of Resources
	  Set irisfhirlab = ##class(%SYS.Python).Import("irisfhirlab")
	  Set data = irisfhirlab.GetResourceHTML(resource,patid,obj.Endpoint,obj.ApiKey) 
	}
	//Active Server data is not defined
  	else
  	{ 
  		Quit "Not able to get server Info.."
  	}
  	return data
}

// Function will return FHIR server resources

ClassMethod ListResources() As %String
{
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{  
	  
	  set resources =  ..ListResourcesP(obj.Endpoint,obj.ApiKey)
	
	  return resources
	}
	//Active Server data is not defined
  	else
  	{ 
  		return "Not able to get server Info.."
  	}
  	return ""
}

// Python Function will return FHIR server resources

ClassMethod ListResourcesP(url As %String, apikey As %String) As %String [ Language = python ]
{
	import requests
	contentType = "application/fhir+json"
	headers = {"Content-Type":contentType,"x-api-key":apikey}
	if url[-1]!="/":
		url=url+"/"
	try:
		x = requests.get(url+'metadata',headers=headers)
		data = x.json()
		resources = ""
		for item in data['rest'][0]['resource']: 
			if len(resources) > 0:
				resources = resources +","+item['type']
			else:
				resources = item['type']     
		return resources
	except:
		return "FHIR Server connection error"
}

// Patient list used in observation post pate

ClassMethod GetPatResources() As %Status
{
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{  
	  //Call Embedded Python Function to get Number of Resources
	  Set irisfhirlab = ##class(%SYS.Python).Import("irisfhirlab")
	  Set data = ..GetPatResourcesP(obj.Endpoint,obj.ApiKey) 
	}
	//Active Server data is not defined
  	else
  	{ 
  		Quit "Not able to get server Info.."
  	}
  	return data
}

ClassMethod GetPatResourcesP(url As %String, apikey As %String) As %String [ Language = python ]
{
	import requests
	from fhirpy import SyncFHIRClient
	contentType = "application/fhir+json"
	data = ""    
	if url[-1]!="/":
		url=url+"/"
	try:
		cclient = SyncFHIRClient(url = url, extra_headers={"Content-Type":contentType,"x-api-key":apikey})
		data = cclient.resources("Patient").fetch()            
	except:
		print("Connection Error")    

	if len(data) == 0:   
		return "No Record Found"

	options = ""    
	for rowval in data:
		id = str(rowval.get('id'))
		options = options + "<option value='"+id+"'>"+id+"-"+str(rowval.get_by_path('name.0.family'))+" "+str(rowval.get_by_path('name.0.given.0'))+"</option>"        

	return options
}

// Function to create Patient resource

ClassMethod CreatePatient(givenName As %String, familyName As %String, birthDate As %String, gender As %String) As %String
{
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{  
	//Call Embedded Python Function to get Number of Resources	
	set data = ..CreatePatientP(givenName,familyName,birthDate,gender,obj.Endpoint,obj.ApiKey) 
	}
	//Active Server data is not defined
	else
	{ 
	return "Not able to get server Info.."
	}
	return data
}

// Python Function to create Patient resource

ClassMethod CreatePatientP(givenName As %String, familyName As %String, birthDate As %String, gender As %String, url As %String, apikey As %String) As %String [ Language = python ]
{
	import requests
	from fhirpy import SyncFHIRClient
	contentType = "application/fhir+json"
	headers = {"Content-Type":contentType,"x-api-key":apikey}
	client = SyncFHIRClient(url = url, extra_headers=headers)

	patient = client.resource("Patient")
	patient['name'] = [
    	    {
        	    'given': [givenName],
            	'family': familyName,
            	'use': 'official'
        	}
    	]
	patient['birthDate'] = birthDate
	patient['gender'] = gender
	try:
		patient.save()
	except Exception as e:
		return "Error while creating Patient:" +str(e)            
	return "Patient Created Successfully"
}

// Function to create Patient observations

ClassMethod CreateObservation(patientId As %String, loincCode As %String, ObrCategory As %String, ObrValue As %Integer, ObrUOM As %String, effectiveDate As %String) As %String
{
	
		
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{  
		//Call Embedded Python Function to get Number of Resources
		set data = ..CreateObservationP(patientId,loincCode,ObrCategory,$NUMBER(ObrValue),ObrUOM,effectiveDate,obj.Endpoint,obj.ApiKey) 
		return data
	}
	//Active Server data is not defined
	else
	{ 
	return "Not able to get server Info.."
	}
}

// Python Function to create Patient observations

ClassMethod CreateObservationP(patientId As %String, loincCode As %String, ObrCategory As %String, ObrValue As %Integer, ObrUOM As %String, effectiveDate As %String, url As %String, apiKey As %String) As %String [ Language = python ]
{

	import requests
	from fhirpy import SyncFHIRClient
	contentType = "application/fhir+json"
	headers = {"Content-Type":contentType,"x-api-key":apiKey}
	client = SyncFHIRClient(url = url, extra_headers=headers)
	observation = client.resource(
	'Observation',
	status='preliminary',	
	category=[{
	 'coding': [{
            'system': 'http://hl7.org/fhir/observation-category',
            'code': ObrCategory
        }]
    }],
    code={
        'coding': [{
            'system': 'http://loinc.org',
            'code': loincCode
        }]
    })
	observation['effectiveDateTime'] = effectiveDate

	observation['valueQuantity'] = {
    'system': 'http://unitsofmeasure.org',
    'value': ObrValue,
    'code': ObrUOM
	}
	
    #find the patient
	patient = client.resources('Patient').search(_id=patientId).first()
	observation['subject'] = patient.to_reference()

	try:
		observation.save()
	except Exception as e:
		return "Error while creating observation :"+ str(e)       
		

	return "Patient Observation Created Successfully"
}

}
