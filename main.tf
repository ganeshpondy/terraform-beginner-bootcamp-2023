terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  # Terraform cloud Setting
  cloud {
   organization = "Terraform_Beginner_Bootcamp_Ganeshpondy"
   workspaces {
     name = "terra-house-1"
   }
  }

}

provider "terratowns" {
  # endpoint = "https://terratowns.cloud/api"
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_arcanum_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.arcanum.public_path
  content_version = var.arcanum.content_version
}


resource "terratowns_home" "home" {
  name = "Chennai 2023!!!!!!!!"
  description = <<DESCRIPTION
Chennai, on the Bay of Bengal, is the capital of the state of Tamil Nadu. 
The city is home to Fort St. George, built in 1644 
when it was called Madras. 
DESCRIPTION
  domain_name = module.home_arcanum_hosting.domain_name
  # domain_name = "3fdq3gz.cloudfront.net"
  # town = "missingo"
  town = "the-nomad-pad"
  content_version = var.arcanum.content_version
}

module "home_karupatti_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.Karupatti.public_path
  content_version = var.Karupatti.content_version
}

resource "terratowns_home" "karupatti" {
  name = "How to Prepare Karupatti Mittai"
  description = <<DESCRIPTION
"Karupatti Mittai" refers to sweets made using "karupatti" or palm jaggery. 
Palm jaggery is a natural sweetener derived from the sap of palm trees and 
is considered healthier than regular jaggery due to its rich mineral content and low glycemic index.

Enjoy your Karupatti Mittai, a traditional and healthy TamilNadu treat (Southern State of India)!

DESCRIPTION
  domain_name = module.home_karupatti_hosting.domain_name
  # domain_name = "3fdq3gz.cloudfront.net"
  # town = "missingo"
  town = "cooker-cove"
  content_version = 1
}
