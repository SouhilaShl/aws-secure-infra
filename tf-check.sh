#!/bin/bash

set -euo pipefail  

echo "Formatting.."
terraform fmt
echo "validating.."
terraform validate 
echo "planning.."
terraform plan 
