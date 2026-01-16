# SCP commands

## Copy directory recursively
Assume source is: `~/repos/monorepo/`

Destination is same path on vermax.

```sh
scp -r ~/repos/monorepo/ vermax:~/repos/monorepo/
```

## Copy using tar (more efficient for large directories)

Create tar, copy, and extract in separate steps:

```sh
tar -C ~/repos -czf ~/monorepo.tar.gz monorepo
scp ~/monorepo.tar.gz vermax:~/repos/
ssh vermax "tar -C ~/repos -xzf monorepo.tar.gz && rm monorepo.tar.gz"
```

Or pipe tar directly through ssh (single step, no intermediate file):

```sh
tar -C ~/repos -czf - monorepo | ssh vermax "tar -C ~/repos -xzf -"
```

## Copy using rsync (best for repeated transfers)

```sh
rsync -avz /Users/nikhilmaddirala/Library/CloudStorage/OneDrive-SharedLibraries-CogitaasAVA vermax:~/cloud-storage 

rsync -avz /Users/nikhilmaddirala/Library/CloudStorage/OneDrive-CogitaasAVA vermax:~/cloud-storage 
```

**Key rsync advantages:**
- Only copies files that have changed (incremental)
- Can resume interrupted transfers
- Preserves permissions, timestamps, ownership better
- Shows progress by default
- Can delete files in destination that no longer exist in source (`--delete` flag)


