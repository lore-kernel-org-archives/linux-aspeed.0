From: Joel Stanley <joel@jms.id.au>
Date: Thu, 31 Mar 2022 05:35:47 +0000
Subject: [PATCH 2/2] ARM: dts: aspeed: romed8hm3: Fix GPIOB0 name
In-Reply-To: <20220331022425.28606-2-zev@bewilderbeest.net>
References: <20220331022425.28606-1-zev@bewilderbeest.net>
 <20220331022425.28606-2-zev@bewilderbeest.net>
Message-ID: <CACPK8XeeFDSN8L89BPkV+UfGTYNiULyUPBTYso7Z7e+VEdgc4A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 31 Mar 2022 at 02:24, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This GPIO was mislabeled as DDR_MEM_TEMP in the schematic; after a
> correction from ASRock Rack its name now reflects its actual
> functionality (POST_COMPLETE_N).

Those are quite different functions :)

>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")
Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll send some fixes in after -rc1.

> ---
>  arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> index 572a43e57cac..ff4c07c69af1 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> @@ -198,7 +198,7 @@ &gpio {
>         gpio-line-names =
>                 /*  A */ "LOCATORLED_STATUS_N", "BMC_MAC2_INTB", "NMI_BTN_N", "BMC_NMI",
>                         "", "", "", "",
> -               /*  B */ "DDR_MEM_TEMP", "", "", "", "", "", "", "",
> +               /*  B */ "POST_COMPLETE_N", "", "", "", "", "", "", "",
>                 /*  C */ "", "", "", "", "PCIE_HP_SEL_N", "PCIE_SATA_SEL_N", "LOCATORBTN", "",
>                 /*  D */ "BMC_PSIN", "BMC_PSOUT", "BMC_RESETCON", "RESETCON",
>                         "", "", "", "PSU_FAN_FAIL_N",
> --
> 2.35.1
>
