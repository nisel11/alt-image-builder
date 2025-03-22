# ALT Image Builder

### Action for building images with hasher and mkimage
#### It's using [ALT-Builder](https://github.com/nisel11/alt-builder) container
#### Example workflow:
```
name: Build image

on:
  workflow_dispatch:
    inputs:
      image:
        description: 'Image to build'
        required: true
        default: 'regular-gnome-atomic.iso'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Build image
        uses: nisel11/alt-image-builder@1.1.0
        with:
          image: ${{ github.event.inputs.image }}

```
