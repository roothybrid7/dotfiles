#!/bin/bash

# Use a global packages in site.USER_SITE
gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
