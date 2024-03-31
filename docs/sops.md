# Sops

## Generating keys

### Age Key

To generate new key at ~/.config/sops/age/keys.txt

```bash
age -c age-keygen -o ~/.config/sops/age/keys.txt
```

### From SSH

To generate new key at ~/.config/sops/age/keys.txt from private ssh key at ~/.ssh/private

```bash
ssh-to-age -private-key -i ~/.ssh/private > ~/.config/sops/age/keys.txt
```

### Age Public Key

To get the public key of ~/.config/sops/age/keys.txt

```bash
age -c age-keygen -y ~/.config/sops/age/keys.txt
```

## Adding new keys

When you add a new key to the `.sops.yaml` file and you want to update secrets file you need to run:

```bash
sops updatekeys <file>
```

> replacing `<file>` with the file that you want to update

## Resources

- [NixOS Secrets Management | SOPS-NIX(Vimjoyer)](https://www.youtube.com/watch?v=G5f6GC7SnhU)
