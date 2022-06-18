From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Sat, 18 Jun 2022 17:41:28 +0000
Subject: [PATCH 0/5] Rework KUnit test execution in modules
In-Reply-To: <20220618090310.1174932-1-davidgow@google.com>
References: <20220618090310.1174932-1-davidgow@google.com>
Message-ID: <87335c4a-7050-79e3-ec5c-4684a180193a@csgroup.eu>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Le 18/06/2022 ? 11:03, David Gow a ?crit?:
> [Vous ne recevez pas souvent de courriers de davidgow at google.com. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> 
> This patch series makes two changes to how KUnit test suites are stored
> and executed:
> - The .kunit_test_suites section is now used for tests in modules (in
>    lieu of a module_init funciton), as well as for built-in tests. The
>    module loader will now trigger test execution. This frees up the
>    module_init function for other uses.
> - Instead of storing an array of arrays of suites, have the
>    kunit_test_suite() and kunit_test_suites() macros append to one global
>    (or per-module) list of test suites. This removes a needless layer of
>    indirection.
> 
> The upshot of this is that it should now be possible to use the
> kunit_test_suite() and kunit_test_suites() macros to register test
> suites even from within modules which otherwise had module_init
> functions. This was proving to be quite a common issue, resulting in
> several modules calling into KUnit's private suite execution functions
> to run their tests (often introducing incompatibilities with the KUnit
> tooling).
> 
> This series also fixes the thunderbolt, nitro_enclaves, and
> sdhci-of-aspeed tests to use kunit_test_suite() now that it works.
> 
> Huge thanks to Jeremy Kerr, who designed and implemented the module
> loader changes, and to Daniel Latypov for pushing the simplification of
> the nested arrays in .kunit_test_suites.
> 
> I've tested this series both with builtin tests, and with modules on
> x86_64, but there's always the possibility that there's something subtle
> and nasty on another architecture, so please test!

Build failure on powerpc architecture with ppc64_defconfig + 
CONFIG_KUNIT_TEST=m

   CC [M]  lib/kunit/test.o
lib/kunit/test.c: In function 'kunit_module_init':
lib/kunit/test.c:616:37: error: 'struct module' has no member named 
'kunit_suites'
   616 |         __kunit_test_suites_init(mod->kunit_suites, 
mod->num_kunit_suites);
       |                                     ^~
lib/kunit/test.c:616:56: error: 'struct module' has no member named 
'num_kunit_suites'
   616 |         __kunit_test_suites_init(mod->kunit_suites, 
mod->num_kunit_suites);
       |                                                        ^~
lib/kunit/test.c: In function 'kunit_module_exit':
lib/kunit/test.c:621:37: error: 'struct module' has no member named 
'kunit_suites'
   621 |         __kunit_test_suites_exit(mod->kunit_suites, 
mod->num_kunit_suites);
       |                                     ^~
lib/kunit/test.c:621:56: error: 'struct module' has no member named 
'num_kunit_suites'
   621 |         __kunit_test_suites_exit(mod->kunit_suites, 
mod->num_kunit_suites);
       |                                                        ^~


Christophe
