From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Apr 2024 11:15:05 -0700
Subject: [PATCH] hwmon: (aspeed-g6-pwm-tacho): Drop cpp define only used
 once
In-Reply-To: <20240411160136.247138-2-u.kleine-koenig@pengutronix.de>
References: <20240411160136.247138-2-u.kleine-koenig@pengutronix.de>
Message-ID: <0787f458-c4ff-4498-820e-15e19796cbe6@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 11, 2024 at 06:01:36PM +0200, Uwe Kleine-K?nig wrote:
> The macro PWM_ASPEED_NR_PWMS is only used once, just use it's value in
> this single code line.
> 

I am not part of the thou-shalt-not-use-defines-if-only-used-once
crowd, so I won't take this patch, sorry.

Guenter
