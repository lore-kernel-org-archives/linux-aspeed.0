From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 26 Apr 2024 10:11:57 +0930
Subject: [PATCH v7 1/1] drivers: watchdog: revise watchdog bootstatus
In-Reply-To: <20240425090727.3787160-2-peteryin.openbmc@gmail.com>
References: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
	 <20240425090727.3787160-2-peteryin.openbmc@gmail.com>
Message-ID: <5ed8bfd6ce559a7d00ec89f1bd7ae1aea90e3ae7.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-04-25 at 17:07 +0800, Peter Yin wrote:
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> on ast2500 if the boot was from the second boot source.
> It does not indicate that the most recent reset was triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET
> if bit 0 of the status register is set. However, this bit can be clear when
> watchdog register 0x0c bit1(Reset System after timeout) is enabled.
> Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
> in ast2600 SCU74 or ast2400/ast2500 SCU3C.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 6 deletions(-)

After this patch the probe() implementation is ~250loc with a whole
bunch of conditional behaviours based on the SoC version. Maybe it's
time to break it up into version-specific functions that are called
from the probe() implementation?

Andrew
