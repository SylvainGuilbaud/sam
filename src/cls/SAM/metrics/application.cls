/// Example of a custom class for the /metric API
Class SAM.metrics.application Extends %SYS.Monitor.SAM.Abstract
{

Parameter PRODUCT = "myapp";

/// Collect metrics from the specified sensors
Method GetSensors() As %Status
{
   do ..SetSensor("my_counter",$increment(^MyCounter),"my_label")
   do ..SetSensor("my_gauge",$random(100))
   return $$$OK
}

ClassMethod add() As %Status
{
    set ns=$NAMESPACE
    zn "%SYS"
    set status = ##class(SYS.Monitor.SAM.Config).AddApplicationClass($CLASSNAME(), ns)
    if status {
        write $CLASSNAME()," successfully added to SAM configuration in ",ns," namespace",!
        write "<<< WARNING >>> To get the metrics, do not forget to add appropriate roles/resources to /api/monitor application",!
    } else {
        write "error while adding ",$CLASSNAME()," to SAM configuration in ",ns," namespace",$system.Status.GetErrorText(status),!
    }
    zn ns
    return status
}

}
