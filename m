From: Joel Stanley <joel@jms.id.au>
Date: Thu, 31 Mar 2022 05:35:16 +0000
Subject: [PATCH 1/2] ARM: dts: aspeed: romed8hm3: Add lm25066 sense
 resistor values
In-Reply-To: <20220331022425.28606-1-zev@bewilderbeest.net>
References: <20220331022425.28606-1-zev@bewilderbeest.net>
Message-ID: <CACPK8Xfg1xV6Cwb2qhu3A7-Ladj6htr45s8ZFqwApTFj4Ab2tQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 31 Mar 2022 at 02:24, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> With this property set the sensor readings from these devices can now
> be calibrated properly.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

I guess:

Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")

Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll send some fixes in after -rc1.

> ---
>  arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> index e71ccfd1df63..572a43e57cac 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> @@ -100,12 +100,14 @@ w83773g at 4c {
>         lm25066 at 40 {
>                 compatible = "lm25066";
>                 reg = <0x40>;
> +               shunt-resistor-micro-ohms = <1000>;
>         };
>
>         /* 12VSB PMIC */
>         lm25066 at 41 {
>                 compatible = "lm25066";
>                 reg = <0x41>;
> +               shunt-resistor-micro-ohms = <10000>;
>         };
>  };
>
> --
> 2.35.1
>
