From: Maíra Canal <maira.canal@usp.br>
Date: Sat, 18 Jun 2022 14:11:29 -0300
Subject: [PATCH 0/5] Rework KUnit test execution in modules
In-Reply-To: <20220618090310.1174932-1-davidgow@google.com>
References: <20220618090310.1174932-1-davidgow@google.com>
Message-ID: <3358b97e-021a-82b7-9ae2-2113aea2c2d9@usp.br>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/18/22 06:03, David Gow wrote:
> This patch series makes two changes to how KUnit test suites are stored
> and executed:
> - The .kunit_test_suites section is now used for tests in modules (in
>   lieu of a module_init funciton), as well as for built-in tests. The
>   module loader will now trigger test execution. This frees up the
>   module_init function for other uses.
> - Instead of storing an array of arrays of suites, have the
>   kunit_test_suite() and kunit_test_suites() macros append to one global
>   (or per-module) list of test suites. This removes a needless layer of
>   indirection.
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
> 
> Cheers,
> -- David
> 

I've tested the modules on x86_64 machines, and everything looks fine.
Also, I applied the AMDGPU KUnit tests [1] on top of these patches,
tried out compiling as a module, and it runs pretty well!

Great to see this feature on KUnit!

Tested-by: Ma?ra Canal <maira.canal@usp.br>

[1] https://lore.kernel.org/dri-devel/20220608010709.272962-1
maira.canal at usp.br/

Best Regards,
- Ma?ra Canal
