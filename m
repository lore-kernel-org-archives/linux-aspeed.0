From: Joel Stanley <joel@jms.id.au>
Date: Thu, 1 Jul 2021 03:40:32 +0000
Subject: [PATCH] ARM: dts: tacoma: Add phase corrections for eMMC
In-Reply-To: <20210625061017.1149942-1-andrew@aj.id.au>
References: <20210625061017.1149942-1-andrew@aj.id.au>
Message-ID: <CACPK8Xd9tsMJaQ9BQSGL0Vfi4UpJ1iuOtMVmfKneydd-zYBhsw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 25 Jun 2021 at 06:10, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The degree values were reversed out from the magic tap values of 7 (in)
> and 15 + inversion (out) initially suggested by Aspeed.
>
> With the patch tacoma survives several gigabytes of reads and writes
> using dd while without it locks up randomly during the boot process.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Thanks for the fix. Is this required due to "mmc: sdhci-of-aspeed: Add
AST2600 bus clock support" or "mmc: sdhci-of-aspeed: Expose clock
phase controls"?

On the topic of those patches, it would be good if we could operate
the devices (with the slower speed?) when the device tree does not
provide the phase values. Think about system bringup, or where you
need the system booting in order to determine the phase calculations.

What changes would be required to the host driver for it to work out of the box?


> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index c1478d2db602..670080bb80eb 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -189,6 +189,7 @@ &emmc_controller {
>
>  &emmc {
>         status = "okay";
> +       clk-phase-mmc-hs200 = <36>, <270>;
>  };
>
>  &fsim0 {
> --
> 2.30.2
>
