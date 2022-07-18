From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 18 Jul 2022 10:14:48 +0930
Subject: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
In-Reply-To: <20220715040354.2629856-1-davidgow@google.com>
References: <20220715040354.2629856-1-davidgow@google.com>
Message-ID: <38480b33-3b4d-44d4-bb24-6ab199d0c793@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 15 Jul 2022, at 13:33, David Gow wrote:
> While the sdhci-of-aspeed KUnit tests do work when builtin, and do work
> when KUnit itself is being built as a module, the two together break.
>
> This is because the KUnit tests (understandably) depend on KUnit, so a
> built-in test cannot build if KUnit is a module.
>
> Fix this by adding a dependency on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y),
> which only excludes this one problematic configuration.
>
> This was reported on a nasty openrisc-randconfig run by the kernel test
> robot, though for some reason (compiler optimisations removing the test
> code?) I wasn't able to reproduce it locally on x86:
> https://lore.kernel.org/linux-mm/202207140122.fzhlf60k-lkp at intel.com/T/
>
> Fixes: 291cd54e5b05 ("mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 10c563999d3d..e63608834411 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -171,6 +171,7 @@ config MMC_SDHCI_OF_ASPEED
>  config MMC_SDHCI_OF_ASPEED_TEST
>  	bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
>  	depends on MMC_SDHCI_OF_ASPEED && KUNIT
> +	depends on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y)

Should this replace the line above? Isn't it just more constrained?

Regardless, thanks for your work here, the kunit integration with the 
ASPEED SDHCI driver bothered me a lot when I wrote it.

Andrew
