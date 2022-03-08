From: Cédric Le Goater <clg@kaod.org>
Date: Tue, 8 Mar 2022 07:26:24 +0100
Subject: [SPAM] [PATCH 1/1] mtd: spi-nor: aspeed: set the decoding size to
 at least 2MB for AST2600
In-Reply-To: <597dcccf-f01a-92b5-9b62-72580660a1c5@quantatw.com>
References: <20220304170757.16924-1-potin.lai@quantatw.com>
 <67004879-96ab-33b5-f389-bbe0005d78ef@kaod.org>
 <6ed257f7-ae87-e2fe-26ed-9db300f5ebcc@kaod.org>
 <efeac1dc-0762-b6d3-e03b-dffc2c76d756@quantatw.com>
 <4d072c43-a766-9ce4-a629-a3ed095663a4@kaod.org>
 <e10877f9-57f7-7019-b9ca-0812a60cdea9@kaod.org>
 <597dcccf-f01a-92b5-9b62-72580660a1c5@quantatw.com>
Message-ID: <e340428e-7ea3-222a-3cc5-b3d7d0ef760b@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Thanks for taking this patch into spi-mem driver, the tested log as below.
> 
> [??? 1.945705] spi-nor spi1.0: mx25l8005 (1024 Kbytes)
> [??? 1.945926] spi-aspeed-smc 1e630000.spi: CE0 window resized to 2MB (AST2600 Decoding)
> aspeed_smc_flash_set_segment CS0 segreg=0x100000 [ 0x30000000 - 0x30200000 ]
> aspeed_smc_flash_set_segment CS1 segreg=0x7f00020 [ 0x30200000 - 0x38000000 ]
> [??? 1.953083] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
> [??? 1.953409] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:1 [0x000b0041]

Thanks for the test !
  
> By the way, there is a small error when compiling kernel, it needs forward declare for both ast2600_spi_data & ast2600_fmc_data.

Ah yes ! Sorry, I pushed a wrong version. I just did an update on my tree.

May be we should introduce some helpers to identify the SoC.

> Also, I saw you add ast2600_fmc_data for resize checking as well, should I add it in aspeed-smc.c and resend the patch?

Both AST2600 controllers have the same encoding of the flash window
range, so, yes the old driver needs it.

Thanks,

C.
