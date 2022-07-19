From: David Gow <davidgow@google.com>
Date: Tue, 19 Jul 2022 09:41:37 +0800
Subject: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
In-Reply-To: <38480b33-3b4d-44d4-bb24-6ab199d0c793@www.fastmail.com>
References: <20220715040354.2629856-1-davidgow@google.com> <38480b33-3b4d-44d4-bb24-6ab199d0c793@www.fastmail.com>
Message-ID: <CABVgOSnhKMKc0_LvHVYPzL5NVnEuL51nQSm+8bZbjO=Q4seYiw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 18, 2022 at 8:45 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 15 Jul 2022, at 13:33, David Gow wrote:
> > While the sdhci-of-aspeed KUnit tests do work when builtin, and do work
> > when KUnit itself is being built as a module, the two together break.
> >
> > This is because the KUnit tests (understandably) depend on KUnit, so a
> > built-in test cannot build if KUnit is a module.
> >
> > Fix this by adding a dependency on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y),
> > which only excludes this one problematic configuration.
> >
> > This was reported on a nasty openrisc-randconfig run by the kernel test
> > robot, though for some reason (compiler optimisations removing the test
> > code?) I wasn't able to reproduce it locally on x86:
> > https://lore.kernel.org/linux-mm/202207140122.fzhlf60k-lkp at intel.com/T/
> >
> > Fixes: 291cd54e5b05 ("mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  drivers/mmc/host/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 10c563999d3d..e63608834411 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -171,6 +171,7 @@ config MMC_SDHCI_OF_ASPEED
> >  config MMC_SDHCI_OF_ASPEED_TEST
> >       bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
> >       depends on MMC_SDHCI_OF_ASPEED && KUNIT
> > +     depends on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y)
>
> Should this replace the line above? Isn't it just more constrained?
>

We need both lines. The first ensures that both KUNIT and
MMC_SDHCI_OF_ASPEED are available, and the second just targets the
case where KUNIT=m and MMC_SDHCI_OF_ASPEED=y.
If we got rid of the first line, we could end up compiling this
without KUnit at all (if MMC_SDHCI_OF_ASPEED=m).

> Regardless, thanks for your work here, the kunit integration with the
> ASPEED SDHCI driver bothered me a lot when I wrote it.

No worries: we're all still figuring out exactly how these sorts of
tests should interact with modules, so it's been a great real-world
example for us to experiment with.

Cheers,
-- David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4003 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220719/652b7e72/attachment.p7s>
