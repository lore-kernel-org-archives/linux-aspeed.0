From: Joel Stanley <joel@jms.id.au>
Date: Tue, 4 Feb 2020 05:54:44 +0000
Subject: [PATCH] ARM: dts: aspeed: tacoma: Enable eMMC controller
In-Reply-To: <20200202163939.13326-1-linux@roeck-us.net>
References: <20200202163939.13326-1-linux@roeck-us.net>
Message-ID: <CACPK8XeLWZT-VvuErtz6oE1tv1dhwwOnpZbV7PVr2PxgT2fopA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 2 Feb 2020 at 16:39, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Enabling emmc without enabling its controller doesn't do any good.
> Enable its controller as well to make it work.
>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter. The description in aspeed-g6.dtsi changed at some
point and Tacoma was not updated.

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index ff49ec76fa7c..47293a5e0c59 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -132,6 +132,10 @@
>         use-ncsi;
>  };
>
> +&emmc_controller {
> +       status = "okay";
> +};
> +
>  &emmc {
>         status = "okay";
>  };

This node is redundant, as it is not disabled in the dtsi.

Andrew, should we add disabled to the emmc node?

Or remove the label completely, and just have emmc_controller?

Cheers,

Joel

> --
> 2.17.1
>
