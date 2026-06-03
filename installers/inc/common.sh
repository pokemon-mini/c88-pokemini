#!/bin/bash

remove_config() {
	grep --invert-match "^$1=" ../config.sh > ../tmp
	mv ../tmp ../config.sh
}
