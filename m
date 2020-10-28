From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 05:51:18 +0000
Subject: [PATCH] arm: dts: aspeed-bmc-tiogapass: enable second MAC
In-Reply-To: <20200930192507.27847-1-fercerpav@gmail.com>
References: <20200930192507.27847-1-fercerpav@gmail.com>
Message-ID: <CACPK8XdMXBUYZxYnvLeZ1V=mT6=uMhy6rNZ9dsksw0_yf6obeA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2020 at 19:27, Paul Fertser <fercerpav@gmail.com> wrote:
>
> Tioga Pass reference design includes Intel I210 Ethernet controller
> connected to the BMC with NC/SI.
>
> MAC readout is not supported.
>
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

Vijay, can I get a review from you on this one please?

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index 2d44d9ad4e40..b2ba798bf3c4 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -196,6 +196,14 @@
>         use-ncsi;
>  };
>
> +&mac1 {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii2_default>;
> +       use-ncsi;
> +};
> +
>  &adc {
>         status = "okay";
>  };
> --
> 2.17.1
>
