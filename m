From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Mon, 20 Jun 2022 08:05:46 +0300
Subject: [PATCH 3/5] thunderbolt: test: Use kunit_test_suite() macro
In-Reply-To: <20220618090310.1174932-4-davidgow@google.com>
References: <20220618090310.1174932-1-davidgow@google.com>
 <20220618090310.1174932-4-davidgow@google.com>
Message-ID: <YrAAKqdiG3GAGh1r@lahna>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Jun 18, 2022 at 05:03:08PM +0800, David Gow wrote:
> The new implementation of kunit_test_suite() for modules no longer
> conflicts with module_init, so can now be used by the thunderbolt tests.
> 
> Also update the Kconfig entry to enable the test when KUNIT_ALL_TESTS is
> enabled.
> 
> This means that kunit_tool can now successfully run and parse the test
> results with, for example:
> 	./tools/testing/kunit/kunit.py run --arch=x86_64 \
> 	--kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_USB4=y \
> 	'thunderbolt'
> 
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
