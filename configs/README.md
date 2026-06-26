# Bootstrap configuration examples

This directory contains safe bootstrap configuration examples only. The examples are intended to document the expected shape of startup configuration without including real infrastructure details.

Use these files as templates for local testing or deployment-specific configuration, and keep private values outside of the repository.

The examples must not contain:

- real server hostnames or IP addresses;
- private keys, tokens, passwords, or certificates;
- VLESS URIs or production proxy links;
- runtime-generated configuration files.

Create environment-specific configuration outside this directory, or provide it through your deployment tooling.
