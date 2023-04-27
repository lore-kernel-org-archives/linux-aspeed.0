From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 28 Apr 2023 07:58:50 +0800
Subject: [PATCH v3 3/3] i3c: ast2600: Add AST2600 platform-specific
 driver
In-Reply-To: <671a4bc0-526e-5224-7cb9-f80ebab2c0ef@linux.intel.com>
References: <20230331091501.3800299-1-jk@codeconstruct.com.au>
	 <20230331091501.3800299-4-jk@codeconstruct.com.au>
	 <671a4bc0-526e-5224-7cb9-f80ebab2c0ef@linux.intel.com>
Message-ID: <25ee56f181b11baa9ef54f13b6ef37977ee48b68.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi?Lukwinski,

> > +	case 545:
> > +		reg = AST2600_I3CG_REG0_SDA_PULLUP_EN_2K |
> > +			AST2600_I3CG_REG0_SDA_PULLUP_EN_750;
>
> It does not work. To enable PullUp=545R you need to set both 28 and
> 29 bit (0x30000000) but 'AST2600_I3CG_REG0_SDA_PULLUP_EN_2K |
> AST2600_I3CG_REG0_SDA_PULLUP_EN_750' is in fact 0x20000000.

Ah, good catch - I'd missed that the 2K is 0b00.

> Maybe you could consider adding extra macro
> 'AST2600_I3CG_REG0_SDA_PULLUP_EN_545' = (0x3 << 28)?

Sounds good, I'll send a fix today.

Cheers,


Jeremy
