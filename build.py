from os import getcwd, mkdir
from subprocess import run
from os.path import join
import shutil
import glob

ADDON_BUILDER = "X:\\Storage\\Steam\\steamapps\\common\\Arma 3 Tools\\AddonBuilder\\AddonBuilder.exe"
PRIVATE_KEY   = "C:\\Users\\ChADMIN\\Documents\\Arma 3 - Other Profiles\\Grom\\mpmissions\\Development" \
"\\Role-Restricted%20Arsenal.VR\\grom.biprivatekey"
BUILD_FOLDER  = join(getcwd(),"grra")
ADDONS_FOLDER = join(join(getcwd(),"build_tmp"),"Addons")
KEYS_FOLDER   = join(join(getcwd(),"build_tmp"),"Keys")

# Clear/Build the temp structure
print ("\r\n[+] Rebuilding temp folder")
try:
    shutil.rmtree(BUILD_FOLDER)
except:
    print ("[!] Temp folder not found, creating new one")
    pass

mkdir(BUILD_FOLDER)

print ("\r\n[+] Copying project to /tmp folder")
shutil.copytree(join(getcwd(),"functions"), join(BUILD_FOLDER,"functions"))
shutil.copytree(join(getcwd(),"data"), join(BUILD_FOLDER,"data"))
shutil.copy(join(getcwd(),"config.cpp"), BUILD_FOLDER)
shutil.copy(join(getcwd(),"$PBOPREFIX$"), BUILD_FOLDER)

# all files that end with ".hpp"
for file in glob.glob("*.hpp"):
    shutil.copy(file, BUILD_FOLDER)
    print ("[+] Copied hpp " + file)

print ()

print ("\r\n[+] Copied project to /tmp folder")

print ("\r\n[+] Packing addon !!!\n\n\n")

# Pack the addon
run([
    ADDON_BUILDER,
    BUILD_FOLDER,
    ADDONS_FOLDER,
    "-packonly",
    "-prefix=GRRA",
    "-sign=" + PRIVATE_KEY
], check=True)

# Clean up
print ("\r\n[+] Cleaning up")
shutil.rmtree(BUILD_FOLDER)