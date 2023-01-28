from os import getcwd, mkdir
from subprocess import run
from os.path import join
import json
import shutil
import glob

BUILD_CONFIG = "build.json"

def config():
    class Config(object):
        def __init__(self, config):
            for key in config:
                setattr(self, key, config[key])
    return Config(json.load(open(BUILD_CONFIG)))

CONFIG          = config()
BUILD_FOLDER    = join(getcwd(),"tmp")
ADDONS_FOLDER   = join(join(getcwd(),"Grom Restricted Arsenals"),"Addons")
KEYS_FOLDER     = join(join(getcwd(),"Grom Restricted Arsenals"),"Keys")

# Clear/Build the temp structure
print ("\r\n[+] Rebuilding BUILD_FOLDER folder...")
mkdir(BUILD_FOLDER)

print ("[+] Copying project to BUILD_FOLDER folder...")
shutil.copytree(join(getcwd(),"functions"), join(BUILD_FOLDER,"functions"))
shutil.copytree(join(getcwd(),"data"), join(BUILD_FOLDER,"data"))
shutil.copy(join(getcwd(),"config.cpp"), BUILD_FOLDER)
shutil.copy(join(getcwd(),"$PBOPREFIX$"), BUILD_FOLDER)

# all files that end with ".hpp"
for file in glob.glob("*.hpp"):
    shutil.copy(file, BUILD_FOLDER)

print ("[+] Copy completed!")

print ("[+] [**Packing addon**]\n==========================================================================")

# Pack the addon
run([
    CONFIG.ADDON_BUILDER_PATH,
    BUILD_FOLDER,
    ADDONS_FOLDER,
    "-packonly",
    "-prefix=GRRA",
    "-sign=" + CONFIG.PRIVATE_KEY_PATH
], check=True)

# Clean up
print ("==========================================================================\n[+] Cleaning up")
shutil.rmtree(BUILD_FOLDER)
print ("[+] Done")