import hid
import sys

COMMANDS = {
    "b25": "06060c012f000312010000000000000000000000000000000000000000000000",
    "b50": "06060b013e000322010000000000000000000000000000000000000000000000",
    "b75": "06060a014d000332010000000000000000000000000000000000000000000000",
    "b100": "060609015c000342010000000000000000000000000000000000000000000000",
    "br1": "0606020153000241010000000000000000000000000000000000000000000000",
    "br2": "0606170169000242010000000000000000000000000000000000000000000000",
    "br3": "0606030156000243010000000000000000000000000000000000000000000000",
    "off": "0606180168000042010000000000000000000000000000000000000000000000",
}


def main():
    if len(sys.argv) < 2 or sys.argv[1] not in COMMANDS:
        print("使用方法: kzzi-light <指令>")
        print("可选指令: b25, b50, b75, b100, br1, br2, br3, off")
        sys.exit(1)

    cmd = sys.argv[1]
    data = bytes.fromhex(COMMANDS[cmd])

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
            except Exception:
                continue

    if not found:
        print("❌ 错误: 未能定位到鼠标控制接口", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
