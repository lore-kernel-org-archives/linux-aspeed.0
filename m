From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 17 May 2021 02:53:44 +0000
Subject: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20210515151827.amiqh6j6brv44jif@pengutronix.de>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
 <20210515151827.amiqh6j6brv44jif@pengutronix.de>
Message-ID: <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

?On 2021/5/15, 11:57 PM,Uwe Kleine-K?nigwrote:

	>	> +	div_h = DIV_ROUND_DOWN_ULL(div_h,
	>	> +				   (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1));
	>	> +	div_h = DIV_ROUND_DOWN_ULL(div_h, NSEC_PER_SEC);

	> As a division is an expensive operation you can better first multiply
	> NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1 and divide by
	> the result.

When I multiply NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1 the result will overflow
for 32-bits and the divisor type of do_div is 32-bits so I need to do div twice to avoid the issue.
Can you give me some suggests?

Thanks

