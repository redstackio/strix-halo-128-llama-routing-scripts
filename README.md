# Summary
On the framework server (strix halo) with 128gb ram, in the BIOS configure only 512MB ram dedicated to iGPU.


# Grub Config
In the linux config edit /etc/default/grub and modify the "GRUB_CMDLINE_LINUX_DEFAULT" line to the following:
## Config
```
CMDLINE_LINUX_DEFAULT="quiet splash amd_iommu=off amdgpu.gttsize=131072 ttm.pages_limit=33554432"
```

1. amd_iommu disabled the AMD I/O memory management unit, enabling high-throughput tasks like AI inference to improve performance
2. amdgpu.gttsize sets the Graphics Translation Table to 128GB (you may want to set this a little lower like 122/126gb depending on the linux os build and dedication of the server) - this value is a request.
3. ttm.pages sets the Translation Table Manager to 128GB, this subsystem manages the memory for the GPU and limits what it can give to the kernel.

![amdgpu GTT size](Screenshot%20From%202026-02-05%2021-21-31.png)

## Update Grub
```
# Debian
sudo update-grub
```

# Lemonade SDK (ROCM Pre-Build Release)
Download the latest release of lemonade-sdk with rocm built in (nightly/weekly):
https://github.com/lemonade-sdk/llamacpp-rocm/releases

Place these scripts one parent folder above lemonade-sdk's folder, modify the models, context, etc. Then run the bash script in tmux or screen to retain persistence on ssh logout to your headless framework server.


TODO:
Turn this into a systemd service.
