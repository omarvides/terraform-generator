# Terraform repository and modules generator with Terratest specs

An Ironman generator template to create terraform modules with tests written with terratest (a golang library)

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

### This repository expected variables, to write your own instance of the file above, you can copy following snippet, write it down in a yaml file and modify it to meet your needs.

```variables.yaml```

``` yaml
ami_id: ami-0000000
region: us-east-1
instance_type: t2.micro
instance_name: web_site
```

## Using it

Since this module uses terratest which is a Golang library to use this module is needed to install Golang first, please follow the installation instructions here https://golang.org/doc/install for your OS, you can find the Golang installers here https://golang.org/dl/.

Once Golang is installed generate your terraform module under your GOPATH directory (this becomes clear after installing Go)

Generating a new module

```
ironman generate terraform-module:aws name-of-your-module -f variables.yaml
```