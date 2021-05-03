From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 3 May 2021 08:23:38 +0200
Subject: [v2 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <C95A3A13-996E-4F52-BEFE-16BC1E74EB22@aspeedtech.com>
References: <20210414104939.1093-1-billy_tsai@aspeedtech.com>
 <20210414104939.1093-3-billy_tsai@aspeedtech.com>
 <20210426204333.gzqke6td33dtugnh@pengutronix.de>
 <A89B45FD-FD3D-43F2-A850-8A7FBB1AF165@aspeedtech.com>
 <C95A3A13-996E-4F52-BEFE-16BC1E74EB22@aspeedtech.com>
Message-ID: <20210503062338.meohvoth7cyfppvu@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

your second reply is nearly identical to the first. It would be helpful
to only write new stuff in new mail. I think there is only a single new
paragraph that I will reply to here.

On Mon, May 03, 2021 at 05:57:23AM +0000, Billy Tsai wrote:
> On 2021/4/27, 4:44 AM,Uwe Kleine-K?nigwrote:
>     > Also please round down in the division to never provide a duty_cycle
>     > bigger than the requested vaule. Also you have to use the actually used
>     > period as divider, not state->period.
> 
> I don?t think that I should use the actually used period as divider. 
> The state->duty_cycle is relative with state->period, not the actual period
> if I use the actual period the precision of the duty cycle may lose.

The strategy you should implement in .apply() is: Pick the biggest
period that is not bigger than the requested period. With that period
pick the biggest duty_cycle that is not bigger than the requested
duty_cycle.

As the actual period might be smaller than state->period, dividing by
the latter yields a result that might be too small.

See commit 8035e6c66a5e98f098edf7441667de74affb4e78 (currently in next)
for a similar example.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210503/38ab3152/attachment.sig>
