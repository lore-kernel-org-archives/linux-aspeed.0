From: Joel Stanley <joel@jms.id.au>
Date: Tue, 17 Aug 2021 08:22:31 +0000
Subject: [PATCH linux dev-5.10] ARM: dts: aspeed: p10bmc: Add power
 control pins
In-Reply-To: <20210816160002.18645-1-jlwright@us.ibm.com>
References: <20210816160002.18645-1-jlwright@us.ibm.com>
Message-ID: <CACPK8XcgFkcA4cpqzTmwS-tpauWeAeFHqzhjyxOWvggKSOJFQw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 16 Aug 2021 at 16:01, Jim Wright <jlwright@us.ibm.com> wrote:
>
> Add to p10bmc systems the GPIO line names used in chassis power on / off
> control and chassis power good monitoring. Names used are as documented at [1].
>
> [1] https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> Signed-off-by: Jim Wright <jlwright@us.ibm.com>

Thanks, applied.

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 2 +-
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> index 01a0b2b03ddd..941efff7c943 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> @@ -253,7 +253,7 @@ &gpio0 {
>         /*O0-O7*/       "","","","","","","","",
>         /*P0-P7*/       "","","","","led-pcieslot-power","","","",
>         /*Q0-Q7*/       "","","","","","","","",
> -       /*R0-R7*/       "","","","","","I2C_FLASH_MICRO_N","","",
> +       /*R0-R7*/       "","power-chassis-control","power-chassis-good","","","I2C_FLASH_MICRO_N","","",
>         /*S0-S7*/       "","","","","","","","",
>         /*T0-T7*/       "","","","","","","","",
>         /*U0-U7*/       "","","","","","","","",
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index f87bc5dc8aba..605ad80ef967 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -243,7 +243,7 @@ &gpio0 {
>         /*O0-O7*/       "","","","usb-power","","","","",
>         /*P0-P7*/       "","","","","pcieslot-power","","","",
>         /*Q0-Q7*/       "cfam-reset","","","","","","","",
> -       /*R0-R7*/       "","","","","","","","",
> +       /*R0-R7*/       "","power-chassis-control","power-chassis-good","","","","","",
>         /*S0-S7*/       "presence-ps0","presence-ps1","presence-ps2","presence-ps3",
>                                 "","","","",
>         /*T0-T7*/       "","","","","","","","",
> --
> 2.32.0
>
