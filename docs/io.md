## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_spaces | The list of the address spaces that is used by the virtual network. | `list(string)` | `[]` | no |
| bgp\_community | The BGP community attribute in format <as-number>:<community-value>. | `number` | `null` | no |
| custom\_name | Override default naming convention | `string` | `null` | no |
| deployment\_mode | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| dns\_servers | The DNS servers to be used with vNet. | `list(string)` | `[]` | no |
| edge\_zone | (Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created. | `string` | `null` | no |
| enable | Flag to control the module creation | `bool` | `true` | no |
| enable\_ddos\_pp | Flag to control the resource creation | `bool` | `false` | no |
| enable\_encryption\_settings | Specifies if the encrypted Virtual Network allows VM that does not support encryption. Possible values are DropUnencrypted and AllowUnencrypted. | `string` | `null` | no |
| enable\_network\_watcher | Flag to control creation of network watcher. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `null` | no |
| existing\_ddos\_pp | ID of an existing DDOS protection plan defined in the same subscription. | `string` | `null` | no |
| extra\_tags | Variable to pass extra tags. | `map(string)` | `null` | no |
| flow\_timeout\_in\_minutes | The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes. | `number` | `null` | no |
| label\_order | The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']. | `list(string)` | <pre>[<br>  "name",<br>  "environment",<br>  "location"<br>]</pre> | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `null` | no |
| managedby | ManagedBy, eg 'terraform-az-modules'. | `string` | `"terraform-az-modules"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `null` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/terraform-az-modules/terraform-azure-vnet"` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | `null` | no |
| resource\_position\_prefix | Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.<br><br>- If true, the keyword is prepended: "vnet-core-dev".<br>- If false, the keyword is appended: "core-dev-vnet".<br><br>This helps maintain naming consistency based on organizational preferences. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| ddos\_existing\_plan\_id | The ID of the DDoS Protection Plan associated with the Virtual Network. |
| ddos\_protection\_plan\_id | The ID of the newly created DDoS Protection Plan. |
| network\_watcher\_id | The ID of the Network Watcher. |
| network\_watcher\_name | The name of the Network Watcher deployed. |
| vnet\_address\_space | The address space of the newly created Virtual Network. |
| vnet\_guid | The GUID of the Virtual Network. |
| vnet\_id | The ID of the newly created Virtual Network. |
| vnet\_location | The location of the newly created Virtual Network. |
| vnet\_name | The name of the newly created Virtual Network. |
| vnet\_rg\_name | The name of the resource group containing the Virtual Network. |

