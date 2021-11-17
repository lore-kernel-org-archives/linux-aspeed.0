From: Zev Weiss <zweiss@equinix.com>
Date: Wed, 17 Nov 2021 03:56:43 +0000
Subject: [PATCH v3 00/13] Introduce PECI subsystem
In-Reply-To: <20211115182552.3830849-1-iwona.winiarska@intel.com>
References: <20211115182552.3830849-1-iwona.winiarska@intel.com>
Message-ID: <20211117035642.GH14774@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 15, 2021 at 10:25:39AM PST, Iwona Winiarska wrote:
>Hi,
>
>This is a third round of patches introducing PECI subsystem.
>Sorry for the delay between v2 and v3.
>

Hi Iwona,

I've done some testing of these patches on my AST2500/E-2778G OpenBMC
platform -- I had to do a small bit of hacking to add support for
INTEL_FAM6_KABYLAKE, but with that in place the newly-added code for the
8.8 format seems to work as it should.  Thanks!

In poking at it a bit further I encountered some sub-optimal behavior
w.r.t. to host power state transitions and timeouts though --
essentially, if I ever hit a timeout in aspeed_peci_xfer() (for example
on a read of a hwmon tempX_input file after an unexpected host
shutdown), it seems to get stuck in a state where even if the host comes
back online, all attempted PECI transfers continue just timing out.
(Rebooting the BMC seems to resolve the problem.)  This also happens if
I remove the peci client device via the 'remove' sysfs file, shut down
the host, and then do a rescan via sysfs while the host is off (i.e.
another operation that times out).

Let me know if there's any other info that would be helpful for
debugging.


Thanks,
Zev
