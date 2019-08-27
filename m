From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 27 Aug 2019 10:21:52 -0700
Subject: [PATCH v3 3/4] watchdog/aspeed: add support for dual boot
In-Reply-To: <20190827165426.17037-4-i.mikhaylov@yadro.com>
References: <20190827165426.17037-1-i.mikhaylov@yadro.com>
 <20190827165426.17037-4-i.mikhaylov@yadro.com>
Message-ID: <20190827172151.GA31588@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 27, 2019 at 07:54:25PM +0300, Ivan Mikhaylov wrote:
> Set WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION into WDT_CLEAR_TIMEOUT_STATUS
> to clear out boot code source and re-enable access to the primary SPI flash
> chip while booted via wdt2 from the alternate chip.
> 
> AST2400 datasheet says:
> "In the 2nd flash booting mode, all the address mapping to CS0# would be
> re-directed to CS1#. And CS0# is not accessable under this mode. To access
> CS0#, firmware should clear the 2nd boot mode register in the WDT2 status
> register WDT30.bit[1]."
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Please run "checkpatch --strict" on this patch and fix the reported problems
(I _did_ ask for proper multi-line aligment before, but there are a couple
of other issues as well).

Thanks,
Guenter
