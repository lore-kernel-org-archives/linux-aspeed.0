From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 2 May 2019 04:58:51 +0000
Subject: [PATCH 2/3] aspeed/pinctrl: Fix simultaneous RS-232 / PWM and
 DVO outputs on AST2500 devices
In-Reply-To: <46d7b027-0f88-47e3-a132-e59b7640c867@www.fastmail.com>
References: <1890791123.3393899.1556750986902.JavaMail.zimbra@raptorengineeringinc.com>
 <f35bf045-48e4-432f-8239-29f8f6746158@www.fastmail.com>
 <d5a0e5a855144fd6bb65c569b37dedfa@TWMBX02.aspeed.com>
 <313461427.3426138.1556768056285.JavaMail.zimbra@raptorengineeringinc.com>
 <921172cf50484d839bd30fa27ecf525e@TWMBX02.aspeed.com>
 <46d7b027-0f88-47e3-a132-e59b7640c867@www.fastmail.com>
Message-ID: <08e21a55c7e746cda83694845c2b3429@TWMBX02.aspeed.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> ----- Original Message -----
> > From: "Ryan Chen" <ryan_chen@aspeedtech.com>
> > To: "Andrew Jeffery" <andrew@aj.id.au>, "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-aspeed"
> > <linux-aspeed@lists.ozlabs.org>
> > Cc: "Morris Mao" <morris_mao@aspeedtech.com>
> > Sent: Wednesday, May 1, 2019 10:06:25 PM
> > Subject: RE: [PATCH 2/3] aspeed/pinctrl: Fix simultaneous RS-232 / 
> > PWM and DVO outputs on AST2500 devices
> 
> >>On Thu, 2 May 2019, at 08:20, Timothy Pearson wrote:
> >> There appears to be a small error in the pinmux table on pages 130 
> >>and
> >> 131 of the AST2500 datasheet v1.6.  Specifically, the COND2 
> >>requirement used to mux the surrounding pins to DVI was 
> >>inadvertently replicated to pins V1, W1, V2, and W2 in the table, 
> >>which do not incorporate DVI functionality.
> >> 
> >> As a result of this error, both serial TX lines and the PWM 0/1 
> >> outputs were overriding the VPO pinmux settings when VPO was 
> >> enabled in the pinmux hogs.
> >> 
> >> This patch has been verified to function on Blackbird hardware.  
> >> Both serial TXD pins and PWM0/PWM1 were functionally tested with 
> >> SCU94[1:0] set to 0x1.
> > 
> > Hello Tim.
> > 
> > The AST2500 pwm0/1 configure need following condition, the 
> > SCU94[1:0] is 0x1, it should not work.
> > Could you help confirm it?
> > 
> > v2 : pwm 0 : scu88[0] = 1 & scu 94[1:0] = 0 & scu90[5] = 0
> > w2 : pwm 1 : scu88[1] = 1 & scu 94[1:0] = 0 & scu90[5] = 0
> 
> >>I can confirm that with SCU94[1:0] == 0x1 the PWM0 and PWM1 outputs work correctly -- this was tested on our Blackbird >>hardware.  If you are reading from the datasheet, I suspect there are a few errors in it relating to the relatively rarely used DVO >>mux settings.
> 
> Yes it can work after check with designer, if you don't enable the CRT 
> driver, it will work.
> But for safety.

>>What do you mean by "for safety"?

Sorry, my point is if gfx driver also loaded, it will impact.
But, It is ok for this modification. Due to pinctrl gfx pwm is separate driver setting. 


> You need also and with COND2 for pwm driver loaded.

>>I'm confused here because it sounds like from Tim's experiment PWM0 / PWM1 work without the dependency on COND2 >>despite VPO being enabled, and the designer confirms as much, but we shouldn't do it?

>>Regardless, in summary you're saying that for TXD1 and RXD1 the change to remove the dependence on COND2 is appropriate, but not for PWM0 and PWM1?

> 
> 
>
