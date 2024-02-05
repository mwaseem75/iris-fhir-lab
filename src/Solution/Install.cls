Class Solution.Install Extends %RegisteredObject
{

/// Run the installation
ClassMethod Run() As %Status
{
    Set sc = $$$OK
    
    // Install FHIR repo
    Set appKey = "/csp/fhirserver/fhir/r4"
    Set strategyClass = "HS.FHIRServer.Storage.Json.InteractionsStrategy"
    set metadataPackages = $lb("hl7.fhir.r4.core@4.0.1")
    set importdir="/opt/irisapp/src"

    // Install elements that are required for a FHIR-enabled namespace
    Do ##class(HS.FHIRServer.Installer).InstallNamespace()

    // Install an instance of a FHIR Service into the current namespace
    Do ##class(HS.FHIRServer.Installer).InstallInstance(appKey, strategyClass, metadataPackages)
    //do ##class(Ens.Director).StopProduction()

    set cspConfig = ##class(HS.Util.RESTCSPConfig).URLIndexOpen(appKey)
    set cspConfig.ServiceConfigName = "HS.FHIRServer.Interop.Service"
    set cspConfig.AllowUnauthenticatedAccess = 1
    zw cspConfig.%Save()

    // Configure FHIR Service instance to accept unauthenticated requests
    set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint(appKey)
    set config = strategy.GetServiceConfigData()
    set config.DebugMode = 4
    do strategy.SaveServiceConfigData(config)  
  
    //Load resources
    zw ##class(HS.FHIRServer.Tools.DataLoader).SubmitResourceFiles("/opt/irisapp/src/fhirdata", "FHIRSERVER", appKey)





















    Return sc
}

}
