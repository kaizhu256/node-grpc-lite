#!/bin/sh

shNpmPostinstall() {(set -e
# this function will run npm postinstall
    export PATH="$(pwd):$PATH"
    VERSION=1.0.1
    SUB_VERSION=$(node -e "process.stdout.write(
        'node-v' + process.versions.modules + '-' + process.platform + '-' + process.arch
    );")
    FILE_BASE="grpc_node-v$VERSION-$SUB_VERSION.node"
    FILE_URL="https://storage.googleapis.com/grpc-precompiled-binaries\
/node/grpc/v$VERSION/$SUB_VERSION.tar.gz"
    case "$(uname)" in
    Darwin)
        # init busybox
        alias tar="busybox tar"
        ;;
    esac
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
                mkdir -p "$FILE_TMP.dir"
                # untar file
                if (tar -C "$FILE_TMP.dir" -xzf "$FILE_TMP" 2>/dev/null)
                then
                    cp "$FILE_TMP.dir/extension_binary/grpc_node.node" "$FILE_TMP"
                fi
            fi
            # mv file to prevent race-condition
            mv "$FILE_TMP" "/tmp/$FILE_BASE" 2>/dev/null || true
        fi
        # default to npm-install
        if [ ! -f "/tmp/$FILE_BASE" ]
        then
            printf "prebuilt-binary $FILE_URL does not exist.\n"
            printf "falling back to source compile with node-gyp ...\n"
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
