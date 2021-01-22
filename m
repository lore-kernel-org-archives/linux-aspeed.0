From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 22 Jan 2021 09:23:10 -0800
Subject: [PATCH v2] mmc: sdhci-of-aspeed: Fix kunit-related build error
In-Reply-To: <20210122114852.3790565-1-andrew@aj.id.au>
References: <20210122114852.3790565-1-andrew@aj.id.au>
Message-ID: <bef54bf0-7c9e-09ce-9f37-ab9498959ba1@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/22/21 3:48 AM, Andrew Jeffery wrote:
> Randy found that with the following Kconfig settings we have duplicate
> definitions (e.g. __inittest()) in sdhci-of-aspeed due to competing
> module_init()/module_exit() calls from kunit and driver the itself.
> 
> ```
> CONFIG_MMC_SDHCI_OF_ASPEED=m
> CONFIG_MMC_SDHCI_OF_ASPEED_TEST=y
> ```
> 
> Conditionally open-code the kunit initialisation to avoid the error.
> 
> Fixes: 7efa02a981d6 ("mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> 
> v2:
> * Collapse the #ifdef-ery
> 
>  drivers/mmc/host/sdhci-of-aspeed-test.c |  9 +++++-
>  drivers/mmc/host/sdhci-of-aspeed.c      | 42 ++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 6 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.


-- 
~Randy

