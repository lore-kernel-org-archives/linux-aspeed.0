From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 20 May 2021 19:00:34 -0700
Subject: [PATCH 1/3] i2c: aspeed: avoid new registers definition of AST2600
In-Reply-To: <20210520033140.GA3656@aspeedtech.com>
References: <20210519080436.18975-1-jamin_lin@aspeedtech.com>
 <20210519080436.18975-2-jamin_lin@aspeedtech.com>
 <CACPK8XdNXiGMQZOtsfMMK+w_PSvO20XT8B9MG+rGhdjYoV4ZuQ@mail.gmail.com>
 <20210520033140.GA3656@aspeedtech.com>
Message-ID: <20210521020033.GB19153@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jamin,

On Thu, May 20, 2021 at 11:31:41AM +0800, Jamin Lin wrote:
> The 05/19/2021 22:59, Joel Stanley wrote:
> > On Wed, 19 May 2021 at 08:05, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> > >
> > > The register definition between AST2600 A2 and A3 is different.
> > > This patch avoid new registers definition of AST2600 to use
> > > this driver. We will submit the path for the new registers
> > > definition of AST2600.
> > 
> > The AST2600 v9 datasheet says that bit 2 selects between old and new
> > register sets, and that the old register set is the default.
> > 
> > Has the default changed for the A3?, and the datasheet is incorrect?
> > 
> > Does the A3 still support the old register set?
> > 
> We suggest user to use the new i2c driver for AST2600 and we will sumbit
> it. This driver is used to AST2500 and AST2400 SOCs. Change this
> driver to check global register of i2c to avoid user build the wrong driver. 

If I understand correctly, the answer implies old register set is still
supported in A3 although aspeed suggest people using the new driver/mode?

Can you please share more context behind the suggestion? Such as new
register mode has better performance? Or some known issues that were
deteted in old mode are fixed in new register mode?


Cheers,

Tao
