From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 4 Mar 2022 18:29:50 +0100
Subject: [SPAM] [PATCH 1/1] mtd: spi-nor: aspeed: set the decoding size to
 at least 2MB for AST2600
In-Reply-To: <20220304170757.16924-1-potin.lai@quantatw.com>
References: <20220304170757.16924-1-potin.lai@quantatw.com>
Message-ID: <67004879-96ab-33b5-f389-bbe0005d78ef@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Potin,

On 3/4/22 18:07, Potin Lai wrote:
> In AST2600, the unit of SPI CEx decoding range register is 1MB, and end
> address offset is set to the acctual offset - 1MB. If the flash only has
> 1MB, the end address will has same value as start address, which will
> causing unexpected errors.

Yes. That's probably true.
  
> This patch set the decoding size to at least 2MB to avoid decoding errors.
>
> Tested:
> root at bletchley:~# dmesg | grep "aspeed-smc 1e631000.spi: CE0 window"

Could you send all the "aspeed-smc" logs please ? I would like to
reproduce on QEMU. You can use these machine options :

   fmc-model=<string>     - Change the FMC Flash model
   spi-model=<string>     - Change the SPI Flash model

to change the default flash device models and see how the driver reacts.
Add -trace aspeed_smc_flash_set_segment to see how the QEMU model is
configured.

> [   59.328134] aspeed-smc 1e631000.spi: CE0 window resized to 2MB (AST2600 Decoding)
> [   59.343001] aspeed-smc 1e631000.spi: CE0 window [ 0x50000000 - 0x50200000 ] 2MB
> root at bletchley:~# devmem 0x1e631030
> 0x00100000

I thought devmem was banned :)

We could expose the main FMC/SPI registers under sysfs or debugfs.
The segment registers and the timing registers would be nice to
have. I can revive some experimental patch I did a few years ago.

If you have some time, could you please try the new driver based
on spi-mem ?

v3 is pushed here :

   https://github.com/legoater/linux/commits/openbmc-5.15

The patch looks correct but we also want to fix the new driver and
I have reworked the window setting part. It should be less fragile.
aspeed_spi_chip_adjust_window() still needs to handle HW quirks
though.

Thanks,

C.

> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>   drivers/mtd/spi-nor/controllers/aspeed-smc.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> index 416ea247f843..6db35732c0fb 100644
> --- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> +++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> @@ -781,6 +781,17 @@ static u32 aspeed_smc_chip_set_segment(struct aspeed_smc_chip *chip)
>   			 chip->cs, size >> 20);
>   	}
>   
> +	/*
> +	 * The decoding size of AST2600 SPI controller should set at
> +	 * least 2MB.
> +	 */
> +	if (controller->info == &spi_2600_info && size < SZ_2M) {
> +		size = SZ_2M;
> +		dev_info(chip->nor.dev,
> +			 "CE%d window resized to %dMB (AST2600 Decoding)",
> +			 chip->cs, size >> 20);
> +	}
> +
>   	ahb_base_phy = controller->ahb_base_phy;
>   
>   	/*

