From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 20 Jun 2019 08:01:58 +0000
Subject: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor
In-Reply-To: <bdd53adb-6987-1b91-adde-298839b2c066@fb.com>
References: <20190619205009.4176588-1-taoren@fb.com>
 <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
 <18565fcf-3dc1-b671-f826-e4417e4ad284@fb.com>
 <c610ecede7494c189a92a9a3f6d0fd16@TWMBX02.aspeed.com>
 <bdd53adb-6987-1b91-adde-298839b2c066@fb.com>
Message-ID: <195bb56028d04001bbaf835cc17e032e@TWMBX02.aspeed.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Tao,
	Let me more clear. When you set (3, 15, 14) the device sometimes response nack. 
	but when you set (4, 7, 7), the device always ack. Am I right? 
Ryan

-----Original Message-----
From: Tao Ren [mailto:taoren at fb.com] 
Sent: Thursday, June 20, 2019 3:57 PM
To: Ryan Chen <ryan_chen@aspeedtech.com>; Brendan Higgins <brendanhiggins@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>; devicetree <devicetree@vger.kernel.org>; linux-aspeed at lists.ozlabs.org; OpenBMC Maillist <openbmc@lists.ozlabs.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Rob Herring <robh+dt@kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>; linux-i2c at vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor

On 6/20/19 12:29 AM, Ryan Chen wrote:
> Hello Tao,
> 	Our recommend about clk divider setting is follow the datasheet clock setting table for clock divisor. 
> 
> Ryan  

Thanks Ryan for the response. Could you also share some recommendations/hints on how to solve the intermittent i2c transaction failures on Facebook AST2500 BMC platforms?

BTW, the patch is not aimed at modifying the existing formula of calculating clock settings in i2c-aspeed driver: people still get the recommended settings by default. The goal of the patch is to allow people to customize clock settings in case the default/recommended one doesn't work.


Cheers, 

Tao
