## Variables
PACKER_POLICY_NAME\
PACKER_ROLE_NAME\
PACKER_INST_PROF_NAME\
PACKER_POLICY_ARN\

### Create policy and role

```
aws iam create-policy \
    --policy-name $PACKER_POLICY_NAME \
    --policy-document file://policies/packer-policy-access.json \
    --tags '[{"Key":"courses","Value":"hw-5"},{"Key":"Task","Value":"5"}]'
```

```
aws iam create-role \
--role-name $PACKER_ROLE_NAME \
--assume-role-policy-document file://policies/access-policy-doc.json \
--tags '[{"Key":"courses","Value":"hw-5"},{"Key":"Task","Value":"5"}]'
```

```
PACKER_INST_PROF_NAME=packer
```

```
aws iam create-instance-profile \
--instance-profile-name $PACKER_INST_PROF_NAME
```

```
PACKER_POLICY_ARN=$(aws iam list-policies --query 'Policies[?PolicyName==`packer-policy-ssm-access`].Arn' --output text)
```

```
aws iam attach-role-policy \
    --policy-arn arn:aws:iam::730335557158:policy/packer-policy-ssm-access \
    --role-name $PACKER_ROLE_NAME
```
