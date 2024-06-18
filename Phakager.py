import argparse
import json
import os

from packager import ManifestVersion


PACKAGE_NAME = "PharAPSM64"
PACKAGES_PATH = os.path.join(os.getcwd(), "packs")
PACK_ROOT_PATH = os.path.join(os.getcwd(), "pack_root")
EXTERNAL_INCLUDES = ["LICENSE"]

parser = argparse.ArgumentParser(
    "python ./Phakager.py", description="A CLI package builder and compiler for PopTracker packs."
)

parser.add_argument(
    "-c",
    "--compile",
    help="runs compilation code for auto-generated json files for tracker",
    action="store_true",
)
parser.add_argument(
    "-k",
    "--package",
    help="gathers all relevant files and zips them into packs directory",
    action="store_true",
)
parser.add_argument(
    "-i",
    "--increment_major",
    help="increments the major component in the manifest file",
    action="store_true",
)
parser.add_argument(
    "-m",
    "--increment_minor",
    help="increments the minor component in the manifest file",
    action="store_true",
)
parser.add_argument(
    "-p",
    "--increment_patch",
    help="increments the build component in the manifest file",
    action="store_true",
)
parser.add_argument(
    "-d",
    "--mark_dev",
    help="marks current manifest as developer build with timestamp of build",
    action="store_true",
)


if __name__ == "__main__":
    import sys
    import time

    start_time = time.perf_counter()

    # Display '--help', if no args provided.
    if len(sys.argv) < 2:
        parser.print_help()
        exit(0)

    # Load Manifest and Version
    with open(os.path.join(PACK_ROOT_PATH, "manifest.json"), "r", encoding="utf-8") as manifest_file:
        manifest: dict[str, any] = json.loads(manifest_file.read())
        version: ManifestVersion = ManifestVersion.parse_version(manifest["package_version"])

    # Handle Version Updating
    args = parser.parse_args()
    if args.increment_patch:
        version = version.increment_patch()
    if args.increment_minor:
        version = version.increment_minor()
    if args.increment_major:
        version = version.increment_major()
    if args.mark_dev:
        version = version.mark_development()
    else:
        version = version.clear_development()

    if version.__str__() != manifest["package_version"]:
        print(f"[Phakager] Updating manifest version from {manifest["package_version"]} -> {version}")
        manifest["package_version"] = version.__str__()
        with open(os.path.join(PACK_ROOT_PATH, "manifest.json"), "w", encoding="utf-8") as manifest_file:
            json.dump(manifest, manifest_file, indent=4)

    # Handle Compilation
    if args.compile:
        from packager.compile import compile_all

        print("[Phakager] Compiling all files...")
        compile_all()

    # Handle Packaging
    if args.package:
        from zipfile import ZipFile

        print("[Phakager] Packaging all files...")
        os.makedirs(PACKAGES_PATH, exist_ok=True)
        pack_path = os.path.join(PACKAGES_PATH, f"{PACKAGE_NAME}_{version}.zip")
        with ZipFile(pack_path, "w") as pack:
            for root, dirs, files in os.walk(PACK_ROOT_PATH):
                for file in files:
                    file_path = os.path.join(root, file)
                    pack.write(file_path, os.path.relpath(os.path.join(root, file), PACK_ROOT_PATH))

            for file in EXTERNAL_INCLUDES:
                file_path = os.path.join(os.getcwd(), file)
                pack.write(file_path, file)

        print(f"[Phakager] Completed packaging {PACKAGE_NAME}_{version}.zip")

    end_time = time.perf_counter()
    print(f"[Phakager] Finished processing in {round(end_time - start_time, 2)} secs. Enjoy!")
