From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 6 Nov 2022 09:16:01 -0800
Subject: [PATCH] hwmon: Include <linux/kstrtox.h> when appropriate
In-Reply-To: <0e819645f8d607f7b4550c8aaf4a563b1404bf40.1667730675.git.christophe.jaillet@wanadoo.fr>
References: <0e819645f8d607f7b4550c8aaf4a563b1404bf40.1667730675.git.christophe.jaillet@wanadoo.fr>
Message-ID: <20221106171601.GB105056@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 06, 2022 at 11:31:27AM +0100, Christophe JAILLET wrote:
> The kstrto<something>() functions have been moved from kernel.h to
> kstrtox.h.
> 
> So, include the latter directly in the appropriate files.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The goal of this patch is to eventually remove <linux/kernel.h> from
> <linux/watchdog.h>.
> 
> This patch is needed to avoid indirect inclusion, via <linux/watchdog.h>,
> in fschmd.c, ftsteutates.c and w83793.c.
> 
> 
> Maybe, just including <linux/kstrtox.h> in <linux/hwmon.h> would also do
> the job. It is likely that this file is included in all hwmon's drivers.
> Let me know if this less intrusive approach is preferred.

Include it from <linux/hwmon-sysfs.h>. This should cover almost all
drivers needing it. The remaining drivers (if there are any) should
include it directly. Almost all drivers registering the hwmon device
with [devm_]hwmon_device_register_with_info() do not need the include,
but (almost) all drivers registering with an older API will need it.
Those drivers will also include <linux/hwmon-sysfs.h>.

Thanks,
Guenter
