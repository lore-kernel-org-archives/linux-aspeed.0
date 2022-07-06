From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 6 Jul 2022 17:05:46 -0400
Subject: [PATCH v3 1/5] kunit: unify module and builtin suite definitions
In-Reply-To: <20220625050838.1618469-2-davidgow@google.com>
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-2-davidgow@google.com>
Message-ID: <CAFd5g44w0h-EFfw-1wY=bBu_BbO1xi3Ys6gPoDogthCxrF14Qg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Jun 25, 2022 at 1:10 AM David Gow <davidgow@google.com> wrote:
>
> From: Jeremy Kerr <jk@codeconstruct.com.au>
>
> Currently, KUnit runs built-in tests and tests loaded from modules
> differently. For built-in tests, the kunit_test_suite{,s}() macro adds a
> list of suites in the .kunit_test_suites linker section. However, for
> kernel modules, a module_init() function is used to run the test suites.
>
> This causes problems if tests are included in a module which already
> defines module_init/exit_module functions, as they'll conflict with the
> kunit-provided ones.
>
> This change removes the kunit-defined module inits, and instead parses
> the kunit tests from their own section in the module. After module init,
> we call __kunit_test_suites_init() on the contents of that section,
> which prepares and runs the suite.
>
> This essentially unifies the module- and non-module kunit init formats.
>
> Tested-by: Ma?ra Canal <maira.canal@usp.br>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
