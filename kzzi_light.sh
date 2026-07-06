#!/usr/bin/env bash

CMD_KEY=${1:-}

case "$CMD_KEY" in
  b25) HEX="06060c012f000312010000000000000000000000000000000000000000000000" ;;
  b50) HEX="06060b013e000322010000000000000000000000000000000000000000000000" ;;
  b75) HEX="06060a014d000332010000000000000000000000000000000000000000000000" ;;
  b100) HEX="060609015c000342010000000000000000000000000000000000000000000000" ;;
  br1) HEX="0606020153000241010000000000000000000000000000000000000000000000" ;;
  br2) HEX="0606170169000242010000000000000000000000000000000000000000000000" ;;
  br3) HEX="0606030156000243010000000000000000000000000000000000000000000000" ;;
  off) HEX="0606180168000042010000000000000000000000000000000000000000000000" ;;
  *)
    echo "使用方法: kzzi_light <指令>"
    echo "可选指令: b25, b50, b75, b100, br1, br2, br3, off"
    exit 1
    ;;
esac

python3 << EOF
import hid
import sys

data = bytes.fromhex('$HEX')

found = False
for dev in hid.enumerate(0x04f3):
    if dev['interface_number'] == 1:
        try:
            d = hid.device()
            d.open_path(dev['path'])
            d.send_feature_report(list(data))
            d.close()
            found = True
            break
        except Exception as e:
            continue

if not found:
    print("❌ 错误: 未能定位到鼠标控制接口", file=sys.stderr)
    sys.exit(1)
EOF
