import requests
from fhirpy import SyncFHIRClient

contentType = "application/fhir+json"
    
#Function to get data in rows format
def GetTableData(resource,data,url,apikey):
    rows = []      
    rows = ""
    patid = ""
    firstTime = True
    if resource == "Patient":
        for rowval in data:
            #print("This is an \"escape\" of a double-quote")
            #<tr id="row2" onclick="handleRowClick('row2')">
            id = str(rowval.get('id'))
            if firstTime: 
                rows = "<thead><tr><th>ID</th><th>Family Name</th><th>Given Name</th><th>DOB</th><th>Gender</th></tr></thead>"			
                firstTime=False                
            rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
            #including <a> tag to pass to patient.csp page
            patid = "fhirlab\patient.csp?resource=Observation&pid="+str(rowval.get('id'))+"&pname="+str(rowval.get_by_path('name.0.family'))+" "+str(rowval.get_by_path('name.0.given.0'))
            patid = "\csp\\"+ patid     
            patid = '<A HREF="'+patid+'"'+'>'+str(rowval.get('id'))+'</A>'
            rows = rows + "<td>"+patid+"</td><td>"+str(rowval.get_by_path('name.0.family'))+"</td><td>"+str(rowval.get_by_path('name.0.given.0'))+"</td><td>"+str(rowval.get_by_path('birthDate'))+"</td><td>"+str(rowval.get_by_path('gender'))+"</td></tr></tobody>"
            
    elif resource == "Observation":
        for rowval in data:
            id = str(rowval.get('id'))
            if firstTime: 
                rows = "<thead><tr><th>ID</th><th>Category</th><th>Codes</th><th>Value</th><th>UOM</th><th>Date</th></tr></thead>"
                firstTime=False
            rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
            rows = rows + "<td>"+str(rowval.get('id'))+"</td><td>"+str(rowval.get_by_path('category.0.coding.0.code'))+"</td><td>"+str(rowval.get_by_path('code.coding.0.code'))+"</td><td>"+str(rowval.get_by_path('valueQuantity.value'))+"</td><td>"+str(rowval.get_by_path('valueQuantity.code'))+"</td><td>"+str(rowval.get('effectiveDateTime'))+"</td></tr></tobody>"
    
    elif resource == 'Procedure':        
        for rowval in data:
            id = str(rowval.get('id'))            
            if firstTime: 
                rows = "<thead><tr><th>ID</th><th>Code</th><th>Display</th><th>Start Date</th><th>End Date</th><th>Status</th></tr></thead>"
                firstTime=False
            rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
            rows = rows + "<td>"+str(rowval.get('id'))+"</td><td>"+str(rowval.get_by_path('code.coding.0.code'))+"</td><td>"+str(rowval.get_by_path('code.coding.0.display'))+"</td><td>"+str(rowval.get_by_path('performedPeriod.start'))+"</td><td>"+str(rowval.get_by_path('performedPeriod.end'))+"</td><td>"+str(rowval.get('status'))+"</td></tr></tobody>"

    elif resource == 'Immunization':        
        for rowval in data:
            id = str(rowval.get('id'))
            if firstTime: 
                rows = "<thead><tr><th>ID</th><th>Code</th><th>Display</th><th>Date</th><th>Encounter</th><th>Status</th></tr></thead>"
                firstTime=False
            rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
            rows = rows + "<td>"+str(rowval.get('id'))+"</td><td>"+str(rowval.get_by_path('vaccineCode.coding.0.code'))+"</td><td>"+str(rowval.get_by_path('vaccineCode.coding.0.display'))+"</td><td>"+str(rowval.get_by_path('occurrenceDateTime'))+"</td><td>"+str(rowval.get_by_path('encounter.reference'))+"</td><td>"+str(rowval.get('status'))+"</td></tr></tobody>"
            
    elif resource == 'Encounter':        
        for rowval in data:
            id = str(rowval.get('id'))
            if firstTime: 
                rows = "<thead><tr><th>ID</th><th>Code</th><th>Start Date</th><th>End Date</th><th>ServiceProvider</th><th>Status</th></tr></thead>"
                firstTime=False
            rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
            rows = rows + "<td>"+str(rowval.get('id'))+"</td><td>"+str(rowval.get_by_path('class.code'))+"</td><td>"+str(rowval.get_by_path('period.start'))+"</td><td>"+str(rowval.get_by_path('period.end'))+"</td><td>"+str(rowval.get_by_path('serviceProvider.reference'))+"</td><td>"+str(rowval.get('status'))+"</td></tr></tobody>"
            
    elif resource == 'Organization':        
        for rowval in data:
            id = str(rowval.get('id'))
            if firstTime: 
                rows = "<thead><tr><th>ID</th><th>Code</th><th>Display</th><th>Name</th></tr></thead>"
                firstTime=False
            rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
            rows = rows + "<td>"+str(rowval.get('id'))+"</td><td>"+str(rowval.get_by_path('type.0.coding.0.code'))+"</td><td>"+str(rowval.get_by_path('type.0.coding.0.display'))+"</td><td>"+str(rowval.get_by_path('name'))+"</td></tr></tobody>"
                        
    elif resource == 'Condition':        
        for rowval in data:
            id = str(rowval.get('id'))
            if firstTime: 
                rows = "<thead><tr><th>ID</th><th>Code</th><th>Display</th><th>ClinicalStatus</th><th>Status</th></tr></thead>"
                firstTime=False
            rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
            rows = rows + "<td>"+str(rowval.get('id'))+"</td><td>"+str(rowval.get_by_path('code.coding.0.code'))+"</td><td>"+str(rowval.get_by_path('code.coding.0.display'))+"</td><td>"+str(rowval.get_by_path('clinicalStatus.coding.0.code'))+"</td><td>"+str(rowval.get_by_path('verificationStatus.coding.0.code'))+"</td></tr></tobody>"    
            
    elif resource == 'Practitioner':        
        for rowval in data:
            id = str(rowval.get('id'))
            if firstTime: 
                rows = "<thead><tr><th>ID</th><th>Middle Name</th><th>Family Name</th><th>Given Name</th></tr></thead>"
                firstTime=False
            rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
            rows = rows + "<td>"+str(rowval.get('id'))+"</td><td>"+str(rowval.get_by_path('name.0.prefix.0'))+"</td><td>"+str(rowval.get_by_path('name.0.family'))+"</td><td>"+str(rowval.get_by_path('name.0.given.0'))+"</td></tr></tobody>"    
    else:              
        for rowval in data:
            try:
                id = str(rowval.get('id'))                   
                if firstTime:
                    contentType = "application/fhir+json"               
                    headers = {"Content-Type":contentType,"x-api-key":apikey}
                    if url[-1]!="/":
                        url=url+"/"
                    x = requests.get(url+resource+"/"+id,headers=headers)
                    data =x.json()	                                      
                    result = [];tbl_hdr = [];tbl_dtl = []
                    iterate_json(data, result=result)
                    firstTime = False
                    for path, value in result:
                        hdr = '.'.join(map(str, path))                        
                        if hdr == 'id':
                            tbl_hdr.append("ID");tbl_dtl.append(hdr)
                        if hdr == 'type.coding.0.code':
                            tbl_hdr.append("Code");tbl_dtl.append(hdr)    
                        if hdr == 'patient.reference':
                            tbl_hdr.append("Patient");tbl_dtl.append(hdr)        
                        if hdr == 'provider.reference':
                            tbl_hdr.append("Provider");tbl_dtl.append(hdr)            
                        if hdr == 'created':
                            tbl_hdr.append("Created");tbl_dtl.append(hdr)                                         
                        if hdr == 'priority':
                            tbl_hdr.append("Priority");tbl_dtl.append(hdr)                
                        if hdr == 'status':
                            tbl_hdr.append("Status");tbl_dtl.append(hdr) 
                        if hdr == 'subject.reference':
                            tbl_hdr.append("Subject");tbl_dtl.append(hdr)                           
                        if hdr == 'encounter.reference':
                            tbl_hdr.append("Encounter");tbl_dtl.append(hdr)                               
                    rows = "<thead><tr>"
                    for element in tbl_hdr:
                        rows = rows + "<th>"+element+"</th>"                                                    
                    rows = rows + "</tr></thead>"
                    #rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
                    #for element in tbl_dtl:
                    #    rows = rows + "<td>"+str(rowval.get(element))+"</td>"

                    #    rows = rows + "<tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"
                    #    rows = rows + "<td>"+str(rowval.get(hdr))+"</td>"                        
                #rows = rows + "<tr>"
                rows = rows + "<tobody><tr id=\""+ id +"\" onclick=\"handleRowClick('"+id+"')\">"        
                for element in tbl_dtl:                 
                    rows = rows + "<td>"+str(rowval.get_by_path(element))+"</td>"                    
       
            except Exception as e:     
                pass    
        #if len(rows) > 0:
        #    rows = rows + "</tr></tobody>"    

    return rows

#iterate json levels
def iterate_json(obj, path=[], result=[]):
    if isinstance(obj, dict):
        for key, value in obj.items():
            iterate_json(value, path + [key], result)
    elif isinstance(obj, list):
        for index, item in enumerate(obj):
            iterate_json(item, path + [index], result)
    else:
        result.append((path, obj))



#Get Resource HTML Rows data
def GetResourceHTML(resource,patid,url,api_key):
    data = ""    
    if url[-1]!="/":
        url=url+"/"
    try:
        cclient = SyncFHIRClient(url = url, extra_headers={"Content-Type":contentType,"x-api-key":api_key})
        if len(patid) > 0:
            data = cclient.resources(resource).search(patient=patid).fetch()            
        else:
            data = cclient.resources(resource).fetch()
    except:
        print("Connection Error")    

    if len(data) == 0:   
        return "No Record Found" 
    
    rows = GetTableData(resource,data,url,api_key)
    return rows

           
#Function to create Patient Resource
def CreatePatient(givenName,familyName,birthDate,gender,url,api_key):

    headers = {"Content-Type":contentType,"x-api-key":api_key}
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
        print("Error while creating Patient:" +str(e))       
        return
    
    print("Patient Created Successfully")    
    
#Function to create Patient Observation
def CreateObservation(patientId,loincCode,ObrCategory,ObrValue,ObrUOM,effectiveDate,url,api_key):
    
    headers = {"Content-Type":contentType,"x-api-key":api_key}
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
        print("Error while creating observation :"+ str(e))       
        return
        
    
    print("Patient Observation Created Successfully")     

