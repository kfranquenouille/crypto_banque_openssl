#!/bin/bash

sed -n 1,5p | openssl rsautl -decrypt -inkey banque/bankpublic.key -pubin | base64 -d
