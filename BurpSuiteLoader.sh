#!/bin/bash
for jarfile in burpsuite_pro_v*.jar; do
    if [[ -e "$jarfile" ]]; then
        break
    fi
done

nohup java --illegal-access=permit -Dfile.encoding=utf-8 --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:BurpSuiteChs.jar -javaagent:BurpLoaderKeygen.jar -noverify -jar "$jarfile" >/dev/null 2>&1&