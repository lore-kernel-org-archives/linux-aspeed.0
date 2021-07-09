From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri, 9 Jul 2021 07:53:25 +0200
Subject: [v8 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <FC122EAB-46A9-4B6F-B75C-271B4E17F057@aspeedtech.com>
References: <20210608064658.14262-1-billy_tsai@aspeedtech.com>
 <20210608064658.14262-3-billy_tsai@aspeedtech.com>
 <20210702143147.6a7psfup4tlidq2x@pengutronix.de>
 <FC122EAB-46A9-4B6F-B75C-271B4E17F057@aspeedtech.com>
Message-ID: <20210709055325.4y4ufjvoiwo2pcvi@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Billy,

On Fri, Jul 09, 2021 at 05:40:45AM +0000, Billy Tsai wrote:
> On 2021/7/2, 10:32 PM, "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de> wrote:
>     > The multiplication can be up to:
> 
>     >	100000000 * (1 << 31) * (31 + 1) * (255 + 1)
> 
>     > right? This needs 71 bits and so might overflow a u64.
> 
> No, the multiplication can be up to:
> 
> Max(div_h) = 15
> Max(div_l) = 255
> Max(clk_period) = 255
> 1000000000 * (1 << 15) * (255 + 1) * (255 + 1) < 2^64 - 1
> it doesn't overflow a u64.

Ah, you're right. Please note this in a comment (not that you were
right, but that it doesn't overflow :-)

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210709/cc8aebcb/attachment-0001.sig>
