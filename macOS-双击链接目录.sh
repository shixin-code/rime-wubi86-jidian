#!/bin/sh

cd -- "$(dirname "$BASH_SOURCE")"

RIME_HOME_DIR=~/Library/Rime

function show_menu() {

  if [[ $PWD = $RIME_HOME_DIR ]]
  then
      echo "================================================"
      green "您正确安放相关配置文件到 ${RIME_HOME_DIR} 目录, "
      green "无需再次运行该脚本，已自动退出脚本"
      echo "================================================"
      exit 1
  else
      echo "================================================"
      echo "  是否用当前文件夹内容覆盖 \033[31m${RIME_HOME_DIR}\033[0m 目录？"
      echo "================================================"
  fi
}

function red() {
  echo "\033[31m${1}\033[0m"
}

function green() {
  echo "\033[32m${1}\033[0m"
}

# 参数1: 成功与否$0
# 参数2: 文件名
function echo_result() {
  if [ $1 -eq 0 ]; then
    green "-----------------------------------------------------"
    green "  ${2}\t\t【 成功 】 "
    green "  1. 之前的 Rime 文件夹已经备份到桌面，自行选择删除或保留"
    green "  2. 点击状态栏图标，执行「 布署 」即可使用鼠须管输入法"
    green "  3. 欢迎使用 Rime"
    green "-----------------------------------------------------"

  else
    red "${2}\t\t 【 失败 】"
    echo "请手动移动文件到 ${RIME_HOME_DIR} 文件夹，再点击状态栏图标，执行布署即可"
  fi
}

show_menu

echo "  请选择 \033[32my: 执行\033[0m  \033[31mn: 取消\033[0m: \c"
read choice

case $choice in
y)
  if [ -d "${RIME_HOME_DIR}" ];then # 如果存在 Library/Rime 目录
    cp -Rf ${RIME_HOME_DIR}  ~/Desktop/备份的\ Rime\ 文件夹 &&
    rm -Rf ${RIME_HOME_DIR}
  fi
  ln -s $PWD $RIME_HOME_DIR

  echo_result $? "创建软链接 $RIME_HOME_DIR --> $PWD"
  ;;
n)
  echo "================================================"
  green "已取消操作"
  exit
  ;;

esac
