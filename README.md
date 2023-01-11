socket-repl
===========

> A JavaScript REPL interface for the [Socket Runtime](https://github.com/socketsupply/socket)

## Installation

```sh
$ npm install @socketsupply/socket-repl -g
```

## Usage

```sh
$ socket-repl
• Welcome to the Socket Runtime (v0.1.0) REPL
# fs.readdir('.', console.log)
undefined
# null [
  'Credits.html',
  'LICENSE',
  'hello.js',
  'index.html',
  'index.js',
  'ipc.js',
  'package.json'
]
# await fs.promises.stat('index.html')
Stats {
  dev: 16777231,
  ino: 19386470,
  mode: 33188,
  nlink: 1,
  uid: 501,
  gid: 20,
  rdev: 0,
  size: 234,
  blksize: 4096,
  blocks: 8,
  atimeMs: 1673455392871.706,
  mtimeMs: 1673455392533.3103,
  ctimeMs: 1673455392533.3103,
  birthtimeMs: 1673454522331.999,
  atime: Date {Wed, 11 Jan 2023 16:43:12 GMT},
  mtime: Date {Wed, 11 Jan 2023 16:43:12 GMT},
  ctime: Date {Wed, 11 Jan 2023 16:43:12 GMT},
  birthtime: Date {Wed, 11 Jan 2023 16:28:42 GMT}
}
# const div = document.createElement('div')
HTMLDivElement {}
# document.body.appendChild(div)
HTMLDivElement {}
# div.innerHTML = 'hello'
hello
# document.body.innerHTML
<div>hello</div>
```

## License

Apache-2.0
