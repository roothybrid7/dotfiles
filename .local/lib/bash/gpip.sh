#!/bin/bash

# Use a global packages in site.USER_SITE
# see: https://hackercodex.com/guide/python-development-environment-on-mac-osx/
gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
