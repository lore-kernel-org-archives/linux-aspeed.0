From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 17:47:22 +0100
Subject: [PATCH] mmc: host: replace 1st argument to struct device * for mmc_of_parse_clk_phase()
In-Reply-To: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
References: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
Message-ID: <CAPDyKFo9NpKSuBnrcOseuD-jDA64CMyRxpH-OUoozOQDYHj1mQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 at 12:03, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Parsing dt usaully happens very early, sometimes even bofore struct
> mmc_host is allocated (e.g. dw_mci_probe() and dw_mci_parse_dt() in
> dw_mmc.c). Looking at the source of mmc_of_parse_clk_phase(), it's
> actually not mandatory to have a initialized mmc_host first, instead we
> can pass struct device * to it directly.
>
> Also fix the only current user (sdhci-of-aspeed.c).

Is there a problem? I don't see it, can please elaborate.

Kind regards
Uffe

>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/mmc/core/host.c            | 4 +---
>  drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>  include/linux/mmc/host.h           | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index cf396e8f34e9..8b2844ac5dc5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -234,10 +234,8 @@ static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
>  }
>
>  void
> -mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
> +mmc_of_parse_clk_phase(struct device *dev, struct mmc_clk_phase_map *map)
>  {
> -       struct device *dev = host->parent;
> -
>         mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
>                                   &map->phase[MMC_TIMING_LEGACY]);
>         mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 42d54532cabe..430c1f90037b 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -435,7 +435,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>                 goto err_sdhci_add;
>
>         if (dev->phase_desc)
> -               mmc_of_parse_clk_phase(host->mmc, &dev->phase_map);
> +               mmc_of_parse_clk_phase(&pdev->dev, &dev->phase_map);
>
>         ret = sdhci_add_host(host);
>         if (ret)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 2f445c651742..5894bf912f7b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -539,7 +539,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
>  int mmc_add_host(struct mmc_host *);
>  void mmc_remove_host(struct mmc_host *);
>  void mmc_free_host(struct mmc_host *);
> -void mmc_of_parse_clk_phase(struct mmc_host *host,
> +void mmc_of_parse_clk_phase(struct device *dev,
>                             struct mmc_clk_phase_map *map);
>  int mmc_of_parse(struct mmc_host *host);
>  int mmc_of_parse_voltage(struct mmc_host *host, u32 *mask);
>
> ---
> base-commit: 9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
> change-id: 20240215-mmc_phase-26e85511285d
>
> Best regards,
> --
> Yang Xiwen <forbidden405@outlook.com>
>
