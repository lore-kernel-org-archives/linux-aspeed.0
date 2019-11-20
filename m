From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Nov 2019 13:58:55 +0100
Subject: [PATCH v3 2/3] mmc: sdhci-of-aspeed: enable
 CONFIG_MMC_SDHCI_IO_ACCESSORS
In-Reply-To: <20191118104646.3838-3-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-3-i.mikhaylov@yadro.com>
Message-ID: <CAPDyKFoz3ipYBGR-6ubfqhtQVG9h16axoHNdSoo+OyNgKRs2Tw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2019 at 11:47, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS on the aspeed board. The read_l
> callback is used for inverted card detection.
>
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Applied for next, updating the changelog according to Andrew's comments, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..c9c1bb722368 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -159,6 +159,7 @@ config MMC_SDHCI_OF_ASPEED
>         tristate "SDHCI OF support for the ASPEED SDHCI controller"
>         depends on MMC_SDHCI_PLTFM
>         depends on OF && OF_ADDRESS
> +       select MMC_SDHCI_IO_ACCESSORS
>         help
>           This selects the ASPEED Secure Digital Host Controller Interface.
>
> --
> 2.20.1
>
