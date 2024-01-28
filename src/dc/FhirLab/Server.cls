Class dc.FhirLab.Server Extends %Persistent
{

Property ServerName As %String;

Property Endpoint As %String(MAXLEN = 200);

Property ApiKey As %String;

Property EndpointOAuth As %String(MAXLEN = 200);

Property Sys As %String(MAXLEN = 1);

Storage Default
{
<Data name="ServerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ServerName</Value>
</Value>
<Value name="3">
<Value>Endpoint</Value>
</Value>
<Value name="4">
<Value>ApiKey</Value>
</Value>
<Value name="5">
<Value>EndpointOAuth</Value>
</Value>
<Value name="6">
<Value>Sys</Value>
</Value>
</Data>
<DataLocation>^dc.FhirLab.ServerD</DataLocation>
<DefaultData>ServerDefaultData</DefaultData>
<ExtentSize>6</ExtentSize>
<IdLocation>^dc.FhirLab.ServerD</IdLocation>
<IndexLocation>^dc.FhirLab.ServerI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="ApiKey">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Endpoint">
<AverageFieldSize>43.5</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="EndpointOAuth">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ServerName">
<AverageFieldSize>28.5</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^dc.FhirLab.ServerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
