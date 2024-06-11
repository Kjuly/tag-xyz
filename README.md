# Tag XYZ
Create a new tag (x.y.z) based on the last one, and dispatch a relevant workflow if needed.

## Usage

```yaml
on:
  workflow_dispatch:

  schedule:
    - cron: "0 12 * * 2"

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
