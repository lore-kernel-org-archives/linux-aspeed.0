From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 2 May 2019 03:06:25 +0000
Subject: [PATCH 2/3] aspeed/pinctrl: Fix simultaneous RS-232 / PWM and
 DVO outputs on AST2500 devices
In-Reply-To: <f35bf045-48e4-432f-8239-29f8f6746158@www.fastmail.com>
References: <1890791123.3393899.1556750986902.JavaMail.zimbra@raptorengineeringinc.com>
 <f35bf045-48e4-432f-8239-29f8f6746158@www.fastmail.com>
Message-ID: <d5a0e5a855144fd6bb65c569b37dedfa@TWMBX02.aspeed.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>On Thu, 2 May 2019, at 08:20, Timothy Pearson wrote:
> There appears to be a small error in the pinmux table on pages 130 and
> 131 of the AST2500 datasheet v1.6.  Specifically, the COND2 
> requirement used to mux the surrounding pins to DVI was inadvertently 
> replicated to pins V1, W1, V2, and W2 in the table, which do not 
> incorporate DVI functionality.
> 
> As a result of this error, both serial TX lines and the PWM 0/1 
> outputs were overriding the VPO pinmux settings when VPO was enabled 
> in the pinmux hogs.
> 
> This patch has been verified to function on Blackbird hardware.  Both 
> serial TXD pins and PWM0/PWM1 were functionally tested with SCU94[1:0] 
> set to 0x1.

Hello Tim.

The AST2500 pwm0/1 configure need following condition, the SCU94[1:0] is 0x1, it should not work. 
Could you help confirm it? 

v2 : pwm 0 : scu88[0] = 1 & scu 94[1:0] = 0 & scu90[5] = 0
w2 : pwm 1 : scu88[1] = 1 & scu 94[1:0] = 0 & scu90[5] = 0




> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> index 187abd7693cf..6f357a11e89a 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> @@ -696,14 +696,14 @@ FUNC_GROUP_DECL(NRTS1, P3);  #define V1 94
>  #define V1_DESC		SIG_DESC_SET(SCU84, 22)
>  SIG_EXPR_LIST_DECL_SINGLE(DASHV1, DASHV1, VPIRSVD_DESC, V1_DESC); 
> -SIG_EXPR_LIST_DECL_SINGLE(TXD1, TXD1, V1_DESC, COND2);
> +SIG_EXPR_LIST_DECL_SINGLE(TXD1, TXD1, V1_DESC);
>  MS_PIN_DECL(V1, GPIOL6, DASHV1, TXD1);  FUNC_GROUP_DECL(TXD1, V1);
>  
>  #define W1 95
>  #define W1_DESC		SIG_DESC_SET(SCU84, 23)
>  SIG_EXPR_LIST_DECL_SINGLE(DASHW1, DASHW1, VPIRSVD_DESC, W1_DESC); 
> -SIG_EXPR_LIST_DECL_SINGLE(RXD1, RXD1, W1_DESC, COND2);
> +SIG_EXPR_LIST_DECL_SINGLE(RXD1, RXD1, W1_DESC);
>  MS_PIN_DECL(W1, GPIOL7, DASHW1, RXD1);  FUNC_GROUP_DECL(RXD1, W1);
>  
> @@ -766,14 +766,14 @@ FUNC_GROUP_DECL(RXD2, T5);  #define V2 104
>  #define V2_DESC         SIG_DESC_SET(SCU88, 0)
>  SIG_EXPR_LIST_DECL_SINGLE(DASHN0, DASHN0, VPIRSVD_DESC, V2_DESC); 
> -SIG_EXPR_LIST_DECL_SINGLE(PWM0, PWM0, V2_DESC, COND2);
> +SIG_EXPR_LIST_DECL_SINGLE(PWM0, PWM0, V2_DESC);
>  MS_PIN_DECL(V2, GPION0, DASHN0, PWM0);  FUNC_GROUP_DECL(PWM0, V2);
>  
>  #define W2 105
>  #define W2_DESC         SIG_DESC_SET(SCU88, 1)
>  SIG_EXPR_LIST_DECL_SINGLE(DASHN1, DASHN1, VPIRSVD_DESC, W2_DESC); 
> -SIG_EXPR_LIST_DECL_SINGLE(PWM1, PWM1, W2_DESC, COND2);
> +SIG_EXPR_LIST_DECL_SINGLE(PWM1, PWM1, W2_DESC);
>  MS_PIN_DECL(W2, GPION1, DASHN1, PWM1);  FUNC_GROUP_DECL(PWM1, W2);

>>This looks reasonable to me. I'd like Ryan to chime in though.


>>Ryan, can you confirm the datasheet needs correction here?

>>Tim: You need to send these to a broader audience than the linux-aspeed@ list. Please use ./scripts/get_maintainer.pl to >>determine the appropriate people to send to. This at least needs to go to Linus Walleij, who maintains pinctrl.


>  
> --
> 2.11.0
> 
>
