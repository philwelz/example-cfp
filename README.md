docker buildx build --platform linux/arm64 ./example -t test:fred

docker run -dp 8080:8080 test:fred

trivy image --vuln-type os test:fred-arm64 

trivy image --ignore-unfixed test:fred-arm64

trivy fs --scanners vuln,config,secret --severity HIGH,CRITICAL ./example

trivy image --scanners misconfig test:fred-arm64



# Copa

trivy image --ignore-unfixed copa:test -o result.json

copa patch -i ghcr.io/whiteducksoftware/sample-mvc:fred-kube -r kube-fred.json -t kube-fred-patched2



trivy image ghcr.io/philwelz/example:edebc76e75bede5d363b83056af6cf2cb9896a4d

trivy image ghcr.io/philwelz/example:patched



$ cosign verify-attestation --key /path/to/cosign.pub --type cyclonedx <IMAGE> > sbom.cdx.intoto.jsonl
$ trivy sbom ./sbom.cdx.intoto.jsonl

# SBOM
trivy image ghcr.io/philwelz/example:898a37d-patched  --ignore-unfixed
trivy image ghcr.io/philwelz/example:898a37d --ignore-unfixed 

syft ghcr.io/philwelz/example:898a37d-patched
syft ghcr.io/philwelz/example:898a37d 

grype ghcr.io/philwelz/example:898a37d-patched  --scope all-layers --only-fixed
grype ghcr.io/philwelz/example:898a37d  --scope all-layers --only-fixed

trivy image ghcr.io/philwelz/example:898a37d-patched

# URL

- https://project-copacetic.github.io/copacetic/website/github-action
- https://aquasecurity.github.io/trivy/v0.37/docs/attestation/sbom/


trivy image --ignore-unfixed ghcr.io/philwelz/example:898a37d-o result.json

# Verify

```bash


cosign verify-attestation ghcr.io/philwelz/example:2ec37e9-patched
cosign verify-attestation sha256-fe3b8987ff01c5ab6d979b5e18c30591ad2ace3515699b2e67c51581a411a009.att

#View SBOM
IMAGE=ghcr.io/philwelz/example:2ec37e9-patched
syft $IMAGE
INDEX=64155516 && rekor-cli get --rekor_server https://rekor.sigstore.dev --log-index $INDEX --format json | jq
crane digest $IMAGE
crane ls ghcr.io/philwelz/example | head

```