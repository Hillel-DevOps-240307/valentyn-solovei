## HW-2 AWS vpc and instances

### Variables
VPC_ID \
PUB_SUB_ID \
PRIV_SUB_ID \
IGW_ID \
RT_ID \
PUB_RT_ID \
PRIV_RT_ID \
AMI_ID \
ACC_ID \
END_ID \
DB_AMI_ID


```
aws ec2 create-vpc --cidr-block 192.168.0.0/24 --tag-specifications "ResourceType=vpc,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=hw2_demo_vpc}]"
```

<details>

{
    "Vpc": {
        "CidrBlock": "192.168.0.0/24",
        "DhcpOptionsId": "dopt-0256cf9c03b2dcf50",
        "State": "pending",
        "VpcId": "vpc-0b36aecd7aedb13e5",
        "OwnerId": "730335557158",
        "InstanceTenancy": "default",
        "Ipv6CidrBlockAssociationSet": [],
        "CidrBlockAssociationSet": [
            {
                "AssociationId": "vpc-cidr-assoc-04df5a2b22d5fb40b",
                "CidrBlock": "192.168.0.0/24",
                "CidrBlockState": {
                    "State": "associated"
                }
            }
        ],
        "IsDefault": false,
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-2"
            },
            {
                "Key": "Project",
                "Value": "demo_hw-2"
            },
            {
                "Key": "Name",
                "Value": "hw2_demo_vpc"
            }
        ]
    }
}

</details>
### Get VPC_ID
``` VPC_ID=$(aws ec2 describe-vpcs --filter Name=tag:Project,Values=demo_hw-2 --query "Vpcs[].VpcId" --output text) ```

### Create public subnet 192.168.0.0/26

``` aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 192.168.0.0/26 \
> --tag-specifications "ResourceType=subnet,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=public-sub}]" ```

<details>

{
    "Subnet": {
        "AvailabilityZone": "eu-central-1b",
        "AvailabilityZoneId": "euc1-az3",
        "AvailableIpAddressCount": 59,
        "CidrBlock": "192.168.0.0/26",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false,
        "State": "available",
        "SubnetId": "subnet-0d2f2b937a207750e",
        "VpcId": "vpc-0b36aecd7aedb13e5",
        "OwnerId": "730335557158",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": [],
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-2"
            },
            {
                "Key": "Project",
                "Value": "demo_hw-2"
            },
            {
                "Key": "Name",
                "Value": "public-sub"
            }
        ],
        "SubnetArn": "arn:aws:ec2:eu-central-1:730335557158:subnet/subnet-0d2f2b937a207750e",
        "EnableDns64": false,
        "Ipv6Native": false,
        "PrivateDnsNameOptionsOnLaunch": {
            "HostnameType": "ip-name",
            "EnableResourceNameDnsARecord": false,
            "EnableResourceNameDnsAAAARecord": false
        }
    }
}
</details>

### Create private subnet 192.168.0.64/26

```
aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 192.168.0.64/26 \
--tag-specifications "ResourceType=subnet,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=private-sub}]"
```

<details>
{
    "Subnet": {
        "AvailabilityZone": "eu-central-1b",
        "AvailabilityZoneId": "euc1-az3",
        "AvailableIpAddressCount": 59,
        "CidrBlock": "192.168.0.64/26",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false,
        "State": "available",
        "SubnetId": "subnet-09bf80f6a112d5313",
        "VpcId": "vpc-0b36aecd7aedb13e5",
        "OwnerId": "730335557158",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": [],
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-2"
            },
            {
                "Key": "Project",
                "Value": "demo_hw-2"
            },
            {
                "Key": "Name",
                "Value": "private-sub"
            }
        ],
        "SubnetArn": "arn:aws:ec2:eu-central-1:730335557158:subnet/subnet-09bf80f6a112d5313",
        "EnableDns64": false,
        "Ipv6Native": false,
        "PrivateDnsNameOptionsOnLaunch": {
            "HostnameType": "ip-name",
            "EnableResourceNameDnsARecord": false,
            "EnableResourceNameDnsAAAARecord": false
        }
    }
}
</details>

### GET public and private subnets id
```
PUB_SUB_ID=$(aws ec2 describe-subnets --filters Name=tag:Project,Values=demo_hw-2 Name=tag:Name,Values=public-sub --query "Subnets[].SubnetId" --output text)
```

```
PRIV_SUB_ID=$(aws ec2 describe-subnets --filters Name=tag:Project,Values=demo_hw-2 Name=tag:Name,Values=private-sub --query "Subnets[].SubnetId" --output text)
```

### Add public ip on boot instance
```
aws ec2 modify-subnet-attribute --subnet-id $PUB_SUB_ID --map-public-ip-on-launch
```
<details>
aws ec2 describe-subnets --subnet-ids $PUB_SUB_ID |grep MapPublicIpOnLaunch
"MapPublicIpOnLaunch": true,
</details>

### Create gateway
```
aws ec2 create-internet-gateway --tag-specifications \
> "ResourceType=internet-gateway,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=igw-hw2}]"
```
<details>
{
    "InternetGateway": {
        "Attachments": [],
        "InternetGatewayId": "igw-0f7bf877daac0f6b0",
        "OwnerId": "730335557158",
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-2"
            },
            {
                "Key": "Project",
                "Value": "demo_hw-2"
            },
            {
                "Key": "Name",
                "Value": "igw-hw2"
            }
        ]
    }
}
</details>

### Get gateway id
```
IGW_ID=$(aws ec2 describe-internet-gateways --filters Name=tag:Project,Values=demo_hw-2 --query "InternetGateways[].InternetGatewayId" --output text)
```

### Attach internet gateway to VPC
```
aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
```
<details>
{
    "InternetGateways": [
        {
            "Attachments": [
                {
                    "State": "available",
                    "VpcId": "vpc-0b280ac201d6c051a"
                }
            ],
            "InternetGatewayId": "igw-062688a7ea734e851",
            "OwnerId": "730335557158",
            "Tags": []
        },
        {
            "Attachments": [
                {
                    "State": "available",
                    "VpcId": "vpc-0b36aecd7aedb13e5"
                }
            ],
            "InternetGatewayId": "igw-0f7bf877daac0f6b0",
            "OwnerId": "730335557158",
            "Tags": [
                {
                    "Key": "Project",
                    "Value": "demo_hw-2"
                },
                {
                    "Key": "courses",
                    "Value": "hw-2"
                },
                {
                    "Key": "Name",
                    "Value": "igw-hw2"
                }
            ]
        }
    ]
}
</details>



### Create and modify routing tables

RT was already created for this vpc modified it

```
RT_ID=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPC_ID"   --query "RouteTables[].Associations[].RouteTableId" --output text)

aws ec2 create-tags  --resources $RT_ID --tags 'Key="Name",Value=pub_rt'
aws ec2 create-tags  --resources $RT_ID --tags 'Key="Project",Value=demo_hw-2'
aws ec2 create-tags  --resources $RT_ID --tags  'Key="courses",Value=hw-2'
```

Created new route table for private subnet

```
aws ec2 create-route-table --vpc-id $VPC_ID --tag-specifications "ResourceType=route-table,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=priv_rt}]"
```

<details>

{
    "RouteTable": {
        "Associations": [],
        "PropagatingVgws": [],
        "RouteTableId": "rtb-0621f94ee0012d187",
        "Routes": [
            {
                "DestinationCidrBlock": "192.168.0.0/24",
                "GatewayId": "local",
                "Origin": "CreateRouteTable",
                "State": "active"
            }
        ],
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-2"
            },
            {
                "Key": "Project",
                "Value": "demo_hw-2"
            },
            {
                "Key": "Name",
                "Value": "priv_rt"
            }
        ],
        "VpcId": "vpc-0b36aecd7aedb13e5",
        "OwnerId": "730335557158"
    },
    "ClientToken": "b4177675-70d7-4fed-af97-b6943ef7cbc5"
}
</details>

### Get public and private route tables id

```
PUB_RT_ID=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPC_ID" --filters "Name=tag:Name,Values=pub_rt"   --query "RouteTables[].Associations[].RouteTableId" --output text)

PRIV_RT_ID=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPC_ID" --filters "Name=tag:Name,Values=priv_rt"  --query "RouteTables[].RouteTableId" --output text)
```

### Add route tables to subnets

```
aws ec2 associate-route-table --route-table-id $PUB_RT_ID --subnet-id $PUB_SUB_ID
```

<details>
{
    "AssociationId": "rtbassoc-09767e3c4eba33f4a",
    "AssociationState": {
        "State": "associated"
    }
}
</details>

```
aws ec2 associate-route-table --route-table-id $PRIV_RT_ID --subnet-id $PRIV_SUB_ID
```
<details>
{
    "AssociationId": "rtbassoc-012298cd1ffcd1669",
    "AssociationState": {
        "State": "associated"
    }
}
</details>

### Creating security groups

```
aws ec2 create-security-group --group-name front-sg --description "Public Security Group" --vpc-id $VPC_ID \
--tag-specifications "ResourceType=security-group,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=front-sg-hw2}]"
```

<details>
{
    "GroupId": "sg-08238953f2e8f8423",
    "Tags": [
        {
            "Key": "courses",
            "Value": "hw-2"
        },
        {
            "Key": "Project",
            "Value": "demo_hw-2"
        },
        {
            "Key": "Name",
            "Value": "front-sg-hw2"
        }
    ]
}
</details>

### Get security groups id

```
SG_FRONT_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=front-sg --query "SecurityGroups[].GroupId" --output text)

SG_BACK_ID=$(aws ec2 create-security-group --group-name back-sg --description "Public Security Group" --vpc-id $VPC_ID \
--tag-specifications "ResourceType=security-group,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=back-sg-hw2}]" --query GroupId --output text)
```

### Add rules to security groups

```
aws ec2 authorize-security-group-ingress --group-id $SG_FRONT_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
```

<details>

{
    "Return": true,
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-0607c820360b8113e",
            "GroupId": "sg-08238953f2e8f8423",
            "GroupOwnerId": "730335557158",
            "IsEgress": false,
            "IpProtocol": "tcp",
            "FromPort": 22,
            "ToPort": 22,
          730335557158  "CidrIpv4": "0.0.0.0/0"
        }
    ]
}

</details>

```
aws ec2 authorize-security-group-ingress --group-id $SG_BACK_ID --protocol -1 --port -1 --source-group $SG_BACK_ID
```

<details>

{
    "Return": true,
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-06ab1e258e21027bd",
            "GroupId": "sg-006f5e11ad9272fca",
            "GroupOwnerId": "730335557158",
            "IsEgress": false,
            "IpProtocol": "-1",
            "FromPort": -1,
            "ToPort": -1,
            "ReferencedGroupInfo": {
                "GroupId": "sg-006f5e11ad9272fca",
                "UserId": "730335557158"
            }
        }
    ]
}
</details>

## Creating instances


Create web application instance

```
export AMI_ID=ami-023adaba598e661ac

aws ec2 run-instances --image-id $AMI_ID \
--count 1 \
--instance-type t2.micro \
--key-name aws \
--security-group-ids $SG_FRONT_ID $SG_BACK_ID --subnet-id $PUB_SUB_ID \
--tag-specifications \
"ResourceType=instance,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=demo-web-hw2}]" \
--user-data file://scripts/web.sh
```

Create database instances in public subnet for create image from it

```
aws ec2 run-instances --image-id $AMI_ID \
--count 1 \
--instance-type t2.micro \
--key-name aws \
--security-group-ids $SG_FRONT_ID $SG_BACK_ID --subnet-id $PUB_SUB_ID \
--iam-instance-profile Name=s3-ro-name \
--tag-specifications \
"ResourceType=instance,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=demo-db-hw2}]" \
--user-data file://scripts/db.sh
```

### Get database instance id

```
DB_IM_ID=$(aws ec2 describe-instances --filter Name=instance-state-code,Values=16 Name=tag:Name,Values=demo-db-hw2 --query "Reservations[].Instances[].InstanceId" --output text)
```

Create instance from database instance
```
aws ec2 create-image \
    --instance-id $DB_IM_ID \
    --name "mysql db" \
    --tag-specifications "ResourceType=image,Tags=[{Key=Project,Value=demo-hw2}]" "ResourceType=snapshot,Tags=[{Key=Project,Value=demo-hw2}]"
```

### Get account ID, endpoint ID and DB AMI ID
```
ACC_ID=$(aws sts get-caller-identity |jq -r .Account)
```

```
END_ID=$(aws ec2 describe-vpc-endpoints --filters | jq ".VpcEndpoints[] |select(.VpcId|match(\"${VPC_ID}\")) |.VpcEndpointId"  -r)
```

```
DB_AMI_ID=$(aws ec2 describe-images --owners $ACC_ID --filters "Name=tag:Project,Values=demo-hw2" --query "Images[].ImageId[]" --output text)
```

### Modify endpoint to attach route table to it
```
aws ec2 modify-vpc-endpoint --vpc-endpoint-id $END_ID --add-route-table-ids $PRIV_RT_ID --reset-policy
```

<details>
{
    "Return": true
}
</details>

### Copy init.sql to bucket
```
aws s3 cp awscli/init.sql s3://courses-buck/init.sql
```


### Create db instance in private zone from previously created AMI

```
aws ec2 run-instances --image-id $DB_AMI_ID \
--count 1 \
--instance-type t2.micro \
--key-name aws \
--iam-instance-profile Name=s3-ro-demo \
--security-group-ids $SG_FRONT_ID $SG_BACK_ID --subnet-id $PRIV_SUB_ID \
--tag-specifications \
"ResourceType=instance,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=demo-db-hw2}]" \
--user-data file://scripts/db2.sh
```
