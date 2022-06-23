From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Jun 2022 14:23:57 +0200
Subject: [PATCH v2 5/5] mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro
In-Reply-To: <CAGS_qxp6ZK9K0Sy1JcuU-SGqChOyr6-+5HDxgesOpxjxvDkiXQ@mail.gmail.com>
References: <20220621085345.603820-1-davidgow@google.com> <20220621085345.603820-6-davidgow@google.com>
 <CAGS_qxp6ZK9K0Sy1JcuU-SGqChOyr6-+5HDxgesOpxjxvDkiXQ@mail.gmail.com>
Message-ID: <CAPDyKFq0cTX5pfTLxTa9SEUBiiEcMuiEeDi3OPfMjFuBWca_jw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 22 Jun 2022 at 00:19, Daniel Latypov <dlatypov@google.com> wrote:
>
>  On Tue, Jun 21, 2022 at 1:54 AM David Gow <davidgow@google.com> wrote:
> >
> > The kunit_test_suite() macro is no-longer incompatible with module_add,
> > so its use can be reinstated.
> >
> > Since this fixes parsing with builtins and kunit_tool, also enable the
> > test by default when KUNIT_ALL_TESTS is enabled.
> >
> > The test can now be run via kunit_tool with:
> >         ./tools/testing/kunit/kunit.py run --arch=x86_64 \
> >         --kconfig_add CONFIG_OF=y --kconfig_add CONFIG_OF_ADDRESS=y \
> >         --kconfig_add CONFIG_MMC=y --kconfig_add CONFIG_MMC_SDHCI=y \
> >         --kconfig_add CONFIG_MMC_SDHCI_PLTFM=y \
> >         --kconfig_add CONFIG_MMC_SDHCI_OF_ASPEED=y \
> >         'sdhci-of-aspeed'
> >
> > (It may be worth adding a .kunitconfig at some point, as there are
> > enough dependencies to make that command scarily long.)
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Acked-by: Daniel Latypov <dlatypov@google.com>
>
> Minor, optional suggestion below.
>
> >  static int __init aspeed_sdc_init(void)
> > @@ -639,12 +620,6 @@ static int __init aspeed_sdc_init(void)
> >         if (rc < 0)
> >                 goto cleanup_sdhci;
> >
> > -       rc = aspeed_sdc_tests_init();
> > -       if (rc < 0) {
> > -               platform_driver_unregister(&aspeed_sdc_driver);
> > -               goto cleanup_sdhci;
> > -       }
> > -
> >         return 0;
> >
> >  cleanup_sdhci:
>
> This goto was added in 4af307f57426 ("mmc: sdhci-of-aspeed: Fix
> kunit-related build error") to allow for this extra call to
> aspeed_sdc_tests_init().
>
> This could now be reverted back to what is
>         rc = platform_driver_register(&aspeed_sdc_driver);
>         if (rc < 0)
>                platform_driver_unregister(&aspeed_sdhci_driver);
>
>         return rc;
>
> but let's see what the maintainers think.

I don't have a strong opinion on this, feel free to pick any of the options.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
