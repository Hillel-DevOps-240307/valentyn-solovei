## Variables
DEFAULT_REGION\
DB_POLICY_NAME\
WEB_POLICY_NAME\
DB_ROLE_NAME\
WEB_ROLE_NAME\
DB_INST_PROF_NAME\
WEB_INST_PROF_NAME\
DB_POLICY_ARN\
WEB_POLICY_ARN\
DB_PRIV_IP

### Create parameters

```
aws ssm put-parameter \
    --name "MYSQL_USER" \
    --value "admin" \
    --type "String" \
    --tags '[{"Key":"courses","Value":"hw-3"},{"Key":"Task","Value":"3"},{"Key":"Env","Value":"DB"}]'
```
<details>
{
    "Version": 1,
    "Tier": "Standard"
}
</details>

```
aws ssm put-parameter \
    --name "MYSQL_PASSWORD" \
    --value "Pa55WD" \
    --type "SecureString" \
    --tags '[{"Key":"courses","Value":"hw-3"},{"Key":"Task","Value":"3"},{"Key":"Env","Value":"DB"}]'
```
<details>
{
    "Version": 1,
    "Tier": "Standard"
}
</details>

```
aws ssm put-parameter \
    --name "MYSQL_DB" \
    --value "flask_db" \
    --type "String" \
    --tags '[{"Key":"courses","Value":"hw-3"},{"Key":"Task","Value":"3"},{"Key":"Env","Value":"DB"}]'
```
<details>
{
    "Version": 1,
    "Tier": "Standard"
}
</details>

```
aws ssm put-parameter \
    --name "MYSQL_HOST" \
    --value "127.0.0.1" \
    --type "String" \
    --tags '[{"Key":"courses","Value":"hw-3"},{"Key":"Task","Value":"3"},{"Key":"Env","Value":"DB"}]'
```

<details>
{
    "Version": 1,
    "Tier": "Standard"
}
</details>


### Create and copy data to bucket
>DEFAULT_REGION=$(aws configure get region)

```
aws s3api create-bucket --bucket courses-buck --region $DEFAULT_REGION --create-bucket-configuration LocationConstraint=$DEFAULT_REGION
aws s3 cp scripts/change_param.sh s3://courses-buck/web/change_param.sh
aws s3 cp scripts/init.sql.sh s3://courses-buck/db/init.sql.sh
```
<details>
{
    "Location": "http://courses-buck.s3.amazonaws.com/"
}

</details>

### Create policy and role

>export DB_POLICY_NAME=db-policy-access
export WEB_POLICY_NAME=web-policy-access


```
aws iam create-policy \
    --policy-name $DB_POLICY_NAME \
    --policy-document file://policies/db-policy-access.json \
    --tags '[{"Key":"courses","Value":"hw-3"},{"Key":"Task","Value":"3"}]'
```

<details>
{
    "Policy": {
        "PolicyName": "db-policy-access",
        "PolicyId": "ANPA2UC3EGYTHAREAEI5V",
        "Arn": "arn:aws:iam::730335557158:policy/db-policy-access",
        "Path": "/",
        "DefaultVersionId": "v1",
        "AttachmentCount": 0,
        "PermissionsBoundaryUsageCount": 0,
        "IsAttachable": true,
        "CreateDate": "2024-03-27T14:41:02+00:00",
        "UpdateDate": "2024-03-27T14:41:02+00:00",
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-3"
            },
            {
                "Key": "Task",
                "Value": "3"
            }
        ]
    }
}
</details>

```
aws iam create-policy \
    --policy-name $WEB_POLICY_NAME \
    --policy-document file://policies/web-policy-access.json \
    --tags '[{"Key":"courses","Value":"hw-3"},{"Key":"Task","Value":"3"}]'
```

<details>
{
    "Policy": {
        "PolicyName": "web-policy-access",
        "PolicyId": "ANPA2UC3EGYTC6DLVI4BI",
        "Arn": "arn:aws:iam::730335557158:policy/web-policy-access",
        "Path": "/",
        "DefaultVersionId": "v1",
        "AttachmentCount": 0,
        "PermissionsBoundaryUsageCount": 0,
        "IsAttachable": true,
        "CreateDate": "2024-03-27T14:41:10+00:00",
        "UpdateDate": "2024-03-27T14:41:10+00:00",
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-3"
            },
            {
                "Key": "Task",
                "Value": "3"
            }
        ]
    }
}
</details>


>export DB_ROLE_NAME=db-role-access\
export WEB_ROLE_NAME=web-role-access

```
aws iam create-role \
--role-name $DB_ROLE_NAME \
--assume-role-policy-document file://policies/access-policy-doc.json \
--tags '[{"Key":"courses","Value":"hw-3"},{"Key":"Task","Value":"3"}]'
```

<details>
{
    "Role": {
        "Path": "/",
        "RoleName": "db-role-access",
        "RoleId": "AROA2UC3EGYTNTREAPBUP",
        "Arn": "arn:aws:iam::730335557158:role/db-role-access",
        "CreateDate": "2024-03-27T14:42:14+00:00",
        "AssumeRolePolicyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ec2.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        },
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-3"
            },
            {
                "Key": "Task",
                "Value": "3"
            }
        ]
    }
}
</details>

```
aws iam create-role \
--role-name $WEB_ROLE_NAME \
--assume-role-policy-document file://policies/access-policy-doc.json \
--tags '[{"Key":"courses","Value":"hw-3"},{"Key":"Task","Value":"3"}]'
```

<details>
{
    "Role": {
        "Path": "/",
        "RoleName": "web-role-access",
        "RoleId": "AROA2UC3EGYTJIE4KM4LL",
        "Arn": "arn:aws:iam::730335557158:role/web-role-access",
        "CreateDate": "2024-03-27T14:43:00+00:00",
        "AssumeRolePolicyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ec2.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        },
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-3"
            },
            {
                "Key": "Task",
                "Value": "3"
            }
        ]
    }
}
</details>

### Create Instance Profile

>export DB_INST_PROF_NAME=DatabaseServer\
export WEB_INST_PROF_NAME=WebAppServer

```
aws iam create-instance-profile \
--instance-profile-name $DB_INST_PROF_NAME
```
```
aws iam create-instance-profile \
--instance-profile-name $WEB_INST_PROF_NAME
```

<details>
{
    "Role": {
        "Path": "/",
        "RoleName": "ssm-ro-access",
        "RoleId": "AROA2UC3EGYTCTBKIDDIA",
        "Arn": "arn:aws:iam::730335557158:role/ssm-ro-access",
        "CreateDate": "2024-03-26T18:33:04+00:00",
        "AssumeRolePolicyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ec2.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        },
        "Tags": [
            {
                "Key": "courses",
                "Value": "hw-3"
            },
            {
                "Key": "Task",
                "Value": "3"
            }
        ]
    }
}
</details>

#### Get Policy ARN
```
DB_POLICY_ARN=$(aws iam list-policies --query 'Policies[?PolicyName==`db-policy-access`].Arn' --output text)
WEB_POLICY_ARN=$(aws iam list-policies --query 'Policies[?PolicyName==`web-policy-access`].Arn' --output text)
```
### Attach policy to role

```
aws iam attach-role-policy \
    --policy-arn $DB_POLICY_ARN \
    --role-name $DB_ROLE_NAME
```

```
aws iam attach-role-policy \
    --policy-arn $WEB_POLICY_ARN \
    --role-name $WEB_ROLE_NAME
```

### Attach role to instance profile


```
aws iam add-role-to-instance-profile --role-name $DB_ROLE_NAME --instance-profile-name $DB_INST_PROF_NAME
aws iam add-role-to-instance-profile --role-name $WEB_ROLE_NAME --instance-profile-name $WEB_INST_PROF_NAME
```


### Start instances*

> *Variables for instances you can find in VPC.md


aws ec2 run-instances --image-id $AMI_ID \
--count 1 \
--instance-type t2.micro \
--key-name aws \
--iam-instance-profile Name=$WEB_INST_PROF_NAME \
--security-group-ids $SG_FRONT_ID $SG_BACK_ID --subnet-id $PUB_SUB_ID \
--tag-specifications \
"ResourceType=instance,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=demo-web-hw2},{"Key"="Task","Value"="3"}]" \
--user-data file://scripts/web.sh

<details>
{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-023adaba598e661ac",
            "InstanceId": "i-0d4ea1df215a61eb9",
            "InstanceType": "t2.micro",
            "KeyName": "aws",
            "LaunchTime": "2024-03-27T14:48:01+00:00",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "eu-central-1b",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-192-168-0-61.eu-central-1.compute.internal",
            "PrivateIpAddress": "192.168.0.61",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-0d2f2b937a207750e",
            "VpcId": "vpc-0b36aecd7aedb13e5",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "8fb1a6c4-1554-4226-b067-b5384947c482",
            "EbsOptimized": false,
            "EnaSupport": true,
            "Hypervisor": "xen",
            "IamInstanceProfile": {
                "Arn": "arn:aws:iam::730335557158:instance-profile/WebAppServer",
                "Id": "AIPA2UC3EGYTBJKA277QG"
            },
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2024-03-27T14:48:01+00:00",
                        "AttachmentId": "eni-attach-0641c0d887ea2a098",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching",
                        "NetworkCardIndex": 0
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "back-sg",
                            "GroupId": "sg-006f5e11ad9272fca"
                        },
                        {
                            "GroupName": "front-sg",
                            "GroupId": "sg-08238953f2e8f8423"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "06:1c:d5:72:75:cb",
                    "NetworkInterfaceId": "eni-0dab326877eb86245",
                    "OwnerId": "730335557158",
                    "PrivateIpAddress": "192.168.0.61",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateIpAddress": "192.168.0.61"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-0d2f2b937a207750e",
                    "VpcId": "vpc-0b36aecd7aedb13e5",
                    "InterfaceType": "interface"
                }
            ],
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "back-sg",
                    "GroupId": "sg-006f5e11ad9272fca"
                },
                {
                    "GroupName": "front-sg",
                    "GroupId": "sg-08238953f2e8f8423"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
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
                    "Value": "demo-web-hw3"
                },
                {
                    "Key": "Task",
                    "Value": "3"
                }
            ],
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 1
            },
            "CapacityReservationSpecification": {
                "CapacityReservationPreference": "open"
            },
            "MetadataOptions": {
                "State": "pending",
                "HttpTokens": "optional",
                "HttpPutResponseHopLimit": 1,
                "HttpEndpoint": "enabled",
                "HttpProtocolIpv6": "disabled",
                "InstanceMetadataTags": "disabled"
            },
            "EnclaveOptions": {
                "Enabled": false
            },
            "BootMode": "uefi-preferred",
            "PrivateDnsNameOptions": {
                "HostnameType": "ip-name",
                "EnableResourceNameDnsARecord": false,
                "EnableResourceNameDnsAAAARecord": false
            },
            "MaintenanceOptions": {
                "AutoRecovery": "default"
            },
            "CurrentInstanceBootMode": "legacy-bios"
        }
    ],
    "OwnerId": "730335557158",
    "ReservationId": "r-0ea1ed0ff6e4af8dc"
}
</details>

> *Save instance private ip to variable so you can update param in system manager parameter store later

```
DB_PRIV_IP=$(aws ec2 run-instances --image-id $DB_AMI_ID \
--count 1 \
--instance-type t2.micro \
--key-name aws \
--iam-instance-profile Name=$DB_INST_PROF_NAME \
--security-group-ids $SG_FRONT_ID $SG_BACK_ID --subnet-id $PRIV_SUB_ID \
--tag-specifications \
"ResourceType=instance,Tags=[{Key=courses,Value=hw-2},{Key=Project,Value=demo_hw-2},{Key=Name,Value=demo-db-hw2},{"Key"="Task","Value"="3"}]" \
--user-data file://scripts/db2.sh --query "Instances[].NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress" --output text)
```

<details>
{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-01bf2fbf336ffbe5b",
            "InstanceId": "i-08387157ac6b2035a",
            "InstanceType": "t2.micro",
            "KeyName": "aws",
            "LaunchTime": "2024-03-27T14:48:07+00:00",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "eu-central-1b",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-192-168-0-73.eu-central-1.compute.internal",
            "PrivateIpAddress": "192.168.0.73",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-09bf80f6a112d5313",
            "VpcId": "vpc-0b36aecd7aedb13e5",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "974e830b-2dd9-438e-b1d4-32d07ebda53d",
            "EbsOptimized": false,
            "EnaSupport": true,
            "Hypervisor": "xen",
            "IamInstanceProfile": {
                "Arn": "arn:aws:iam::730335557158:instance-profile/DatabaseServer",
                "Id": "AIPA2UC3EGYTBAPOQY3UT"
            },
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2024-03-27T14:48:07+00:00",
                        "AttachmentId": "eni-attach-0dcfbe638619badeb",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching",
                        "NetworkCardIndex": 0
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "back-sg",
                            "GroupId": "sg-006f5e11ad9272fca"
                        },
                        {
                            "GroupName": "front-sg",
                            "GroupId": "sg-08238953f2e8f8423"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "06:6b:72:8e:20:41",
                    "NetworkInterfaceId": "eni-01adea94d41960794",
                    "OwnerId": "730335557158",
                    "PrivateIpAddress": "192.168.0.73",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateIpAddress": "192.168.0.73"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-09bf80f6a112d5313",
                    "VpcId": "vpc-0b36aecd7aedb13e5",
                    "InterfaceType": "interface"
                }
            ],
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "back-sg",
                    "GroupId": "sg-006f5e11ad9272fca"
                },
                {
                    "GroupName": "front-sg",
                    "GroupId": "sg-08238953f2e8f8423"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "Tags": [
                {
                    "Key": "Task",
                    "Value": "3"
                },
                {
                    "Key": "Name",
                    "Value": "demo-db-hw3"
                },
                {
                    "Key": "Project",
                    "Value": "demo_hw-2"
                },
                {
                    "Key": "courses",
                    "Value": "hw-2"
                }
            ],
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 1
            },
            "CapacityReservationSpecification": {
                "CapacityReservationPreference": "open"
            },
            "MetadataOptions": {
                "State": "pending",
                "HttpTokens": "optional",
                "HttpPutResponseHopLimit": 1,
                "HttpEndpoint": "enabled",
                "HttpProtocolIpv6": "disabled",
                "InstanceMetadataTags": "disabled"
            },
            "EnclaveOptions": {
                "Enabled": false
            },
            "BootMode": "uefi-preferred",
            "PrivateDnsNameOptions": {
                "HostnameType": "ip-name",
                "EnableResourceNameDnsARecord": false,
                "EnableResourceNameDnsAAAARecord": false
            },
            "MaintenanceOptions": {
                "AutoRecovery": "default"
            },
            "CurrentInstanceBootMode": "legacy-bios"
        }
    ],
    "OwnerId": "730335557158",
    "ReservationId": "r-04657286b23d8d3d7"
}
</details>

> Update parameter

```
aws ssm put-parameter \
    --name "MYSQL_HOST" \
    --value $DB_PRIV_IP \
    --overwrite
```
<details>
{
    "Version": 2,
    "Tier": "Standard"
}
</details>
