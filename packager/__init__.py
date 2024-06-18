from datetime import datetime, UTC
from math import floor
from typing import NamedTuple, Optional


class ManifestVersion(NamedTuple):
    major: int
    minor: int
    patch: int
    prerelease: Optional[str] = None
    build_metadata: Optional[str] = None

    @staticmethod
    def parse_version(raw_version: str):
        import re

        # I sure am glad the folks who manage semver provided this cause hot damn, this is terrifying.
        pattern = (
            r"^(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.(?P<patch>0|[1-9]\d*)(?:-(?P<prerelease>(?:0|[1-9]\d*|\d*["
            r"a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+(?P<build_metadata>[0-9a-zA-"
            r"Z-]+(?:\.[0-9a-zA-Z-]+)*))?$"
        )

        matches: tuple[str, ...] = re.search(pattern, raw_version).groups()
        return ManifestVersion(int(matches[0]), int(matches[1]), int(matches[2]), matches[3], matches[4])

    def increment_major(self) -> "ManifestVersion":
        return ManifestVersion(self.major + 1, 0, 0)

    def increment_minor(self) -> "ManifestVersion":
        return ManifestVersion(self.major, self.minor + 1, 0)

    def increment_patch(self) -> "ManifestVersion":
        return ManifestVersion(self.major, self.minor, self.patch + 1)

    def mark_development(self) -> "ManifestVersion":
        return ManifestVersion(
            self.major, self.minor, self.patch, "pre", floor(datetime.now(UTC).timestamp()).__str__()
        )

    def clear_development(self) -> "ManifestVersion":
        return ManifestVersion(self.major, self.minor, self.patch)

    def __str__(self) -> str:
        version_string = f"{self.major}.{self.minor}.{self.patch}"
        if self.prerelease:
            version_string += f"-{self.prerelease}"
        if self.build_metadata:
            version_string += f"+{self.build_metadata}"

        return version_string
