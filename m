From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Jan 2021 10:57:47 +0100
Subject: [PATCH v2] mmc: sdhci-of-aspeed: Fix kunit-related build error
In-Reply-To: <20210122114852.3790565-1-andrew@aj.id.au>
References: <20210122114852.3790565-1-andrew@aj.id.au>
Message-ID: <CAPDyKFomiPX36kyK9mConSJTpRnbKYZaKiSz5pyKGaTJpNE0-Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 22 Jan 2021 at 12:49, Andrew Jeffery <andrew@aj.id.au> wrote:
>
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

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2:
> * Collapse the #ifdef-ery
>
>  drivers/mmc/host/sdhci-of-aspeed-test.c |  9 +++++-
>  drivers/mmc/host/sdhci-of-aspeed.c      | 42 ++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> index 34070605b28b..bb67d159b7d8 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed-test.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> @@ -95,4 +95,11 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
>         .name = "sdhci-of-aspeed",
>         .test_cases = aspeed_sdhci_test_cases,
>  };
> -kunit_test_suite(aspeed_sdhci_test_suite);
> +
> +static struct kunit_suite *aspeed_sdc_test_suite_array[] = {
> +       &aspeed_sdhci_test_suite,
> +       NULL,
> +};
> +
> +static struct kunit_suite **aspeed_sdc_test_suites
> +       __used __section(".kunit_test_suites") = aspeed_sdc_test_suite_array;
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 3b0d381e1215..7d8692e90996 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -556,6 +556,29 @@ static struct platform_driver aspeed_sdc_driver = {
>         .remove         = aspeed_sdc_remove,
>  };
>
> +#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
> +#include "sdhci-of-aspeed-test.c"
> +
> +static inline int aspeed_sdc_tests_init(void)
> +{
> +       return __kunit_test_suites_init(aspeed_sdc_test_suites);
> +}
> +
> +static inline void aspeed_sdc_tests_exit(void)
> +{
> +       __kunit_test_suites_exit(aspeed_sdc_test_suites);
> +}
> +#else
> +static inline int aspeed_sdc_tests_init(void)
> +{
> +       return 0;
> +}
> +
> +static inline void aspeed_sdc_tests_exit(void)
> +{
> +}
> +#endif
> +
>  static int __init aspeed_sdc_init(void)
>  {
>         int rc;
> @@ -566,7 +589,18 @@ static int __init aspeed_sdc_init(void)
>
>         rc = platform_driver_register(&aspeed_sdc_driver);
>         if (rc < 0)
> -               platform_driver_unregister(&aspeed_sdhci_driver);
> +               goto cleanup_sdhci;
> +
> +       rc = aspeed_sdc_tests_init();
> +       if (rc < 0) {
> +               platform_driver_unregister(&aspeed_sdc_driver);
> +               goto cleanup_sdhci;
> +       }
> +
> +       return 0;
> +
> +cleanup_sdhci:
> +       platform_driver_unregister(&aspeed_sdhci_driver);
>
>         return rc;
>  }
> @@ -574,15 +608,13 @@ module_init(aspeed_sdc_init);
>
>  static void __exit aspeed_sdc_exit(void)
>  {
> +       aspeed_sdc_tests_exit();
> +
>         platform_driver_unregister(&aspeed_sdc_driver);
>         platform_driver_unregister(&aspeed_sdhci_driver);
>  }
>  module_exit(aspeed_sdc_exit);
>
> -#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
> -#include "sdhci-of-aspeed-test.c"
> -#endif
> -
>  MODULE_DESCRIPTION("Driver for the ASPEED SD/SDIO/SDHCI Controllers");
>  MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
>  MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> --
> 2.27.0
>
