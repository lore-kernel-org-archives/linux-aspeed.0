From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Wed, 23 Nov 2022 15:43:41 +0700
Subject: [v4 4/5] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20221123061635.32025-5-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-5-billy_tsai@aspeedtech.com>
Message-ID: <Y33dPbQywb5amyw4@debian.me>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 23, 2022 at 02:16:34PM +0800, Billy Tsai wrote:
> Add the support of PWM controller which can be found at aspeed ast2600
> soc. The pwm supoorts up to 16 channels and it's part function of
> multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>

Why do you add Reported-by from kernel test robot? I guess the bot
reported issues on previous version of this patch series, then you fix
them, right?

-- 
An old man doll... just what I always wanted! - Clara
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20221123/a68589f3/attachment-0001.sig>
