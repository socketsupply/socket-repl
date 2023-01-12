#!/usr/bin/env bash

export PATH+=":$(pwd)/node_modules/.bin"

function main () {
  local socket_sources=("${SOCKET_REPL_ADDITIONAL_SOURCES[@]}" src/index.js)
  local node_sources=(src/ipc.js)
  local copy_sources=(
    src/package.json
    src/index.html
    src/icon.png
    LICENSE
  )

  local esbuild_flags=(
    --tree-shaking=true
    --keep-names
    --bundle
  )

  local target="$1"

  if [[ " $* " =~ " --debug=1 " ]]; then
    esbuild_flags+=(
      --sourcemap=inline
      --log-level=warning
      --log-limit=0
    )
  else
    esbuild_flags+=(
      --log-level=error
    )
  fi

  cp -f "${copy_sources[@]}" "$target" || return $?

  ## Build Socket runtime sources
  for file in "${socket_sources[@]}"; do
    if ! [ -f "$file" ]; then continue; fi
    local outfile="$target/$(basename "$file")"
    esbuild "$file" "${esbuild_flags[@]}" --outfile="$outfile" || return $?
  done

  ## Build Node runtime sources
  esbuild_flags+=(--platform=node)
  for file in "${node_sources[@]}"; do
    local basename="$(basename "$file")"
    local tmpfile="$target/$basename"
    local outfile="$target/socket-repl-${basename/.js/}"

    esbuild "$file" "${esbuild_flags[@]}" --outfile="$tmpfile" || return $?

    if [[ " $* " =~ " --debug=1 " ]]; then
      pkg -t node16 "$tmpfile" -o "$outfile" || return $?
    else
      pkg -t node16 "$tmpfile" --compress GZip -o "$outfile" >/dev/null || return $?
    fi

    rm -f "$tmpfile" || return $?
  done

  return 0
}

main "$@"
exit $?
