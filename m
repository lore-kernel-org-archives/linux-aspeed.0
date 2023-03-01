From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Mar 2023 00:17:36 +0000
Subject: [PATCH v2] ARM: dts: aspeed: mtmitchell: Enable NCSI
In-Reply-To: <20230228102820.18477-1-chanh@os.amperecomputing.com>
References: <20230228102820.18477-1-chanh@os.amperecomputing.com>
Message-ID: <CACPK8XesuUATxCVEGpus=ZHTkjS=L=gjRHC3V+=XLSofU-WSSw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 28 Feb 2023 at 10:28, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Support the mac3 (RGMII4) as an NC-SI stack instead of an MDIO PHY.
>
> The OCP slot #0 and OCP slot #1 use a common the BMC_NCSI signal,
> so we use only one of them at the same time. The OCP slot #0 will
> be enabled by PCA9539's setting by default.
>
> Also, enable the OCP Auxiliary Power during booting.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

LGTM. I'll apply it once we have a -rc1.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> Changes in v2:
>    - Change PCA9539APW node name.                     [Krzysztof]
> ---
>  .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 37 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index 4b91600eaf62..1e0e88465254 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -251,6 +251,14 @@
>         pinctrl-0 = <&pinctrl_rgmii1_default>;
>  };
>
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       clock-names = "MACCLK", "RCLK";
> +       use-ncsi;
> +};
> +
>  &fmc {
>         status = "okay";
>         flash at 0 {
> @@ -439,6 +447,26 @@
>         status = "okay";
>  };
>
> +&i2c8 {
> +       status = "okay";
> +
> +       gpio at 77 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x77>;
> +               gpio-controller;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               #gpio-cells = <2>;
> +
> +               bmc-ocp0-en-hog {
> +                       gpio-hog;
> +                       gpios = <7 GPIO_ACTIVE_LOW>;
> +                       output-high;
> +                       line-name = "bmc-ocp0-en-n";
> +               };
> +       };
> +};
> +
>  &i2c9 {
>         status = "okay";
>  };
> @@ -530,13 +558,20 @@
>         /*V0-V7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
>                         "host0-reboot-ack-n","host0-ready","host0-shd-req-n",
>                         "host0-shd-ack-n","s0-overtemp-n",
> -       /*W0-W7*/       "ocp-aux-pwren","ocp-main-pwren","ocp-pgood","",
> +       /*W0-W7*/       "","ocp-main-pwren","ocp-pgood","",
>                         "bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
>         /*X0-X7*/       "i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
>                         "s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
>                         "s1-overtemp-n","s1-spi-auth-fail-n",
>         /*Y0-Y7*/       "","","","","","","","host0-special-boot",
>         /*Z0-Z7*/       "reset-button","ps0-pgood","ps1-pgood","","","","","";
> +
> +       ocp-aux-pwren-hog {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "ocp-aux-pwren";
> +       };
>  };
>
>  &gpio1 {
> --
> 2.17.1
>
