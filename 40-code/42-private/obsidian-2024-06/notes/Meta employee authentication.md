- Tests
	- `sks status`
- Fixes
	- `sks renew --mdm-network-access`
	- `fb-sks-agent doctor`
	- `fixmymac`
- References
	- https://www.internalfb.com/wiki/Employee_Authentication/SKS_Agent/Troubleshooting/
- 


## Log
2025-02-04
```bash
nikhilmaddirala@nikhilmaddirala-mbp Desktop % sks status
✓ Checking X2P agent running
✓ Checking SKS agent running
✓ Checking unix socket exists
✓ Checking SKS agent responsive
✓ Valid OAuth token
✓ Device enrolled
✓ OS Keychain
✓ Chef
✓ SKS Agent Network
✓ System Network
  standalone-scep certificate:	expired
  corpca-user certificate:	expires in 1439h57m42s (2025-04-05 15:08:22)
  corpca-ssh certificate:	expires in 168h7m46s (2025-02-11 14:18:26)
  corp-machine certificate:	expires in 719h47m43s (2025-03-06 13:58:23)
  corp-machine-on-disk certificate:	expires in 2159h47m44s (2025-05-05 14:58:24)
  network-access-mdm-attested certificate:	expired
nikhilmaddirala@nikhilmaddirala-mbp Desktop %
```