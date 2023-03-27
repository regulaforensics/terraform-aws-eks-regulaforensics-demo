# This module is intended to create AWS EKS cluster and for further regulaforensics helm charts deployment
## Prerequisites

**AWS**
- AWS Account designated to deploy regulaforensics docreader/faceapi apps
- **IAM** user that can assume **OrganizationAccountAccessRole** role in the destination AWS account

## Preparation Steps
### Export AWS credentials

```bash
  export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
  export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
```

### Create terraform main.tf file and pass required variables **account_id** and **region** and **name**

```hcl
module "eks_cluster" {
  source             = "github.com/regulaforensics/terraform-aws-regulaforensics-demo"
  account_id         = var.account_id
  region             = var.region
  name               = var.name
  enable_docreader   = true
  enable_faceapi     = true
}
```
## Add Regula license for your chart
```
data "template_file" "docreader_license" {
  template = filebase64("${path.module}/docreader-values/regula.license")
}
```
```
data "template_file" "face_api_license" {
  template = filebase64("${path.module}/faceapi-values/regula.license")
}
```
```hcl
module "eks_cluster" {
  ...
  docreader_license  = data.template_file.docreader_license.rendered
  face_api_license   = data.template_file.face_api_license.rendered
  ...
}
```
## Execute terraform template
```bash
  terraform init
  terraform plan
  terraform apply
```

## Optional. Custom Helm values

### Custom values for docreader chart
If you are about to deploy docreader Helm chart with custom values:
- create **values.yml** in folder named by application (i.e. docreader/values.yml)
- pass file location to the `template_file` of `data source` block
```
data "template_file" "docreader_values" {
  template = file("${path.module}/docreader-values/values.yml")
}
```
### Custom values for faceapi chart
If you are about to deploy faceapi Helm chart with custom values:
- create **values.yml** in folder named by application (i.e. faceapi/values.yml)
- pass file location to the `template_file` of `data source` block
```
data "template_file" "faceapi_values" {
  template = file("${path.module}/faceapi-values/values.yml")
}
```

Finally, pass rendered template files to the `docreader_values/faceapi_values` variables
```
module "regulaforensics-demo" {
  source           = "github.com/regulaforensics/terraform-aws-regulaforensics-demo"
  enable_docreader = true
  docreader_values = data.template_file.docreader_values.rendered
  faceapi_values   = data.template_file.faceapi_values.rendered
  ...
}
```

## **Inputs**
| Name              | Description                                                       | Type          | Default                                      |
| ------------------|-------------------------------------------------------------------|---------------|----------------------------------------------|
| account_id        | AWS Account ID                                                    | string        | null                                         |
| region            | AWS Region                                                        | string        | eu-central-1                                 |
| name              | Unique AWS resources name                                         | string        | null                                         |
| vpc_cidr          | The CIDR block for the VPC                                        | string        | 10.0.0.0/16                                  |
| vpc_private_subnet| A list of private subnets inside the VPC                          | list(string)  | ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]|
| vpc_public_subnet | A list of public subnets inside the VPC                           | list(string)  | ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]|
| cluster_version   | Kubernetes `<major>.<minor>` version to use for the EKS cluster   | string        | 1.24                                         |
| instance_types    | Node instance type                                                | string        | t3.medium                                    |
| capacity_type     | Node capacity type                                                | string        | SPOT                                         |
| enable_docreader  | Deploy Docreader helm chart                                       | bool          | false                                        |
| docreader_values  | Docreader helm values                                             | string        | null                                         |
| enable_faceapi    | Deploy Faceapi helm chart                                         | bool          | false                                        |
| faceapi_values    | Faceapi helm values                                               | string        | null                                         |
| docreader_license | Docreader Regula license file                                     | string        | null                                         |
| face_api_license  | Faceapi Regula license file                                       | string        | null                                         |