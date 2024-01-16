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

# URL

https://aquasecurity.github.io/trivy/v0.37/docs/attestation/sbom/