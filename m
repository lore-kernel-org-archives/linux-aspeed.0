From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri, 16 Jul 2021 12:13:01 +0200
Subject: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
 <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
 <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
 <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
Message-ID: <20210716101301.l563tdwt5xuq5iq6@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Billy,

On Fri, Jul 16, 2021 at 09:22:22AM +0000, Billy Tsai wrote:
> On 2021/7/16, 3:10 PM, "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de> wrote:
> 
>     On Fri, Jul 16, 2021 at 01:48:20AM +0000, Billy Tsai wrote:
>     >> On 2021/7/15, 11:06 PM, "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>> wrote:
>     >>     > Another is: The PWM doesn't support duty_cycle 0, on such a request the
>     >>     > PWM is disabled which results in a constant inactive level.
>     >> 
>     >>     > (This is correct, is it? Or does it yield a constant 0 level?)
>     >> 
>     >> Our pwm can support duty_cycle 0 by unset CLK_ENABLE.
> 
>     > This has a slightly different semantic though. Some consumer might
>     > expect that the following sequence:
> 
>     >	pwm_apply(mypwm, { .period = 10000, .duty_cycle = 10000, .enabled = true })
>     >	pwm_apply(mypwm, { .period = 10000, .duty_cycle = 0, .enabled = true })
>     >	pwm_apply(mypwm, { .period = 10000, .duty_cycle = 10000, .enabled = true })
> 
>     > results in the output being low for an integer multiple of 10 ?s. This
>     > isn't given with setting CLK_ENABLE to zero, is it? (I didn't recheck,
>     > if the PWM doesn't complete periods on reconfiguration this doesn't
>     > matter much though.)
> Thanks for the explanation.
> Our hardware actually can only support duty from 1/256 to 256/256.
> For this situation I can do possible solution:
> We can though change polarity to meet this requirement. Inverse the pin and use
> duty_cycle 100. 
> But I think this is not a good solution for this problem right?

If this doesn't result in more glitches that would be fine for me.
(Assuming it is documented good enough in the code to be
understandable.)

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210716/e1986bd5/attachment.sig>
