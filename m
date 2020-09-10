From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Sep 2020 03:19:34 +0000
Subject: [PATCH] ARM: dts: rainier: Disable internal pull-downs on eMMC
 pins
In-Reply-To: <20200910031143.2997298-1-andrew@aj.id.au>
References: <20200910031143.2997298-1-andrew@aj.id.au>
Message-ID: <CACPK8XeZe2n_a56LGJ16VswvPwRu7jWcSCTH+3grJ5zY9Wq38g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2020 at 03:12, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> There's a veritable tug-of-war going on in the design, so disable one of
> the warring parties.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied to the aspeed tree for 5.10.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 1fa233d2da26..21ae880c7530 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -180,6 +180,10 @@ &emmc_controller {
>         status = "okay";
>  };
>
> +&pinctrl_emmc_default {
> +       bias-disable;
> +};
> +
>  &emmc {
>         status = "okay";
>  };
> --
> 2.25.1
>
