# Tag XYZ
Create a new tag (x.y.z) based on the last one, and dispatch a relevant workflow if needed.

## Usage

```yaml
on:
  workflow_dispatch:

  schedule:
    - cron: "0 12 * * 2"

# See the "Workflow Permissions" section below for details.
permissions:
  contents: write
  actions: write

jobs:
  create-tag:
    runs-on: ubuntu-latest
    steps:
      - name: Create Tag for New Version
        uses: kjuly/tag-xyz@main
        with:
          version_level: "z"
          dispatch_workflow_id: "a_tag_trigged_workflow.yml"
```

## Optional Inputs

| Input | Default | Description
| :--- | :--- | :---
| version_level | 'z' | The version level of 'x.y.z'.
| dispatch_workflow_id | '' | ID of the workflow to dispatch, e.g., 'test_workflow.yml'.

## Workflow Permissions

Permissions setting is only needed if your repo has restricted permissions on the `GITHUB_TOKEN`.

In order to create a tag reference, we need the write permissions on `contents` & `actions`. Otherwise, we'll get a "Resource not accessible by integration" error when creating a tag ref using `github.rest.git.createRef` from `actions/github-script`.

You can confirm your repo's workflow permissions in

> Settings > Code and automation > Actions > General > Workflow permissions

It's "Read repository contents and packages permissions" by default. If it's "Read and write permissions", you can just remove the `permissions` setting in YAML file.

Further reading:  
- [Modifying the permissions for the GITHUB_TOKEN](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#modifying-the-permissions-for-the-github_token)  
- [Create a reference](https://docs.github.com/en/rest/git/refs?apiVersion=2022-11-28#create-a-reference)  
