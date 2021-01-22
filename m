From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 21 Jan 2021 19:36:25 -0800
Subject: [PATCH] mmc: sdhci-of-aspeed: Fix kunit-related build error
In-Reply-To: <20210122032334.3663056-1-andrew@aj.id.au>
References: <20210122032334.3663056-1-andrew@aj.id.au>
Message-ID: <fd80b74e-c6a0-9b84-1370-db0c0814dca6@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/21/21 7:23 PM, Andrew Jeffery wrote:
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

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/mmc/host/sdhci-of-aspeed-test.c |  9 ++++++++-
>  drivers/mmc/host/sdhci-of-aspeed.c      | 27 ++++++++++++++++++++-----
>  2 files changed, 30 insertions(+), 6 deletions(-)


-- 
~Randy
RFC: Features and documentation: http://lwn.net/Articles/260136/
