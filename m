From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Oct 2023 12:19:44 +1030
Subject: [PATCH 3/7] ARM: dts: aspeed: mtjade: Add the gpio-hog
In-Reply-To: <20231005035525.19036-4-chanh@os.amperecomputing.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-4-chanh@os.amperecomputing.com>
Message-ID: <CACPK8Xcby1Oy0ksP9GQjUi8TNg77bw+HJMqgVujM6dABvT_ViA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Add the GPIOR5 as a gpio-hog with output high so that can
> power the OCP card once the BMC booting.
>
> Add the GPIOAC5 as a gpio-hog with output high to notice
> the BMC state.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Could be two patches as it does two different things, but not worth
re-spinning just for that.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> index c87be433bdd0..8ab5f301f926 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> @@ -805,4 +805,18 @@
>                 output-high;
>                 line-name = "i2c4-o-en";
>         };
> +
> +       ocp-aux-pwren-hog {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "ocp-aux-pwren";
> +       };
> +
> +       bmc-ready {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AC, 5) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "bmc-ready";
> +       };
>  };
> --
> 2.17.1
>
