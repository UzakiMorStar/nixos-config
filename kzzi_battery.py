import sys
import hid

VENDOR_ID = 0x04f3
PRODUCT_IDS = [0x026f, 0x026e]

target_dev = hid.device()
device_opened = False

for pid in PRODUCT_IDS:
    for dev_info in hid.enumerate(VENDOR_ID, pid):
        if dev_info['interface_number'] == 1:
            try:
                target_dev.open_path(dev_info['path'])
                device_opened = True
                break
            except Exception:
                pass
    if device_opened:
        break

if not device_opened:
    print("离线")
    sys.exit(1)

try:
    data = target_dev.read(32, 6000)
    # 将过长的条件语句拆行以符合 PEP 8
    if (data and len(data) >= 5 and
            data[0] == 0x04 and data[1] == 0x01 and data[2] == 0x02):
        print(f"{data[4]}%")
    else:
        print("离线")
except Exception:
    print("错误")
finally:
    target_dev.close()
