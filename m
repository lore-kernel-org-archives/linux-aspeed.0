From: David Gow <davidgow@google.com>
Date: Fri, 12 Aug 2022 00:55:58 +0800
Subject: [PATCH v4 1/5] kunit: unify module and builtin suite definitions
In-Reply-To: <CAMuHMdUdvGyMFyDSX3cSGDz9x3Q0+z1e0nQB5cB0GFazyPcK3A@mail.gmail.com>
References: <20220709032001.819487-1-davidgow@google.com> <20220709032001.819487-2-davidgow@google.com>
 <CAMuHMdUdvGyMFyDSX3cSGDz9x3Q0+z1e0nQB5cB0GFazyPcK3A@mail.gmail.com>
Message-ID: <CABVgOSk_Y-eEoqH1xbbXfK5TN3P188JFeuZn3ZgV59Bs3Ds4Hg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 11, 2022 at 9:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi David, Jeremy,
>
> On Sat, Jul 9, 2022 at 5:21 AM David Gow <davidgow@google.com> wrote:
> > From: Jeremy Kerr <jk@codeconstruct.com.au>
> >
> > Currently, KUnit runs built-in tests and tests loaded from modules
> > differently. For built-in tests, the kunit_test_suite{,s}() macro adds a
> > list of suites in the .kunit_test_suites linker section. However, for
> > kernel modules, a module_init() function is used to run the test suites.
> >
> > This causes problems if tests are included in a module which already
> > defines module_init/exit_module functions, as they'll conflict with the
> > kunit-provided ones.
> >
> > This change removes the kunit-defined module inits, and instead parses
> > the kunit tests from their own section in the module. After module init,
> > we call __kunit_test_suites_init() on the contents of that section,
> > which prepares and runs the suite.
> >
> > This essentially unifies the module- and non-module kunit init formats.
> >
> > Tested-by: Ma?ra Canal <maira.canal@usp.br>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Thanks for your patch, which is now commit 3d6e44623841c8b8 ("kunit:
> unify module and builtin suite definitions") upstream.
>
> Since this commit, modular kunit tests are no longer run at all.
>
> Before:
>
>     # insmod lib/kunit/kunit.ko
>     # insmod lib/test_hash.ko
>     test_hash: loading test module taints kernel.
>         # Subtest: hash
>         1..2
>         ok 1 - test_string_or
>         ok 2 - test_hash_or
>     # hash: pass:2 fail:0 skip:0 total:2
>     # Totals: pass:2 fail:0 skip:0 total:2
>     ok 1 - hash
>
> After:
>
>     # insmod lib/kunit/kunit.ko
>     # insmod lib/test_hash.ko
>     test_hash: loading test module taints kernel.
>
> The actual test code (and test init code, if it exists) is not run.
>
> Reverting commits e5857d396f35e59e ("kunit: flatten kunit_suite***
> to kunit_suite** in .kunit_test_suites") and 3d6e44623841c8b8 ("kunit:
> unify module and builtin suite definitions") fixes the issue.

Thanks Geert,

This is a known issue. There's a patch to fix it here, which just
missed the pull request:
https://patchwork.kernel.org/project/linux-kselftest/patch/20220713005221.1926290-1-davidgow at google.com/

We'll try to get it merged as soon as possible.

Cheers,
-- David
