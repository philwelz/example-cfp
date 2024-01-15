docker buildx build --platform linux/arm64 ./example -t test:fred

docker run -dp 8080:8080 test:fred

trivy image --vuln-type os test:fred-arm64 

trivy image --ignore-unfixed test:fred-arm64

trivy fs --scanners vuln,config,secret --severity HIGH,CRITICAL ./example

trivy image --scanners misconfig test:fred-arm64



# Copa

trivy image --ignore-unfixed copa:test -o result.json

copa patch -i ghcr.io/whiteducksoftware/sample-mvc:fred-kube -r kube-fred.json -t kube-fred-patched2
