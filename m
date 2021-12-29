From: Pratyush Yadav <p.yadav@ti.com>
Date: Wed, 29 Dec 2021 23:04:13 +0530
Subject: [PATCH] mtd: aspeed-smc: improve probe resilience
In-Reply-To: <20211229143334.297305-1-patrick@stwcx.xyz>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
Message-ID: <20211229173411.l2bipmi4x3arqjoo@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On 29/12/21 08:33AM, Patrick Williams wrote:
> The aspeed-smc can have multiple SPI devices attached to it in the
> device tree.  If one of the devices is missing or failing the entire
> probe will fail and all MTD devices under the controller will be
> removed.  On OpenBMC this results in a kernel panic due to missing
> rootfs:
> 
> [    0.538774] aspeed-smc 1e620000.spi: Using 50 MHz SPI frequency
> [    0.540471] aspeed-smc 1e620000.spi: w25q01jv-iq (131072 Kbytes)
> [    0.540750] aspeed-smc 1e620000.spi: CE0 window [ 0x20000000 - 0x28000000 ] 128MB
> [    0.540943] aspeed-smc 1e620000.spi: CE1 window [ 0x28000000 - 0x2c000000 ] 64MB
> [    0.541143] aspeed-smc 1e620000.spi: read control register: 203b0041
> [    0.581442] 5 fixed-partitions partitions found on MTD device bmc
> [    0.581625] Creating 5 MTD partitions on "bmc":
> [    0.581854] 0x000000000000-0x0000000e0000 : "u-boot"
> [    0.584472] 0x0000000e0000-0x000000100000 : "u-boot-env"
> [    0.586468] 0x000000100000-0x000000a00000 : "kernel"
> [    0.588465] 0x000000a00000-0x000006000000 : "rofs"
> [    0.590552] 0x000006000000-0x000008000000 : "rwfs"
> [    0.592605] aspeed-smc 1e620000.spi: Using 50 MHz SPI frequency
> [    0.592801] aspeed-smc 1e620000.spi: unrecognized JEDEC id bytes: 00 00 00 00 00 00
> [    0.593039] Deleting MTD partitions on "bmc":
> [    0.593175] Deleting u-boot MTD partition
> [    0.637929] Deleting u-boot-env MTD partition
> [    0.829527] Deleting kernel MTD partition
> [    0.856902] Freeing initrd memory: 1032K
> [    0.866428] Deleting rofs MTD partition
> [    0.906264] Deleting rwfs MTD partition
> [    0.986628] aspeed-smc 1e620000.spi: Aspeed SMC probe failed -2
> [    0.986929] aspeed-smc: probe of 1e620000.spi failed with error -2
> ...
> [    2.936719] /dev/mtdblock: Can't open blockdev
> mount: mounting /dev/mtdblock on run/initramfs/ro failed: No such file or directory
> [    2.963030] MTD: Couldn't look up '/dev/mtdblock': -2
> mount: mounting /dev/mtdblock on run/initramfs/rw failed: No such file or directory
> 
> Mounting read-write /dev/mtdblock filesystem failed.  Please fix and run
> 	mount /dev/mtdblock run/initramfs/rw -t jffs2 -o rw
> or perform a factory reset with the clean-rwfs-filesystem option.
> Fatal error, triggering kernel panic!
> [    3.013047] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
> 
> Many BMC designs have two flash chips so that they can handle a hardware
> failure of one of them.  If one chip failed, it doesn't do any good to
> have redundancy if they all get removed anyhow.
> 
> Improve the resilience of the probe function to handle one of the
> children being missing or failed.  Only in the case where all children
> fail to probe should the controller be failed out.

The patch itself looks fine to me but we no longer want to maintain 
drivers under drivers/mtd/spi-nor/controllers/. They should be moved to 
implement the SPI MEM API (under drivers/spi/). See [0][1] for a couple 
examples. Could you please volunteer to do the conversion for this 
driver?

[0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200601070444.16923-8-vigneshr at ti.com/
[1] https://patchwork.ozlabs.org/project/linux-mtd/patch/20211220164625.9400-3-mika.westerberg at linux.intel.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
