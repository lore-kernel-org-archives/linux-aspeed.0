From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Oct 2023 12:21:09 +1030
Subject: [PATCH 5/7] ARM: dts: aspeed: mtmitchell: Add inlet temperature sensor
In-Reply-To: <20231005035525.19036-6-chanh@os.amperecomputing.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-6-chanh@os.amperecomputing.com>
Message-ID: <CACPK8Xcs_4G0nSeKm2+hjSrp=SBb1MJrCob+EQ1emfVOijSOjw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Add the inlet temperature at address 0x48, which is connected
> via BMC I2C8.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index 88693c2b2dbe..c676172f0dbf 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -510,6 +510,11 @@
>  &i2c8 {
>         status = "okay";
>
> +       temperature-sensor at 48 {
> +               compatible = "ti,tmp112";
> +               reg = <0x48>;
> +       };
> +
>         gpio at 77 {
>                 compatible = "nxp,pca9539";
>                 reg = <0x77>;
> --
> 2.17.1
>
