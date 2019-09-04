From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Sep 2019 08:32:18 +0200
Subject: [PATCH v3] mmc: sdhci-of-aspeed: Depend on CONFIG_OF_ADDRESS
In-Reply-To: <20190904022120.4174-1-andrew@aj.id.au>
References: <20190904022120.4174-1-andrew@aj.id.au>
Message-ID: <CAPDyKFqj84wm4hHTv4xWMOXpBBi5mkBB8BXJgNFb7-c_YtzpCg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2019 at 04:20, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Resolves the following build error reported by the 0-day bot:
>
>     ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!
>
> SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Depend on
> CONFIG_OF_ADDRESS to ensure the driver is only built for supported
> configurations.
>
> Fixes: 2d28dbe042f4 ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD controller")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2 was a series of 4 patches, three of which were applied leaving this build
> fix to be reworked. The v2 series can be found here:
>
> https://patchwork.ozlabs.org/cover/1156457/
>
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0f8a230de2f3..3a52f5703286 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -157,7 +157,7 @@ config MMC_SDHCI_OF_ARASAN
>  config MMC_SDHCI_OF_ASPEED
>         tristate "SDHCI OF support for the ASPEED SDHCI controller"
>         depends on MMC_SDHCI_PLTFM
> -       depends on OF
> +       depends on OF && OF_ADDRESS
>         help
>           This selects the ASPEED Secure Digital Host Controller Interface.
>
> --
> 2.20.1
>
