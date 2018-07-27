# Terraform repository and modules generator with Terratest specs

A Terraform template for Ironman generator to create modules with tests written with terratest (a Golang library)

Ironman generator: https://github.com/ironman-project/ironman

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
|               |                                                                              |                 |
|               |                                                                              |                 |

## Using it

Since this module uses terratest which is a Golang library to use this module is needed to install Golang first, please follow the installation instructions here https://golang.org/doc/install for your OS, you can find the Golang installers here https://golang.org/dl/.

Once Golang is installed generate your terraform module under your GOPATH directory (this becomes clear after installing Go)

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

Start coding :)