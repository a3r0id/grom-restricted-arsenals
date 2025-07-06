import os
import json
from subprocess import run

BUILD_CONFIG = "build.json"

def config():
    class Config(object):
        def __init__(self, config):
            for key in config:
                setattr(self, key, config[key])
    return Config(json.load(open(BUILD_CONFIG)))

CONFIG          = config()
INPUT_ADDONS    = os.path.join(os.getcwd(),"addons")
ADDONS_FOLDER   = os.path.join(os.path.join(os.getcwd(),"Grom Restricted Arsenals"),"Addons")
KEYS_FOLDER     = os.path.join(os.path.join(os.getcwd(),"Grom Restricted Arsenals"),"Keys")

addons_found = os.listdir(INPUT_ADDONS)
if not addons_found:
    print("[!] No addons found in the input directory. Please add addons to the 'addons' folder.")
    exit(1)

print("[+] Found addons: " + str(addons_found))

for folder in addons_found:

    addon_path = os.path.join(INPUT_ADDONS, folder)
    if not os.path.isdir(addon_path):
        print (f"[!] Skipping {folder} as it is not a directory.")
        continue

    prefix = None
    pbp_prefix_path = os.path.join(addon_path, "$PBOPREFIX$")
    if not os.path.exists(pbp_prefix_path):
        print (f"[!] Skipping {folder} as it does not contain a $PBOPREFIX$ file.")
        continue

    with open(pbp_prefix_path, "r") as f:
        prefix = f.read().strip()

    print (f"[+] [**Building addon: {addon_path} with prefix: {prefix}**]\n==========================================================================")

    # Pack the addon
    run([
        CONFIG.ADDON_BUILDER_PATH,
        addon_path,
        ADDONS_FOLDER,
        "-packonly",
        "-prefix=" + prefix,
        "-sign=" + CONFIG.PRIVATE_KEY_PATH
    ], check=True)

print ("[+] Done")