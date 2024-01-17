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


trivy image --vuln-type os --format json --ignore-unfixed ghcr.io/philwelz/example:898a37d-o result.json

# Verify

```bash
# General
INDEX_SBOM=64155516
INDEX_IMAGE=64167434
IMAGE=ghcr.io/philwelz/example:2971ef3-patched
SHA=24bb1e31f3f0762ab65f9cd48c01ee7510fb11d1

# Vuln
trivy image --scanners vuln --vuln-type os --ignore-unfixed  --format json ${IMAGE:0:32} -o report.json
cat report.json | jq '.Results[0].Vulnerabilities[] | .PkgID' | sort | uniq
trivy image --scanners vuln --vuln-type os --ignore-unfixed --format json $IMAGE -o patched.json
cat patched.json | jq '.Results[0].Vulnerabilities[] | .PkgID' | sort | uniq
grype $IMAGE --only-fixed 
grype $IMAGE
trivy --scanners vuln --vuln-type os image $IMAGE --report summary
trivy image ${IMAGE:0:32} --report summary

grype ghcr.io/nmeisenzahl/hijack-kubernetes/log4shell-app:latest --only-fixed
trivy image --scanners vuln --ignore-unfixed ghcr.io/nmeisenzahl/hijack-kubernetes/log4shell-app:latest --format json -o log4shell.json
cat log4shell.json | jq '.Results[0].Vulnerabilities[] | .PkgID' | sort | uniq

# View SBOM signing on transparency log
rekor-cli get --rekor_server https://rekor.sigstore.dev --log-index $INDEX_SBOM --format json | jq
# View SBOM with cosign
cosign download attestation $IMAGE | jq -r .payload | base64 -d | jq .
# View SBOM with syft
syft $IMAGE
# no SBOM on unpatched image
syft ${IMAGE:0:32}
# Verify SBOM signing
cosign verify-attestation $IMAGE --type cyclonedx --certificate-identity "https://github.com/philwelz/example-cfp/.github/workflows/sign-image.yaml@refs/heads/main" --certificate-oidc-issuer "https://token.actions.githubusercontent.com" | jq .


# View OCI Image signing on transparency log
rekor-cli get --rekor_server https://rekor.sigstore.dev --log-index $INDEX_IMAGE --format json | jq
# Get image digest
crane digest $IMAGE
crane ls ghcr.io/philwelz/example | head

# Verify signing - short
cosign verify $IMAGE --certificate-identity "https://github.com/philwelz/example-cfp/.github/workflows/sign-image.yaml@refs/heads/main" --certificate-oidc-issuer "https://token.actions.githubusercontent.com" | jq .
# Verify signing - detailed
cosign verify $IMAGE --certificate-identity='https://github.com/philwelz/example-cfp/.github/workflows/sign-image.yaml@refs/heads/main' --certificate-oidc-issuer="https://token.actions.githubusercontent.com" --certificate-github-workflow-name='Action' --certificate-github-workflow-ref='refs/heads/main' --certificate-github-workflow-repository='philwelz/example-cfp'  --certificate-github-workflow-sha=$SHA --certificate-github-workflow-trigger='workflow_dispatch' | jq .
```
