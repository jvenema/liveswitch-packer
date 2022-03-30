# Configure

### Set environment variables
Create a variables.json in the root. Add your digitalocean token to it like this:

```json
{
    "my_token":"dop_v1_xxxxx"
}
```

### Add the docker compose files (and systemd configuration)
`git clone https://github.com/jvenema/liveswitch-docker-compose.git`

TODO: make this a submodule so we can do a one-shot checkout?

# Verify
`packer verify -var-file=variables.json template.json`

# Build a new image
`packer build -var-file=variables.json template.json`