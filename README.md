# Terraform repository and modules generator with Terratest specs

A Terraform template for Ironman generator to create modules with tests written with terratest (a Golang library to test Terraform, Packer and Docker and more)

* Ironman generator: https://github.com/ironman-project/ironman
* Terratest repository: https://github.com/gruntwork-io/terratest

## Installing this generator

1. Install ironman https://github.com/ironman-project/ironman#install
1. Install this generator
```
ironman install https://github.com/omarvides/terraform-generator.git
```

## Defining your variables

Create a yaml file with the parameters of the generator it could be a file named values.yaml containing the variables that the template expects

```example.yaml```

``` yaml
projectName: Some Project Name
projectDescription: Some project Descript
```

### This generator can create different type of modules, variables change for each provider

### AWS file eample

```variables.yaml```

``` yaml
ami_id: ami-0000000
region: us-east-1
instance_type: t2.micro[]
instance_name: ec2_instance_name
```

### Variables reference

| Variable      | Description                                                                  | Default Value   |
|---------------|------------------------------------------------------------------------------|-----------------|
| ami_id        | The AMI id to use to create the a ec2 instance                               |                 |
| region        | The region where the ami exists                                              | us-east-1       |
| instance_type | The instance type that defines the size of the instance that will be created | t2.micro        |
| instance_name | The name that will be set to the instance                                    | sample-instance |

## Using it

* Since this module uses terratest which is a Golang library to use this module is needed to install Golang first, please follow the installation instructions here https://golang.org/doc/install for your OS, you can find the Golang installers here https://golang.org/dl/.

* Once Golang is installed generate your terraform module under your GOPATH directory (this becomes clear after installing Go)

### Generating a new aws module

```
ironman generate terraform-module:aws name-of-your-module -f variables.yaml
```

That command will generate a structure similar to the tree below (the vendor directory will contain more nested folders with the dependencies to run the tests, this is a simplified view of the tree)

```
├── README.md
├── main.tf
├── outputs.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
├── tests
│   ├── Gopkg.lock
│   ├── Gopkg.toml
│   ├── aws_test.go
│   └── vendor
│       ├── github.com
│       └── golang.org
└── variables.tf
```

### Before you run any tests

Please notice that terratest to test terraform modules needs to create real infrastructure, so please be careful with what you test, as you could be billed the provider where you are creating resources.

The ```terraformOptions``` variable at the testing file can pass configurations to your module, as example let's assume your variables file contains the configuration below

```
variable "region" {
  type = "string"
  default = "us-east-1"
}

variable "instance_type" {
  type = "string"
  default = "t2.micro"
}

variable "ami" {
  type = "string"
  default = "ami-0000"
}

variable "name" {
  type = "string"
  default = "my-instance-name-tag"
}
```

This configurations will be overwritten by the test as follows

``` go

package tests

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWS(t *testing.T) {
	uniqueID := random.UniqueId()
	terraformOptions := &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"ami":           "ami-c0f0c0bf",
			"instance_type": "t2.micro",
			"name":          fmt.Sprintf("test-instance-%s", uniqueID),
			"region":        "us-east-1",
		},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
```
the configuration line ```"name":          fmt.Sprintf("test-instance-%s", uniqueID),``` will work as namespacing to prevent your tests to overwrite or destroy any existing infrastructure that you created previously using that code, this is a terratest feature, and you can read more about that at the [terratest github repository namspacing documentation](https://github.com/gruntwork-io/terratest#namespacing)


### Running your tests

* Move to the test directory under your generated repository and install the dependencies by running (inside your repository)

``` bash
dep ensure
```

* At the root of your newly generated repository run

```
go test -v ./...
```

## Notes

I'm providing with this repository an ami that you can use for your tests ```ami-c0f0c0bf``` it is only available at us-east-1, so if you try to launch a new instance based on this ami on a region different than us-east-1 it won't work, also I don't give any warranty that this ami will exist forever, please consider using one of the default aws amis, or build your own using [packer](https://www.packer.io/)
