import argparse
import json
import math
import os

from datetime import datetime, UTC
from typing import NamedTuple, Optional

parser = argparse.ArgumentParser(
    "Phar's PopTracker Packager",
    description="A CLI package builder and compiler for PopTracker packs.",
    epilog="Example project included at https://github.com/ThePhar/APSM64TrackerPack",
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

PACKAGE_NAME = "phars_sm64tracker"
PACKAGES_PATH = os.path.join(os.getcwd(), "packs")
MANIFEST_PATH = os.path.join(os.getcwd(), "manifest.json")
PACKAGE_INCLUDE_FILES = [
    "LICENSE",
    "manifest.json",
    "settings.json",
]
PACKAGE_INCLUDE_FOLDERS = [
    "images",
    "items",
    "layouts",
    "locations",
    "maps",
    "scripts",
]


class Version(NamedTuple):
    major: int
    minor: int
    patch: int
    prerelease: Optional[str] = None
    build_metadata: Optional[str] = None

    @staticmethod
    def parse_version(raw_version: str):
        import re

        pattern = (
            r"^(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.(?P<patch>0|[1-9]\d*)(?:-(?P<prerelease>(?:0|[1-9]\d*|\d*["
            r"a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+(?P<build_metadata>[0-9a-zA-"
            r"Z-]+(?:\.[0-9a-zA-Z-]+)*))?$"
        )

        matches: tuple[str, ...] = re.search(pattern, raw_version).groups()
        return Version(int(matches[0]), int(matches[1]), int(matches[2]), matches[3], matches[4])

    def increment_major(self) -> "Version":
        return Version(self.major + 1, 0, 0)

    def increment_minor(self) -> "Version":
        return Version(self.major, self.minor + 1, 0)

    def increment_patch(self) -> "Version":
        return Version(self.major, self.minor, self.patch + 1)

    def mark_development(self) -> "Version":
        return Version(self.major, self.minor, self.patch, "pre", math.floor(datetime.now(UTC).timestamp()).__str__())

    def clear_development(self) -> "Version":
        return Version(self.major, self.minor, self.patch)

    def __str__(self) -> str:
        version_string = f"{self.major}.{self.minor}.{self.patch}"
        if self.prerelease:
            version_string += f"-{self.prerelease}"
        if self.build_metadata:
            version_string += f"+{self.build_metadata}"

        return version_string


with open(MANIFEST_PATH, "r", encoding="utf-8") as manifest_file:
    manifest: dict[str, any] = json.loads(manifest_file.read())
    version: Version = Version.parse_version(manifest["package_version"])

if __name__ == "__main__":
    import sys
    import time

    if len(sys.argv) < 2:
        parser.print_help()
        exit(0)

    start_time = time.perf_counter()
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
        print(f"Updating manifest version from {manifest["package_version"]} -> {version}")
        manifest["package_version"] = version.__str__()
        with open(MANIFEST_PATH, "w", encoding="utf-8") as manifest_file:
            json.dump(manifest, manifest_file, indent=4)

    if args.compile:
        from compile import compile_all

        print("Compiling all JSON files...")
        compile_all()

    if args.package:
        from zipfile import ZipFile

        print("Packaging all files...")
        os.makedirs(PACKAGES_PATH, exist_ok=True)
        pack_path = os.path.join(PACKAGES_PATH, f"{PACKAGE_NAME}_{version}.zip")
        with ZipFile(pack_path, "w") as pack:
            for include_path in PACKAGE_INCLUDE_FOLDERS:
                for root, dirs, files in os.walk(include_path):
                    for file in files:
                        file_path = os.path.join(root, file)
                        pack.write(file_path)

            for include_file in PACKAGE_INCLUDE_FILES:
                file_path = os.path.join(os.getcwd(), include_file)
                if os.path.exists(file_path):
                    pack.write(file_path, include_file)

    end_time = time.perf_counter()
    print(f"Finished processing. Completed in {round(end_time - start_time, 2)} secs. Enjoy!")
