From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 17 May 2021 08:06:15 +0200
Subject: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
 <20210515151827.amiqh6j6brv44jif@pengutronix.de>
 <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
Message-ID: <20210517060615.3hyifoebyrddsrta@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Billy,

On Mon, May 17, 2021 at 02:53:44AM +0000, Billy Tsai wrote:
> ?On 2021/5/15, 11:57 PM,Uwe Kleine-K?nigwrote:
> 
> 	>	> +	div_h = DIV_ROUND_DOWN_ULL(div_h,
> 	>	> +				   (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1));
> 	>	> +	div_h = DIV_ROUND_DOWN_ULL(div_h, NSEC_PER_SEC);
> 
> 	> As a division is an expensive operation you can better first multiply
> 	> NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1 and divide by
> 	> the result.
> 
> When I multiply NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1 the result will overflow
> for 32-bits and the divisor type of do_div is 32-bits so I need to do div twice to avoid the issue.
> Can you give me some suggests?

Hmm, you're right. There doesn't seem to be a div64_64, I thought there
was one. Anyhow, while looking at the various divide functions I saw
that dividing by a constant shouldn't be that expensive, so I think the
sane way is to keep the two divisions and add a comment describing the
problem.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210517/ccd7ee08/attachment.sig>
