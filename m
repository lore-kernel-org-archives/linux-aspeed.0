From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 25 Sep 2019 09:31:46 +0200
Subject: [v1, 1/1] gpio: dts: aspeed: Add SGPIO driver
In-Reply-To: <1569352021-6383-1-git-send-email-hongweiz@ami.com>
References: <1569352021-6383-1-git-send-email-hongweiz@ami.com>
Message-ID: <CAMRc=MecTmtpauqTsdEmZipeDOHoCMAXx6X6Z4zjszr9_W-aeA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

wt., 24 wrz 2019 o 21:07 Hongwei Zhang <hongweiz@ami.com> napisa?(a):
>
> Add SGPIO driver support for Aspeed AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  arch/arm/Kconfig                 |  2 ++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 16 +++++++++++++++-
>  drivers/gpio/Kconfig             |  8 ++++++++
>  drivers/gpio/Makefile            |  1 +
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2436021..c9f08ab 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1460,6 +1460,8 @@ config ARCH_NR_GPIO
>         default 416 if ARCH_SUNXI
>         default 392 if ARCH_U8500
>         default 352 if ARCH_VT8500
> +       default 312 if MACH_ASPEED_G5
> +       default 304 if MACH_ASPEED_G4
>         default 288 if ARCH_ROCKCHIP
>         default 264 if MACH_H4700
>         default 0
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 00f05bd..85da7ea 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -311,7 +311,7 @@
>                                 #gpio-cells = <2>;
>                                 gpio-controller;
>                                 compatible = "aspeed,ast2500-gpio";
> -                               reg = <0x1e780000 0x1000>;
> +                               reg = <0x1e780000 0x200>;
>                                 interrupts = <20>;
>                                 gpio-ranges = <&pinctrl 0 0 232>;
>                                 clocks = <&syscon ASPEED_CLK_APB>;
> @@ -319,6 +319,20 @@
>                                 #interrupt-cells = <2>;
>                         };
>
> +                       sgpio: sgpio at 1e780200 {
> +                               #gpio-cells = <2>;
> +                               compatible = "aspeed,ast2500-sgpio";
> +                               gpio-controller;
> +                               interrupts = <40>;
> +                               reg = <0x1e780200 0x0100>;
> +                               clocks = <&syscon ASPEED_CLK_APB>;
> +                               interrupt-controller;
> +                               ngpios = <8>;
> +                               bus-frequency = <12000000>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_sgpm_default>;
> +                       };
> +
>                         rtc: rtc at 1e781000 {
>                                 compatible = "aspeed,ast2500-rtc";
>                                 reg = <0x1e781000 0x18>;
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index bb13c26..e94f903 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -120,6 +120,14 @@ config GPIO_ASPEED
>         help
>           Say Y here to support Aspeed AST2400 and AST2500 GPIO controllers.
>
> +config SGPIO_ASPEED
> +       bool "Aspeed SGPIO support"
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
> +       select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say Y here to support Aspeed AST2500 SGPIO functionality.
> +
>  config GPIO_ATH79
>         tristate "Atheros AR71XX/AR724X/AR913X GPIO support"
>         default y if ATH79
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index a4e9117..bebbd82 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_GPIO_AMD_FCH)            += gpio-amd-fch.o
>  obj-$(CONFIG_GPIO_AMDPT)               += gpio-amdpt.o
>  obj-$(CONFIG_GPIO_ARIZONA)             += gpio-arizona.o
>  obj-$(CONFIG_GPIO_ASPEED)              += gpio-aspeed.o
> +obj-$(CONFIG_SGPIO_ASPEED)             += sgpio-aspeed.o
>  obj-$(CONFIG_GPIO_ATH79)               += gpio-ath79.o
>  obj-$(CONFIG_GPIO_BCM_KONA)            += gpio-bcm-kona.o
>  obj-$(CONFIG_GPIO_BD70528)             += gpio-bd70528.o
> --
> 2.7.4
>

This should be split into separate patches with one extending the
binding document and one adding actual support.

Bart
