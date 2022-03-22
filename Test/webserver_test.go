package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformWebserverExample(t *testing.T) {
	// Tehe Values to pass into the Terraform CLI
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		//The path to where the example terraform code is located
		TerraformDir: "../Examples/Webserver",
		//variables to pass to the Terraform code using  -var options
		Vars: map[string]interface{}{
			"region":     "us-east-1",
			"servername": "testwebserver",
		},
	})
	//run a terraform init and apply with the terraform options

	terraform.InitAndApply(t, terraformOptions)

	//run a terraform destroy at the end of the test
	defer terraform.Destroy(t, terraformOptions)
	publicIP := terraform.Output(t, terraformOptions, "public_ip")
	url := fmt.Sprint("http://8080", publicIP)
	http_helper.HttpGetWithRetry(t, url, nil, 200, "I made a terraform module", 30, 5*time.Second)
}
