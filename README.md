grpc-lite
=========
this zero-dependency package will download and install grpc v1.0.1 prebuilt-binaries from https://github.com/kaizhu256/node-grpc-lite

[![travis-ci.org build-status](https://api.travis-ci.org/kaizhu256/node-grpc-lite.svg)](https://travis-ci.org/kaizhu256/node-grpc-lite)

[![NPM](https://nodei.co/npm/grpc-lite.png?downloads=true)](https://www.npmjs.com/package/grpc-lite)

[![package-listing](https://kaizhu256.github.io/node-grpc-lite/build/screen-capture.gitLsTree.svg)](https://github.com/kaizhu256/node-grpc-lite)



# documentation
#### api-doc
- [https://kaizhu256.github.io/node-grpc-lite/build..beta..travis-ci.org/doc.api.html](https://kaizhu256.github.io/node-grpc-lite/build..beta..travis-ci.org/doc.api.html)

[![api-doc](https://kaizhu256.github.io/node-grpc-lite/build..beta..travis-ci.org/screen-capture.docApiCreate.browser._2Fhome_2Ftravis_2Fbuild_2Fkaizhu256_2Fnode-grpc-lite_2Ftmp_2Fbuild_2Fdoc.api.html.png)](https://kaizhu256.github.io/node-grpc-lite/build..beta..travis-ci.org/doc.api.html)

#### todo
- upgrade to grpc v1.1.x when stable
- none

#### change since 6410d933
- npm publish 2016.12.2
- streamline static-dependencies
- add file busybox
- none

#### this package requires
- darwin or linux os

#### additional info
- currently both this package (and standard node-grpc package) does not support node v7.0.0 or higher (https://github.com/grpc/grpc/issues/8649)
- includes external linux busybox binary from https://busybox.net/downloads/binaries/1.21.1/busybox-i486



# build-status [![travis-ci.org build-status](https://api.travis-ci.org/kaizhu256/node-grpc-lite.svg)](https://travis-ci.org/kaizhu256/node-grpc-lite)
[![build commit status](https://kaizhu256.github.io/node-grpc-lite/build/build.badge.svg)](https://travis-ci.org/kaizhu256/node-grpc-lite)

| git-branch : | [master](https://github.com/kaizhu256/node-grpc-lite/tree/master) | [beta](https://github.com/kaizhu256/node-grpc-lite/tree/beta) | [alpha](https://github.com/kaizhu256/node-grpc-lite/tree/alpha)|
|--:|:--|:--|:--|
| test-report : | [![test-report](https://kaizhu256.github.io/node-grpc-lite/build..master..travis-ci.org/test-report.badge.svg)](https://kaizhu256.github.io/node-grpc-lite/build..master..travis-ci.org/test-report.html) | [![test-report](https://kaizhu256.github.io/node-grpc-lite/build..beta..travis-ci.org/test-report.badge.svg)](https://kaizhu256.github.io/node-grpc-lite/build..beta..travis-ci.org/test-report.html) | [![test-report](https://kaizhu256.github.io/node-grpc-lite/build..alpha..travis-ci.org/test-report.badge.svg)](https://kaizhu256.github.io/node-grpc-lite/build..alpha..travis-ci.org/test-report.html)|
| coverage : | [![istanbul coverage](https://kaizhu256.github.io/node-grpc-lite/build..master..travis-ci.org/coverage.badge.svg)](https://kaizhu256.github.io/node-grpc-lite/build..master..travis-ci.org/coverage.html/index.html) | [![istanbul coverage](https://kaizhu256.github.io/node-grpc-lite/build..beta..travis-ci.org/coverage.badge.svg)](https://kaizhu256.github.io/node-grpc-lite/build..beta..travis-ci.org/coverage.html/index.html) | [![istanbul coverage](https://kaizhu256.github.io/node-grpc-lite/build..alpha..travis-ci.org/coverage.badge.svg)](https://kaizhu256.github.io/node-grpc-lite/build..alpha..travis-ci.org/coverage.html/index.html)|
| build-artifacts : | [![build-artifacts](https://kaizhu256.github.io/node-grpc-lite/glyphicons_144_folder_open.png)](https://github.com/kaizhu256/node-grpc-lite/tree/gh-pages/build..master..travis-ci.org) | [![build-artifacts](https://kaizhu256.github.io/node-grpc-lite/glyphicons_144_folder_open.png)](https://github.com/kaizhu256/node-grpc-lite/tree/gh-pages/build..beta..travis-ci.org) | [![build-artifacts](https://kaizhu256.github.io/node-grpc-lite/glyphicons_144_folder_open.png)](https://github.com/kaizhu256/node-grpc-lite/tree/gh-pages/build..alpha..travis-ci.org)|

#### master branch
- stable branch
- HEAD should be tagged, npm-published package

#### beta branch
- semi-stable branch
- HEAD should be latest, npm-published package

#### alpha branch
- unstable branch
- HEAD is arbitrary
- commit history may be rewritten



# package.json
```json
{
    "package.json": true,
    "author": "kai zhu <kaizhu256@gmail.com>",
    "description": "{{packageJson.description}}",
    "devDependencies": {
        "electron-lite": "kaizhu256/node-electron-lite#alpha",
        "n": "*",
        "utility2": "kaizhu256/node-utility2#alpha"
    },
    "engines": { "node": ">=4 <7" },
    "keywords": [
        "api",
        "grpc",
        "light", "lightweight", "lite",
        "protobuf"
    ],
    "license": "MIT",
    "main": "lib.grpc",
    "name": "grpc-lite",
    "os": ["darwin", "linux"],
    "repository": {
        "type": "git",
        "url": "https://github.com/kaizhu256/node-grpc-lite.git"
    },
    "scripts": {
        "build-ci": "utility2 shRun shReadmeBuild",
        "postinstall": "./lib.grpc.sh shNpmPostinstall",
        "test": "\
rm -fr external /tmp/grpc_node-* && \
npm run postinstall && \
export PORT=$(utility2 shServerPortRandom) && utility2 test test.js"
    },
    "version": "2016.12.2"
}
```



# changelog of last 50 commits
[![screen-capture](https://kaizhu256.github.io/node-grpc-lite/build/screen-capture.gitLog.svg)](https://github.com/kaizhu256/node-grpc-lite/commits)



# internal build-script
- build.sh
```shell
# build.sh

# this shell script will run the build for this package

shBuildCiTestPre() {(set -e
# this function will run the pre-test build
    # test published-package
    (export MODE_BUILD=npmTestPublished &&
        shRunScreenCapture shNpmTestPublished) || return $?
    return
)}

shBuild() {(set -e
# this function will run the main build
    # init env
    . node_modules/.bin/utility2 && shInit
    # cleanup github-gh-pages dir
    # export BUILD_GITHUB_UPLOAD_PRE_SH="rm -fr build"
    # init github-gh-pages commit-limit
    export COMMIT_LIMIT=16
    # if branch is alpha, beta, or master, then run default build
    if [ "$CI_BRANCH" = alpha ] ||
        [ "$CI_BRANCH" = beta ] ||
        [ "$CI_BRANCH" = master ]
    then
        shBuildCiDefault
        # upload build-artifacts to github, and if number of commits > $COMMIT_LIMIT,
        # then squash older commits
        (export MODE_BUILD=buildGithubUpload &&
            shBuildGithubUpload) || return $?
    fi
)}
shBuild
```



# original README.md
[![npm](https://img.shields.io/npm/v/grpc.svg)](https://www.npmjs.com/package/grpc)
# Node.js gRPC Library

## PREREQUISITES
- `node`: This requires `node` to be installed, version `0.12` or above. If you instead have the `nodejs` executable on Debian, you should install the [`nodejs-legacy`](https://packages.debian.org/sid/nodejs-legacy) package.

- **Note:** If you installed `node` via a package manager and the version is still less than `0.12`, try directly installing it from [nodejs.org](https://nodejs.org).

## INSTALLATION

Install the gRPC NPM package

```sh
npm install grpc
```

## BUILD FROM SOURCE
 1. Clone [the grpc Git Repository](https://github.com/grpc/grpc).
 2. Run `npm install` from the repository root.

 - **Note:** On Windows, this might fail due to [nodejs issue #4932](https://github.com/nodejs/node/issues/4932) in which case, you will see something like the following in `npm install`'s output (towards the very beginning):

    ```
     ..
     Building the projects in this solution one at a time. To enable parallel build, please add the "/m" switch.
     WINDOWS_BUILD_WARNING
      "..\IMPORTANT: Due to https:\github.com\nodejs\node\issues\4932, to build this library on Windows, you must first remove C:\Users\jenkins\.node-gyp\4.4.0\include\node\openssl"
      ...
      ..
    ```

    To fix this, you will have to delete the folder `C:\Users\<username>\.node-gyp\<node_version>\include\node\openssl` and retry `npm install`


## TESTING
To run the test suite, simply run `npm test` in the install location.

## API
This library internally uses [ProtoBuf.js](https://github.com/dcodeIO/ProtoBuf.js), and some structures it exports match those exported by that library

If you require this module, you will get an object with the following members

```javascript
function load(filename)
```

Takes a filename of a [Protocol Buffer](https://developers.google.com/protocol-buffers/) file, and returns an object representing the structure of the protocol buffer in the following way:

 - Namespaces become maps from the names of their direct members to those member objects
 - Service definitions become client constructors for clients for that service. They also have a `service` member that can be used for constructing servers.
 - Message definitions become Message constructors like those that ProtoBuf.js would create
 - Enum definitions become Enum objects like those that ProtoBuf.js would create
 - Anything else becomes the relevant reflection object that ProtoBuf.js would create


```javascript
function loadObject(reflectionObject)
```

Returns the same structure that `load` returns, but takes a reflection object from `ProtoBuf.js` instead of a file name.

```javascript
function Server([serverOpions])
```

Constructs a server to which service/implementation pairs can be added.


```javascript
status
```

An object mapping status names to status code numbers.


```javascript
callError
```

An object mapping call error names to codes. This is primarily useful for tracking down certain kinds of internal errors.


```javascript
Credentials
```

An object with factory methods for creating credential objects for clients.


```javascript
ServerCredentials
```

An object with factory methods for creating credential objects for servers.
