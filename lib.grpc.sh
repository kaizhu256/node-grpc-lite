#!/bin/sh

shNpmPostinstall() {(set -e
# this function will run npm postinstall
    VERSION=1.0.1
    SUB_VERSION=$(node -e "process.stdout.write(
        'abi' + process.versions.modules + '-' + process.platform + '-' + process.arch
    );")
    FILE_BASE="grpc_node-v$VERSION-$SUB_VERSION.node"
    FILE_URL=https://github.com/kaizhu256/node-grpc-lite/raw/binary-v$VERSION/$FILE_BASE
    if [ ! -f "external/$FILE_BASE" ]
    then
        if [ ! -f "/tmp/$FILE_BASE" ]
        then
            FILE_TMP="$(mktemp "/tmp/$FILE_BASE.XXXXXXXX")"
            # copy cached file
            if [ -f "/$FILE_BASE" ]
            then
                cp "/$FILE_BASE" "$FILE_TMP"
            # download file
            else
                printf "downloading $FILE_URL to /tmp/$FILE_BASE ...\n"
                curl -#L -o "$FILE_TMP" "$FILE_URL"
            fi
            # handle race-condition
            mv "$FILE_TMP" "/tmp/$FILE_BASE" 2>/dev/null || true
        fi
        # check file-size
        case "$(uname)" in
        Darwin)
            FILE_SIZE=$(stat -f%z "/tmp/$FILE_BASE")
            ;;
        *)
            FILE_SIZE=$(stat --printf="%s" "/tmp/$FILE_BASE")
            ;;
        esac
        # default to npm-install
        if [ "$FILE_SIZE" -le 500000 ]
        then
            printf "could not find prebuilt-binary for current node abi-version $SUB_VERSION\n"
            printf "defaulting to npm-install ...\n"
            (rm -fr /tmp/$FILE_BASE.dir &&
                mkdir -p /tmp/$FILE_BASE.dir &&
                cd /tmp/$FILE_BASE.dir &&
                npm install "grpc@$VERSION" &&
                cp node_modules/grpc/src/node/extension_binary/grpc_node.node "/tmp/$FILE_BASE")
        fi
        # install file
        mkdir -p external
        cp "/tmp/$FILE_BASE" external
    fi
    for DIR in .bin electron-lite n utility2
    do
        (if [ -d node_modules/$DIR ] && [ ! -d $DIR ]; then mv node_modules/$DIR .; fi)
    done
    rm -fr node_modules && ln -s . node_modules
)}

# run command
"$@"
