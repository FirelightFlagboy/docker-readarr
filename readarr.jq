def opt(f):
  . as $in | try f catch $in;

def semver_cmp:
    sub("\\+.*$"; "")
  | capture("^(?<v>[^-]+)(?:-(?<p>.*))?$") | [ .v, .p // empty ]
  | map(split(".") | map(opt(tonumber)))
  | .[1] |= (. // {});

def latest_release:
  sort_by(.version | semver_cmp) | last;

def to_output:
  {
    "version": .version,
    "assets": {
      "amd64": {
        "filename": .filename,
        "download_url": .url,
        "digest": ["sha256", .hash] | join(":")
      }
    }
  };

. | latest_release | to_output
