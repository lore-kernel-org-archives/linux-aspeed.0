From: Daniel Latypov <dlatypov@google.com>
Date: Tue, 21 Jun 2022 13:23:04 -0700
Subject: [PATCH v2 3/5] thunderbolt: test: Use kunit_test_suite() macro
In-Reply-To: <20220621085345.603820-4-davidgow@google.com>
References: <20220621085345.603820-1-davidgow@google.com> <20220621085345.603820-4-davidgow@google.com>
Message-ID: <CAGS_qxpXkTZiebd=zqJTY8wvSs1TuBvBuDdxYkPEjwnkQ+ir2g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 21, 2022 at 1:54 AM David Gow <davidgow@google.com> wrote:
>
> The new implementation of kunit_test_suite() for modules no longer
> conflicts with module_init, so can now be used by the thunderbolt tests.
>
> Also update the Kconfig entry to enable the test when KUNIT_ALL_TESTS is
> enabled.
>
> This means that kunit_tool can now successfully run and parse the test
> results with, for example:
>         ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>         --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_USB4=y \
>         'thunderbolt'

With this, we can maybe revive
https://lore.kernel.org/lkml/20220214184104.1710107-1-dlatypov at google.com
by tacking it onto this series if a v3 goes out.
There is the open question of whether we should put UML-specific
config options in the file, though.

If we decide we don't want that, then we can defer it until I send out
the patches for "repeatable --kunitconfig" and we can add the
uml_pci.config file.

>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Daniel Latypov <dlatypov@google.com>

LGTM.
