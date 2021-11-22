# build-security-action
GitHub Action for Aqua Build Security

## Usage

Add the below workflow into your existing build or as a new workflow.

```yaml
name: build
on:
  push:
    branches:
      - master
  pull_request:

jobs:
  build:
    name: Build
    runs-on: ubuntu-18.04
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Run Aqua Build Security
        uses: aquasecurity/build-security-action@main
        with:
          aqua_key: ${ secret.AQUA_KEY }
          aqua_secret: ${ secret.AQUA_SECRET }


```

### What does it do?

The workflow is going to checkout the PR or branch as appropriate then run the Aqua Build Security Trivy command against it and upload the results.

### Required Parameters

There are two required parameters, these can be grabbed from CSPM. You'll need you `AQUA_KEY` and `AQUA_SECRET`, please contact Aqua Support if you have issues getting these.

