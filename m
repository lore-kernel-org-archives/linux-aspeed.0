From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 3 Aug 2022 16:35:33 -0400
Subject: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
In-Reply-To: <20220715040354.2629856-1-davidgow@google.com>
References: <20220715040354.2629856-1-davidgow@google.com>
Message-ID: <CAFd5g44h5viRSA_CU=4A0bPyj8yxQ8KgEVHKb=-JZENQwaGEnA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 15, 2022 at 12:04 AM David Gow <davidgow@google.com> wrote:
>
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

Acked-by: Brendan Higgins <brendanhiggins@google.com>
