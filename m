From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri, 12 Apr 2024 09:15:41 +0200
Subject: [PATCH] hwmon: (aspeed-g6-pwm-tacho): Drop cpp define only used
 once
In-Reply-To: <0787f458-c4ff-4498-820e-15e19796cbe6@roeck-us.net>
References: <20240411160136.247138-2-u.kleine-koenig@pengutronix.de>
 <0787f458-c4ff-4498-820e-15e19796cbe6@roeck-us.net>
Message-ID: <i37iuube65656euro5kuxgmfae6hdtlp5a6jsowwfalnmzckkv@bnre5uu6s75r>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 11, 2024 at 11:15:05AM -0700, Guenter Roeck wrote:
> On Thu, Apr 11, 2024 at 06:01:36PM +0200, Uwe Kleine-K?nig wrote:
> > The macro PWM_ASPEED_NR_PWMS is only used once, just use it's value in
> > this single code line.
> 
> I am not part of the thou-shalt-not-use-defines-if-only-used-once
> crowd, so I won't take this patch, sorry.

My patch wasn't about religion. It's more that I was annoyed that

	git grep pwmchip_alloc next/master drivers/hwmon

doesn't give me the number of PWM channels. That PWM_ASPEED_NR_PWMS is
only used once then only the detail that makes it easy to actually
change that.

So in my eyes there is no advantage in this define and the only effect
is that it hides information.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240412/1e2a33d2/attachment.sig>
