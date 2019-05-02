From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 02 May 2019 01:51:00 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_3/3]_aspeed/pinctrl:_Fix_simultaneous_DVO_and_seria?=
 =?UTF-8?Q?l_outputs_on_AST2500_devices?=
In-Reply-To: <236762130.3394112.1556751009128.JavaMail.zimbra@raptorengineeringinc.com>
References: <236762130.3394112.1556751009128.JavaMail.zimbra@raptorengineeringinc.com>
Message-ID: <128da9c8-d138-47b9-b323-b845bd93ca2f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 2 May 2019, at 08:20, Timothy Pearson wrote:
> There appears to be a significant error in the pinmux table starting on
> page 127 of the AST2500 datasheet v1.6.  Specifically, the COND2 (DVO)
> requirement is incorrectly applied to multiple digital video input (DVI)
> muxed pins, and no DVI-specific condition is provided.  This results in
> the serial devices incorrectly overriding the DVO pinmuxes and disabling
> the DVO pins.
> 
> Create a new condition code (COND6) for DVI enable, and update the most
> seriously affected pins to use the new condition code.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c 
> b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> index 6f357a11e89a..676f90d3c5f3 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> @@ -29,6 +29,7 @@
>  
>  #define COND1		{ ASPEED_IP_SCU, SCU90, BIT(6), 0, 0 }
>  #define COND2		{ ASPEED_IP_SCU, SCU94, GENMASK(1, 0), 0, 0 }
> +#define COND6		{ ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 0, 0 }
>  
>  /* LHCR0 is offset from the end of the H8S/2168-compatible registers */
>  #define LHCR0		0x20
> @@ -660,8 +661,8 @@ SSSF_PIN_DECL(T2, GPIOL0, NCTS1, SIG_DESC_SET(SCU84, 16));
>  
>  #define T1 89
>  #define T1_DESC		SIG_DESC_SET(SCU84, 17)
> -SIG_EXPR_LIST_DECL_SINGLE(VPIDE, VPI24, VPI_24_RSVD_DESC, T1_DESC, COND2);
> -SIG_EXPR_LIST_DECL_SINGLE(NDCD1, NDCD1, T1_DESC, COND2);
> +SIG_EXPR_LIST_DECL_SINGLE(VPIDE, VPI24, VPI_24_RSVD_DESC, T1_DESC, COND6);
> +SIG_EXPR_LIST_DECL_SINGLE(NDCD1, NDCD1, T1_DESC, COND6);

I feel like you didn't test this patch, because VPI_24_RSVD_DESC (the DVI condition)
requires SCU90[5]=0b1, but your introduction of COND6 requires SCU90[5:4]=0b00 for
the mux configuration to succeed. This can't work - bit 5 of SCU90 can not
simultaneously take the values 1 and 0.

Ryan: Can we just drop the COND2 requirement for function 2 of balls T1, U2, P4 and P3?
I think that gets us where we need to be?

Cheers,

Andrew

>  MS_PIN_DECL(T1, GPIOL1, VPIDE, NDCD1);
>  FUNC_GROUP_DECL(NDCD1, T1);
>  
> @@ -674,22 +675,22 @@ FUNC_GROUP_DECL(NDSR1, U1);
>  
>  #define U2 91
>  #define U2_DESC		SIG_DESC_SET(SCU84, 19)
> -SIG_EXPR_LIST_DECL_SINGLE(VPIHS, VPI24, VPI_24_RSVD_DESC, U2_DESC, COND2);
> -SIG_EXPR_LIST_DECL_SINGLE(NRI1, NRI1, U2_DESC, COND2);
> +SIG_EXPR_LIST_DECL_SINGLE(VPIHS, VPI24, VPI_24_RSVD_DESC, U2_DESC, COND6);
> +SIG_EXPR_LIST_DECL_SINGLE(NRI1, NRI1, U2_DESC, COND6);
>  MS_PIN_DECL(U2, GPIOL3, VPIHS, NRI1);
>  FUNC_GROUP_DECL(NRI1, U2);
>  
>  #define P4 92
>  #define P4_DESC		SIG_DESC_SET(SCU84, 20)
> -SIG_EXPR_LIST_DECL_SINGLE(VPIVS, VPI24, VPI_24_RSVD_DESC, P4_DESC, COND2);
> -SIG_EXPR_LIST_DECL_SINGLE(NDTR1, NDTR1, P4_DESC, COND2);
> +SIG_EXPR_LIST_DECL_SINGLE(VPIVS, VPI24, VPI_24_RSVD_DESC, P4_DESC, COND6);
> +SIG_EXPR_LIST_DECL_SINGLE(NDTR1, NDTR1, P4_DESC, COND6);
>  MS_PIN_DECL(P4, GPIOL4, VPIVS, NDTR1);
>  FUNC_GROUP_DECL(NDTR1, P4);
>  
>  #define P3 93
>  #define P3_DESC		SIG_DESC_SET(SCU84, 21)
> -SIG_EXPR_LIST_DECL_SINGLE(VPICLK, VPI24, VPI_24_RSVD_DESC, P3_DESC, COND2);
> -SIG_EXPR_LIST_DECL_SINGLE(NRTS1, NRTS1, P3_DESC, COND2);
> +SIG_EXPR_LIST_DECL_SINGLE(VPICLK, VPI24, VPI_24_RSVD_DESC, P3_DESC, COND6);
> +SIG_EXPR_LIST_DECL_SINGLE(NRTS1, NRTS1, P3_DESC, COND6);
>  MS_PIN_DECL(P3, GPIOL5, VPICLK, NRTS1);
>  FUNC_GROUP_DECL(NRTS1, P3);
>  
> -- 
> 2.11.0
>
