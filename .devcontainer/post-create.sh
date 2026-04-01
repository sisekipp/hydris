#!/usr/bin/env bash
set -euo pipefail

export GOBIN="${GOBIN:-$HOME/go/bin}"
export PATH="$GOBIN:$HOME/.local/bin:$PATH"

mkdir -p "$GOBIN" "$HOME/.local/bin"

echo "Installing Go-based developer tools..."
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
go install connectrpc.com/connect/cmd/protoc-gen-connect-go@latest
go install github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@latest
go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest
go install golang.org/x/vuln/cmd/govulncheck@latest

if ! command -v golangci-lint >/dev/null 2>&1; then
  curl -fsSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh \
    | sh -s -- -b "$GOBIN"
fi

echo "Downloading Go modules..."
go mod download

if [ -f desktop/go.mod ]; then
  (cd desktop && go mod download)
fi

if [ -f android/go.mod ]; then
  (cd android && go mod download)
fi

if [ -d view/frontend ]; then
  echo "Installing frontend dependencies..."
  (cd view/frontend && bun install)
fi

if [ -f /workspaces/proto/world.proto ]; then
  echo "Found sibling proto repository at /workspaces/proto."
else
  echo "Note: /workspaces/proto/world.proto was not found."
  echo "Clone the external proto repository next to hydris on the host if you need local proto sources."
fi
