# Swap and memory management configuration for Vermax
# Multi-tier approach: RAM → ZRAM (compressed) → Disk swap
# This reduces I/O wait and improves system responsiveness

{
  config,
  lib,
  ...
}: {
  # ZRAM swap - compressed RAM swap (much faster than disk)
  zramSwap = {
    enable = true;

    # Percentage of RAM to allocate to ZRAM
    # Higher = more swap capacity but less RAM for applications
    # Recommended: 50-70
    # - 50%: Conservative, leaves more RAM for apps
    # - 70%: More swap capacity, good if you have many memory-hungry apps
    # - 80%+: Aggressive, only use if you constantly run out of memory
    memoryPercent = 60; # ~6.6GB zram on 11GB RAM system

    # Priority - higher values are used first
    # ZRAM should always have higher priority than disk swap
    # Range: 0 (lowest) to 32767 (highest)
    # Keep this at 100 or higher to ensure ZRAM is used before disk
    priority = 100;

    # Compression algorithm
    # Options: zstd, lzo, lz4, lzo-rle
    # - lz4: Fastest compression, moderate compression ratio (recommended)
    # - zstd: Better compression ratio, slightly slower CPU
    # - lzo: Fast, similar to lz4 but slightly slower
    # - lzo-rle: Fastest, lowest compression (very low CPU usage)
    # Monitor with: cat /sys/block/zram0/mm_stat
    # Columns: disksize, num_reads, num_writes, comp_data_size, mem_used_total
    # Compression ratio = comp_data_size / mem_used_total
    # Target ratio: 2.0-3.0 (each byte of RAM stores 2-3 bytes of data)
    algorithm = "lz4";
  };

  # Disk swap - emergency fallback after ZRAM is full
  # Uses the 16GB partition created by disko (/dev/sda2)
  swapDevices = [
    {
      device = "/dev/sda2";

      # Priority - lower than ZRAM so it's only used when ZRAM is full
      # ZRAM priority is 100, so this should be much lower
      # Range: 0 (lowest) to 32767 (highest)
      # Recommended: 10-50 for fallback swap
      # If you want to use disk swap more aggressively, increase to 75-90
      # If you want to avoid disk swap as much as possible, keep at 1-10
      priority = 10;
    }
  ];

  # Kernel memory management parameters
  boot.kernel.sysctl = {
    # vm.swappiness: How aggressively the kernel swaps to disk (0-200)
    # Higher values = more aggressive swapping
    # Default: 60
    # With ZRAM:
    # - 60: Conservative, prefers keeping data in RAM
    # - 100-150: Balanced, good for ZRAM + disk swap setup
    # - 150-200: Aggressive, maximizes ZRAM usage
    # If you see high ZRAM usage but disk swap unused, increase this
    # If disk swap is used too much, decrease this
    "vm.swappiness" = 100;

    # vm.page-cluster: Number of pages to read ahead when swapping (0-3)
    # 0 = disable readahead (recommended for ZRAM)
    # 1 = 2 pages, 2 = 4 pages, 3 = 8 pages
    # Disk swap can benefit from readahead, but ZRAM doesn't need it
    # ZRAM is fast enough that readahead just wastes CPU and RAM
    # Recommended: 0
    "vm.page-cluster" = 0;

    # vm.vfs_cache_pressure: How aggressively to reclaim inode/dentry cache (1-1000)
    # Higher = reclaim cache more aggressively
    # Default: 100
    # Lower values keep more cached file metadata (faster file access)
    # Good for desktop systems that frequently access the same files
    # - 75: Balanced
    # - 50: Keep more cache (good for file-heavy workloads)
    # - 100+: Reclaim cache aggressively (low memory systems)
    "vm.vfs_cache_pressure" = 75;

    # vm.min_free_kbytes: Minimum free RAM (in kilobytes) reserved for kernel
    # Prevents system from becoming unresponsive when memory is critically low
    # Default: Usually calculated automatically
    # Recommended: 65536-131072 (64-128MB) for 8-16GB RAM systems
    # If you get "out of memory" errors, increase this
    # Formula: sqrt(total RAM) * 16
    # For 11GB RAM: sqrt(11366) * 16 ≈ 1707, but minimum is 65536
    "vm.min_free_kbytes" = 65536;
  };
}
