From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Sep 2020 12:07:21 +0200
Subject: [PATCH v2 1/2] mmc: host: Drop unneeded MMC dependency in Kconfig
In-Reply-To: <20200904164315.24618-1-krzk@kernel.org>
References: <20200904164315.24618-1-krzk@kernel.org>
Message-ID: <CAPDyKFrzDeNqvM4cc69iCdVW7QnF=O9C=v13+o5bGBSCSzZfWA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2020 at 18:43, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> All entries in Kconfig are already part of "if MMC", so there is no need
> for additional dependency on MMC.
>
> Suggested-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v1:
> 1. New patch
> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index b95f79f53395..eea01fde0591 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -422,7 +422,7 @@ config MMC_SDHCI_IPROC
>
>  config MMC_MESON_GX
>         tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
> -       depends on ARCH_MESON && MMC
> +       depends on ARCH_MESON
>         help
>           This selects support for the Amlogic SD/MMC Host Controller
>           found on the S905/GX*/AXG family of SoCs.  This controller is
> @@ -458,7 +458,7 @@ config MMC_MESON_MX_SDIO
>
>  config MMC_MOXART
>         tristate "MOXART SD/MMC Host Controller support"
> -       depends on ARCH_MOXART && MMC
> +       depends on ARCH_MOXART
>         help
>           This selects support for the MOXART SD/MMC Host Controller.
>           MOXA provides one multi-functional card reader which can
> --
> 2.17.1
>
