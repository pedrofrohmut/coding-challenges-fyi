#!/usr/bin/env bash

dune build && dune exec json_parser -- "{\"key\":\"value\"}"
