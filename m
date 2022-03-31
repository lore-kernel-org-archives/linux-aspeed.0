From: Joel Stanley <joel@jms.id.au>
Date: Thu, 31 Mar 2022 01:07:42 +0000
Subject: [RESEND][PATCH linux dev-5.15 v2 1/1] mtd: spi-nor: aspeed: set
 the decoding size to at least 2MB for AST2600
In-Reply-To: <20220331002914.30495-1-potin.lai@quantatw.com>
References: <20220331002914.30495-1-potin.lai@quantatw.com>
Message-ID: <CACPK8XfzFNqyoa4Fe0sY3usfAd75KAVg2pO8fnW+BzyvSSp9dg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 31 Mar 2022 at 00:29, Potin Lai <potin.lai@quantatw.com> wrote:
>
> In AST2600, the unit of SPI CEx decoding range register is 1MB, and end
> address offset is set to the acctual offset - 1MB. If the flash only has
> 1MB, the end address will has same value as start address, which will
> causing unexpected errors.
>
> This patch set the decoding size to at least 2MB to avoid decoding errors.
>
> Tested:
> root at bletchley:~# dmesg | grep "aspeed-smc 1e631000.spi: CE0 window"
> [   59.328134] aspeed-smc 1e631000.spi: CE0 window resized to 2MB (AST2600 Decoding)
> [   59.343001] aspeed-smc 1e631000.spi: CE0 window [ 0x50000000 - 0x50200000 ] 2MB
> root at bletchley:~# devmem 0x1e631030
> 0x00100000
>
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>
> ---
> [v1]: https://lore.kernel.org/all/20220304170757.16924-1-potin.lai at quantatw.com/

C?dric, can I get an ack from you before I put this in the openbmc tree?

>
> Changes v1 --> v2:
> - add fmc controller into decoding range resize checking
> ---
>  drivers/mtd/spi-nor/controllers/aspeed-smc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> index 416ea247f843..74fa46439246 100644
> --- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> +++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> @@ -781,6 +781,18 @@ static u32 aspeed_smc_chip_set_segment(struct aspeed_smc_chip *chip)
>                          chip->cs, size >> 20);
>         }
>
> +       /*
> +        * The decoding size of AST2600 SPI controller should set at
> +        * least 2MB.
> +        */
> +       if ((controller->info == &spi_2600_info ||
> +            controller->info == &fmc_2600_info) && size < SZ_2M) {
> +               size = SZ_2M;
> +               dev_info(chip->nor.dev,
> +                        "CE%d window resized to %dMB (AST2600 Decoding)",
> +                        chip->cs, size >> 20);
> +       }
> +
>         ahb_base_phy = controller->ahb_base_phy;
>
>         /*
> --
> 2.17.1
>
