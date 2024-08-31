#!/bin/bash

# 打印版权信息和免责声明
print_copyright_info() {
    local border="==============================================================="
    local copyright_info="+ 版权信息：本程序由 [XHSecurity] 编写。"
    local github_info="+ 下载地址: https://github.com/XHSecurity"
    local disclaimer_info="+ 免责声明：该程序仅用于学习和研究用途，任何非法用途与作者无关。"

    echo "$border"
    echo "$copyright_info"
    echo "$github_info"
    echo "$disclaimer_info"
    echo "$border"
}

print_copyright_info

# 获取系统类型
case "$(uname -s)" in
    Darwin)
        system_type="Mac"
        ;;
    MINGW* | MSYS* | MINGW64*)
        system_type="Windows"
        ;;
    Linux)
        system_type="Linux"
        ;;
    *)
        system_type="Unknown"
        ;;
esac

# 设置软件版本（根据实际情况进行更新）
software_version="Burp Suite 2024.7.5"  # 替换为实际的版本信息

# 显示系统类型和软件版本
echo "+ 当前系统类型: $system_type"
echo "+ 软件版本信息: $software_version"
echo "==============================================================="

# 提示用户选择语言
while true; do
    echo "请选择语言："
    echo "1 - 英文"
    echo "2 - 中文"
    read -p "请输入选项 (默认英文): " lang_choice

    # 默认选择英文
    lang_choice=${lang_choice:-1}

    if [[ "$lang_choice" -eq 1 || "$lang_choice" -eq 2 ]]; then
        break
    else
        echo "输入无效，请选择 1 或 2。"
    fi
done

# 设置语言变量和启动命令
if [[ "$lang_choice" -eq 2 ]]; then
    msg_no_jar="未找到匹配的 JAR 文件。"
    msg_running="Burp Suite 正在后台运行。日志文件保存在 burpsuite.log 中。"
    start_command="nohup java --illegal-access=permit -Dfile.encoding=utf-8 --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:BurpSuiteChs.jar -javaagent:BurpLoaderKeygen.jar -noverify -jar"
else
    msg_no_jar="No JAR file matching burpsuite_pro_v*.jar found."
    msg_running="Burp Suite is running in the background. Logs are available in burpsuite.log."
    start_command="nohup java -jar BurpLoaderKeygen.jar"
fi

# 查找 JAR 文件
jarfile=""
for file in burpsuite_pro_v*.jar; do
    if [[ -e "$file" ]]; then
        jarfile="$file"
        break
    fi
done

# 检查是否找到 JAR 文件
if [[ -z "$jarfile" && "$lang_choice" -eq 1 ]]; then
    echo "$msg_no_jar"
    exit 1
fi

# 运行 JAR 文件
if [[ "$lang_choice" -eq 2 ]]; then
    # 中文模式，使用查找到的 JAR 文件
    $start_command "$jarfile" > burpsuite.log 2>&1 &
else
    # 英文模式，直接使用 BurpLoaderKeygen.jar 启动
    $start_command > burpsuite.log 2>&1 &
fi

echo "$msg_running"
