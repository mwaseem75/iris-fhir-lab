Class dc.FhirLab.Client Extends %SwizzleObject
{

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

// initialize the server by adding 2 detault servers

ClassMethod Init() As %Integer
{
	if $DATA(^$GLOBAL("^FhirLabServer"))= 0 
	{
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
		//set obj.ServerName = "InterSystem FHIR Accelerator Service"
		//set obj.Endpoint = "https://fhir.83z8498j30i6.static-test-account.isccloud.io"
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
	//start the production
	Quit $$$OK
}

// Resigter server by using FhirServer persistent Class

ClassMethod SaveServer(ServerName As %String, Endpoint As %String, ApiKey As %String = "", EndpointOAuth As %String = "") As %Integer
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
		
			Quit
			
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
		Quit
	}
}

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
		Quit
	}
}

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
		Quit
	}
}

// Count Resource, Pass "ALL" in case of counting all the resources

// Method invoked from CSP Application to get Resource HTML

ClassMethod GetResourceHTML(resource As %String, patid As %String) As %Status
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

// Function to create Patient resource

ClassMethod CreatePatient(givenName As %String, familyName As %String, birthDate As %String, gender As %String)
{
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{  
	//Call Embedded Python Function to get Number of Resources
	Set irisfhirlab = ##class(%SYS.Python).Import("irisfhirlab")
	set data = irisfhirlab.CreatePatient(givenName,familyName,birthDate,gender,obj.Endpoint,obj.ApiKey) 
	}
	//Active Server data is not defined
	else
	{ 
	Quit "Not able to get server Info.."
	}
}

// Function to create Patient observations

ClassMethod CreateObservation(patientId As %String, loincCode As %String, ObrCategory As %String, ObrValue As %Integer, ObrUOM As %String, effectiveDate As %String)
{
	
	//Get Active Server data based on Global Variable 
	Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	if $isobject(obj)  
	{  
	//Call Embedded Python Function to get Number of Resources
	Set irisfhirlab = ##class(%SYS.Python).Import("irisfhirlab")
	set data = irisfhirlab.CreateObservation(patientId,loincCode,ObrCategory,ObrValue,ObrUOM,effectiveDate,obj.Endpoint,obj.ApiKey) 
	}
	//Active Server data is not defined
	else
	{ 
	Quit "Not able to get server Info.."
	}
}

}
