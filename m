From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 6 Jul 2022 17:19:54 -0400
Subject: [PATCH v3 3/5] thunderbolt: test: Use kunit_test_suite() macro
In-Reply-To: <20220625050838.1618469-4-davidgow@google.com>
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-4-davidgow@google.com>
Message-ID: <CAFd5g471_it8CQmBJnrhS=T3AgdfQF2tr4A9n=sYuWayovXmLw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Jun 25, 2022 at 1:10 AM David Gow <davidgow@google.com> wrote:
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
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
