# This module is intended to create an AWS EKS cluster for further Regula Forensics Helm chart deployment

## Prerequisites

**AWS**
- An AWS account designated to deploy Regula Forensics DocReader/FaceAPI apps.
- An **IAM** user that can assume the **OrganizationAccountAccessRole** role in the destination AWS account.

## Preparation Steps
### Export AWS credentials

```bash
  export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
  export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
```

### Create a Terraform main.tf file and pass the required variables **account_id**, **region**, and **name**

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
## Add a Regula license for your chart
```hcl
data "template_file" "docreader_license" {
  template = filebase64("${path.module}/license/docreader/regula.license")
}
```
```hcl
data "template_file" "face_api_license" {
  template = filebase64("${path.module}/license/faceapi/regula.license")
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

## Optional: Custom Helm values

### Custom values for Docreader chart
If you are about to deploy a Docreader Helm chart with custom values:
- Create a **values.yml** file in a folder named after the application (for example, values/docreader/values.yml).
- Pass the file location to the `template_file` of `data source` block:
```hcl
data "template_file" "docreader_values" {
  template = file("${path.module}/values/docreader/values.yml")
}
```
### Custom values for Faceapi chart
If you are about to deploy Faceapi Helm chart with custom values:
- Create a **values.yml** in a folder named after the application (for example, values/faceapi/values.yml).
- Pass the file location to the `template_file` of the `data source` block:
```hcl
data "template_file" "faceapi_values" {
  template = file("${path.module}/values/faceapi/values.yml")
}
```

Finally, pass rendered template files to the `docreader_values/faceapi_values` variables:
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
| enable_docreader  | Deploy Docreader Helm chart                                       | bool          | false                                        |
| docreader_values  | Docreader Helm values                                             | string        | null                                         |
| enable_faceapi    | Deploy Faceapi Helm chart                                         | bool          | false                                        |
| faceapi_values    | Faceapi Helm values                                               | string        | null                                         |
| docreader_license | Docreader Regula license file                                     | string        | null                                         |
| face_api_license  | Faceapi Regula license file                                       | string        | null                                         |
