package terraform

import (
	_ "github.com/terraform-docs/terraform-docs"
)

//go:generate go run github.com/terraform-docs/terraform-docs markdown --output-file README.md --recursive --recursive-path ./ ./
