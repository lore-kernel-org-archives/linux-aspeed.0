From: David Gow <davidgow@google.com>
Date: Wed, 22 Jun 2022 15:16:01 +0800
Subject: [PATCH v2 3/5] thunderbolt: test: Use kunit_test_suite() macro
In-Reply-To: <20220621085345.603820-4-davidgow@google.com>
References: <20220621085345.603820-1-davidgow@google.com> <20220621085345.603820-4-davidgow@google.com>
Message-ID: <CABVgOSm-bgjTzeWjEtDZ+3f-zJLxjywtgVSqWu2-cK_ScRLHwA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 21, 2022 at 4:54 PM David Gow <davidgow@google.com> wrote:
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
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220618090310.1174932-4-davidgow at google.com/
> - Actually include the Kconfig changes, which were mistakenly added to
>   the next patch in the series in v1.
> - Add Acked-by tag from Mika Westerberg
>
> ---
>  drivers/thunderbolt/Kconfig  |  5 +++--
>  drivers/thunderbolt/domain.c |  3 ---
>  drivers/thunderbolt/tb.h     |  8 --------
>  drivers/thunderbolt/test.c   | 12 +-----------
>  4 files changed, 4 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
> index 4bfec8a28064..2a063d344b94 100644
> --- a/drivers/thunderbolt/Kconfig
> +++ b/drivers/thunderbolt/Kconfig
> @@ -28,8 +28,9 @@ config USB4_DEBUGFS_WRITE
>           this for production systems or distro kernels.
>
>  config USB4_KUNIT_TEST
> -       bool "KUnit tests"
> -       depends on KUNIT=y
> +       bool "KUnit tests" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
>

FYI: It turns out we can't just replace the "depends on KUNIT=y" with
"depends on KUNIT" here, as it's still possible to have CONFIG_USB4=y
and CONFIG_KUNIT=m, which would lead to missing KUnit symbols during
link.

What does work is adding, in addition to "depends on KUNIT":
depends on (USB4=m || KUNIT=y)

Which will prevent the tests from being enabled in this situation.

I'll wait another day or so before sending out a v3 with this fixed,
in case there are any other issues which arise.

Cheers,
-- David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4003 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220622/6ec0d16f/attachment.p7s>
