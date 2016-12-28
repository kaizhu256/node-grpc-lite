grpc-lite
=========
this zero-dependency package will download and install grpc v1.0.1 prebuilt-binaries from https://github.com/kaizhu256/node-grpc-lite

[![travis-ci.org build-status](https://api.travis-ci.org/kaizhu256/node-grpc-lite.svg)](https://travis-ci.org/kaizhu256/node-grpc-lite)

[![NPM](https://nodei.co/npm/grpc-lite.png?downloads=true)](https://www.npmjs.com/package/grpc-lite)

[![package-listing](https://kaizhu256.github.io/node-grpc-lite/build/screen-capture.gitLsTree.svg)](https://github.com/kaizhu256/node-grpc-lite)



# documentation
#### todo
- upgrade to grpc v1.1.x when stable
- none

#### change since 9fe8c225
- npm publish 2016.12.1
- none

#### this package requires
- darwin or linux os

#### additional info
- includes external linux unzip binary from https://busybox.net/downloads/binaries/1.21.1/busybox-i486



# build-status [![travis-ci.org build-status](https://api.travis-ci.org/kaizhu256/node-grpc-lite.svg)](https://travis-ci.org/kaizhu256/node-grpc-lite)
[![build commit status](https://kaizhu256.github.io/node-grpc-lite/build/build.badge.svg)](https://travis-ci.org/kaizhu256/node-grpc-lite)

| git-branch : | [master](https://github.com/kaizhu256/node-grpc-lite/tree/master) | [beta](https://github.com/kaizhu256/node-grpc-lite/tree/beta) | [alpha](https://github.com/kaizhu256/node-grpc-lite/tree/alpha)|
|--:|:--|:--|:--|
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
rm -fr external && \
npm run postinstall && \
utility2 test test.js"
    },
    "version": "2016.12.1"
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
