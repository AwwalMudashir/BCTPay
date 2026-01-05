import os
import re
import json
from collections import defaultdict

# CONFIG
ARB_PATH = "lib/l10n/intl_fr.arb"
DART_ROOT = "lib/"
KEY_REGEX = re.compile(r'(?:AppLocalizations\.of\(context\)!|appLocalizations\(context\))\.([a-zA-Z0-9_]+)')

def get_all_dart_files(root):
    dart_files = []
    for dirpath, _, filenames in os.walk(root):
        for f in filenames:
            if f.endswith('.dart'):
                dart_files.append(os.path.join(dirpath, f))
    return dart_files

def scan_keys_in_files(dart_files):
    key_usage = defaultdict(set)
    for file in dart_files:
        with open(file, encoding='utf-8') as f:
            content = f.read()
            for match in KEY_REGEX.finditer(content):
                key = match.group(1)
                key_usage[key].add(file)
    return key_usage

def load_arb(path):
    with open(path, encoding='utf-8') as f:
        return json.load(f)

def save_arb(path, data):
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

def make_unique_key(base_key, file_path):
    # Use file name (without extension) as suffix
    file_name = os.path.splitext(os.path.basename(file_path))[0]
    return f"{base_key}_{file_name}"

def main():
    dart_files = get_all_dart_files(DART_ROOT)
    key_usage = scan_keys_in_files(dart_files)
    arb = load_arb(ARB_PATH)
    new_arb = dict(arb)  # Copy for editing

    for key, files in key_usage.items():
        if len(files) > 1 and key in arb:
            value = arb[key]
            for file in files:
                unique_key = make_unique_key(key, file)
                # Add to ARB if not present
                if unique_key not in new_arb:
                    new_arb[unique_key] = value
                # Replace in Dart file
                with open(file, encoding='utf-8') as f:
                    content = f.read()
                # Replace only this key usage
                content = re.sub(
                    rf'(AppLocalizations\.of\(context\)!|appLocalizations\(context\))\.{key}\b',
                    rf'\1.{unique_key}',
                    content
                )
                with open(file, 'w', encoding='utf-8') as f:
                    f.write(content)
            # Optionally: remove the base key from ARB if not used anywhere else
            # del new_arb[key]

    save_arb(ARB_PATH, new_arb)
    print("✅ Localization keys have been made unique per file and ARB updated.")

if __name__ == "__main__":
    main()