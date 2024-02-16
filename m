From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 16 Feb 2024 10:47:36 +1030
Subject: [PATCH] mmc: host: replace 1st argument to struct device * for
 mmc_of_parse_clk_phase()
In-Reply-To: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
References: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
Message-ID: <ae876e697ba16ba2925ec217c6b4e3d8ffea4ab3.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-02-15 at 19:03 +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Parsing dt usaully happens very early, sometimes even bofore struct
> mmc_host is allocated (e.g. dw_mci_probe() and dw_mci_parse_dt() in
> dw_mmc.c). Looking at the source of mmc_of_parse_clk_phase(), it's
> actually not mandatory to have a initialized mmc_host first, instead we
> can pass struct device * to it directly.
> 
> Also fix the only current user (sdhci-of-aspeed.c).
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/mmc/core/host.c            | 4 +---
>  drivers/mmc/host/sdhci-of-aspeed.c | 2 +-

So I think I wrote the mmc_of_parse_clk_phase() prototype with `struct
mmc_host *` simply because mmc_of_parse() took `struct mmc_host *`.

I'll defer to Ulf for whether what you're proposing is desirable, but
in terms of the impact on the Aspeed driver it seems okay.

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
