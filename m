From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 17 May 2021 19:10:28 +0200
Subject: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <52C0ED72-65A7-4C39-820F-D4368191878B@aspeedtech.com>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
 <20210515151827.amiqh6j6brv44jif@pengutronix.de>
 <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
 <20210517060615.3hyifoebyrddsrta@pengutronix.de>
 <C451B628-C0CC-47E9-84EF-42DB8518FE1E@aspeedtech.com>
 <20210517063500.toxlb2wbtbqpczwl@pengutronix.de>
 <52C0ED72-65A7-4C39-820F-D4368191878B@aspeedtech.com>
Message-ID: <20210517171028.qioxg53dpzlq4izu@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 17, 2021 at 07:12:53AM +0000, Billy Tsai wrote:
> Hi,
> 
>     > On 2021/5/17, 2:35 PM,Uwe Kleine-K?nigwrote:
> 
>     >   On Mon, May 17, 2021 at 06:23:06AM +0000, Billy Tsai wrote:
>     >   > Hi,
>     >   > 	On 2021/5/17, 2:06 PM,Uwe Kleine-K?nigwrote:
>     >   > 
>     >   > 	On Mon, May 17, 2021 at 02:53:44AM +0000, Billy Tsai wrote:
>     >   > 	>	> On 2021/5/15, 11:57 PM,Uwe Kleine-K?nigwrote:
>     >   > 	>	> 
>     >   > 	>	> 	>	> +	div_h = DIV_ROUND_DOWN_ULL(div_h,
>     >   > 	>	> 	>	> +				   (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1));
>     >   > 	>	> 	>	> +	div_h = DIV_ROUND_DOWN_ULL(div_h, NSEC_PER_SEC);
>     >   > 	>	> 
>     >   > 	>	> 	> As a division is an expensive operation you can better first multiply
>     >   > 	>	> 	> NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1 and divide by
>     >   > 	>	> 	> the result.
>     >   > 	>	> 
>     >   > 	>	> When I multiply NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1 the result will overflow
>     >   > 	>	> for 32-bits and the divisor type of do_div is 32-bits so I need to do div twice to avoid the issue.
>     >   > 	>	> Can you give me some suggests?
>     >   > 
>     >   > 	> Hmm, you're right. There doesn't seem to be a div64_64, I thought there
>     >   > 	> was one. Anyhow, while looking at the various divide functions I saw
>     >   > 	> that dividing by a constant shouldn't be that expensive, so I think the
>     >   > 	> sane way is to keep the two divisions and add a comment describing the
>     >   > 	> problem.
>     >   > According to our fixed value, I think that I can use bit shift to reduce one divide function:
>     >   > 
>     >   > rate = clk_get_rate(priv->clk);
>     >   > /* Get the smallest value for div_h  */
>     >   > div_h = rate * state->period;
>     >   > div_h >>= (__fls(PWM_ASPEED_FIXED_PERIOD + 1) +
>     >   > 	   __fls(FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1));
>     >   > div_h = DIV_ROUND_DOWN_ULL(div_h, NSEC_PER_SEC);
> 
>     > Did you check how this is compiled to code? I'd expect that it doesn't
>     > result in better code than writing it as a division. Given that a
>     > division is easier to understand for a human reader, I'd stick to that.
> 
> I found that I can use div64_64 through #include <linux/math64.h> and use "div64_u64":
> 
> u64 div_h, div_l, divisor;
> u32 index = pwm->hwpwm;
> 
> rate = clk_get_rate(priv->clk);
> /* Get the smallest value for div_h  */
> div_h = rate * state->period;
> divisor = (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
>                 (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
> div_h = div64_u64(div_h, divisor);
> div_h = order_base_2(div_h);
> if (div_h > 0xf)
>         div_h = 0xf;
> 
> div_l = rate * state->period;
> divisor = (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
>                 BIT(div_h);
> div_l = div64_u64(div_l, divisor);
> 
> Can I use this one?

Looks good to me. If you want to improve further you can expand the
comment about div_h to somethink like:

	/*
	 * Pick a small value for div_h so that div_l can be big which
	 * results in a finer resolution near the target period value.
	 */

Another detail I don't like much is that the name div_h is only
justified after the last assignment. I don't have a good suggestion here
though.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210517/c8715ded/attachment.sig>
