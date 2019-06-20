From: Tao Ren <taoren@fb.com>
Date: Thu, 20 Jun 2019 07:57:26 +0000
Subject: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor
In-Reply-To: <c610ecede7494c189a92a9a3f6d0fd16@TWMBX02.aspeed.com>
References: <20190619205009.4176588-1-taoren@fb.com>
 <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
 <18565fcf-3dc1-b671-f826-e4417e4ad284@fb.com>
 <c610ecede7494c189a92a9a3f6d0fd16@TWMBX02.aspeed.com>
Message-ID: <bdd53adb-6987-1b91-adde-298839b2c066@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/20/19 12:29 AM, Ryan Chen wrote:
> Hello Tao,
> 	Our recommend about clk divider setting is follow the datasheet clock setting table for clock divisor. 
> 
> Ryan  

Thanks Ryan for the response. Could you also share some recommendations/hints on how to solve the intermittent i2c transaction failures on Facebook AST2500 BMC platforms?

BTW, the patch is not aimed at modifying the existing formula of calculating clock settings in i2c-aspeed driver: people still get the recommended settings by default. The goal of the patch is to allow people to customize clock settings in case the default/recommended one doesn't work.


Cheers, 

Tao
