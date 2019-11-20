From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Nov 2019 13:59:04 +0100
Subject: [PATCH v3 3/3] mmc: sdhci-of-aspeed: add inversion signal presence
In-Reply-To: <20191118104646.3838-4-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-4-i.mikhaylov@yadro.com>
Message-ID: <CAPDyKFrshWd1P9dZGTSuU=5P0L6LSPz=v2nn+0SWi3ZZazKrRw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2019 at 11:47, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
> bit in case of inverted card detection signal.
>
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Applied for next, thanks!

For clarity, I am leaving patch 1 for arm-soc.

Kind regards
Uffe



>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 8962f6664381..56912e30c47e 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -111,7 +111,19 @@ static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>
> +static u32 aspeed_sdhci_readl(struct sdhci_host *host, int reg)
> +{
> +       u32 val = readl(host->ioaddr + reg);
> +
> +       if (unlikely(reg == SDHCI_PRESENT_STATE) &&
> +           (host->mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
> +               val ^= SDHCI_CARD_PRESENT;
> +
> +       return val;
> +}
> +
>  static const struct sdhci_ops aspeed_sdhci_ops = {
> +       .read_l = aspeed_sdhci_readl,
>         .set_clock = aspeed_sdhci_set_clock,
>         .get_max_clock = aspeed_sdhci_get_max_clock,
>         .set_bus_width = aspeed_sdhci_set_bus_width,
> --
> 2.20.1
>
