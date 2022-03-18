
<# SetVirtualNetworksPeering.ps1

    this script is to connect 2 virtual networks deployed in different subscriptions with Network Peering feature.

#>

<# REFERENCES

    - Connect virtual networks with virtual network peering using PowerShell: https://docs.microsoft.com/en-us/azure/virtual-network/tutorial-connect-virtual-networks-powershell

#>

<# MODULES 
    
#>



function Init {

    Clear-Host

    #Connect-AzAccount

    Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"
    
    $Day = Get-Date -Format "dddd"

    <# VARIABLES

        the variables below should be changed if reuse of this script in another context.
            - $SubscriptionId = subscription Id to be used in the context
            - $ResourceGroupNameForEventHub = resource group where the Event Hub is located
            - $EventHubConsumerGroup

    #>

    $subscription_hub_name = "To be updated"
    $resource_group_hub_name = "To be updated"
    $virtual_network_hub_name = "To be updated"

    $subscription_spoke_name = "To be updated"
    $resource_group_spoke_name = "To be updated"
    $virtual_network_spoke_name = "To be updated"

    CheckResources -subscription_name $subscription_hub_name -resource_group_name $resource_group_hub_name -virtual_network_name $virtual_network_hub_name 
    Write-Host " "
    CheckResources -subscription_name $subscription_spoke_name -resource_group_name $resource_group_spoke_name -virtual_network_name $virtual_network_spoke_name
    Write-Host " "

    if ($virtual_network_hub_ok -eq $virtual_network_spoke_ok) {

        Write-Host " "
        Write-Host "[info] virtual networks have been verified. " 
        Write-Host "[info] virtual network peering can be done. " 

        VirtualNetworkPeering

    }

}



function CheckResources {
    
    param (
        [Parameter(Mandatory=$true)]$subscription_name,
        [Parameter(Mandatory=$true)]$resource_group_name,
        [Parameter(Mandatory=$true)]$virtual_network_name
    )

    if (!($subscription_name)) {

        Write-Host "[error] subscription name has not been set. ($subscription_name) "
        Write-Host "[error] subscription name is mandatory to run this script. "

        Return 

    }
    else {
    
        Write-Host "[info] subscription name has been set. ($subscription_name) "

        $subscription_id = (Get-AzSubscription -SubscriptionName $subscription_name).id

        if (!($subscription_id)) {

            Write-Host "[error] subscription id has not been found. ($subscription_id) "

            Return

        }
        else {
            
            Write-Host "[info] subscription id has been found. ($subscription_id) "

            $context = Set-AzContext -SubscriptionId $subscription_id
            Write-Host "[info] azure context has been set. "

            $resource_group_id = (Get-AzResourceGroup -ResourceGroupName $resource_group_name).ResourceId

            if (!($resource_group_id)) {

                Write-Host "[error] resource group has not been found. ($resource_group_name) "

                Return

            }
            else {
                
                Write-Host "[info] resource group has been found. ($resource_group_name) "

                $virtual_network = Get-AzVirtualNetwork -ResourceGroupName $resource_group_name -Name $virtual_network_name -ErrorAction SilentlyContinue
                $virtual_network_id = $virtual_network.Id

                if (!($virtual_network_id)) {

                    Write-Host "[error] virtual network has not been found. ($virtual_network_name) "
    
                    Return
    
                }
                else {
                    
                    Write-Host "[info] virtual network has been found. ($virtual_network_name) "

                    if ($virtual_network_name -eq $virtual_network_hub_name) {

                        $virtual_network_hub = $virtual_network
                        Write-Host "[info] virtual network for Hub is ok. "
                        $virtual_network_hub_ok = $true

                    }
                    else {
                        
                        $virtual_network_spoke = $virtual_network
                        Write-Host "[info] virtual network for Hub is ok. "
                        $virtual_network_spoke_ok = $true

                    }

                }

            }

        }

    }

}



function VirtualNetworkPeering {
    
    Write-Host " "

    Add-AzVirtualNetworkPeering -Name "$virtual_network_hub_name-$virtual_network_spoke_name" -VirtualNetwork $virtual_network_hub -RemoteVirtualNetworkId $virtual_network_spoke.id | Out-Null

    Add-AzVirtualNetworkPeering -Name "$virtual_network_spoke_name-$virtual_network_hub_name" -VirtualNetwork $virtual_network_spoke -RemoteVirtualNetworkId $virtual_network_hub.id | Out-Null

}



##### INIT #####
Init
