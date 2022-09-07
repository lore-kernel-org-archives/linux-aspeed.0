From: Tao Ren <rentao.bupt@gmail.com>
Date: Tue, 6 Sep 2022 18:08:05 -0700
Subject: [PATCH net-next 2/2] ARM: dts: aspeed: elbert: Enable mac3
 controller
In-Reply-To: <YxfnkSAVq6FO0vd/@lunn.ch>
References: <20220905235634.20957-1-rentao.bupt@gmail.com>
 <20220905235634.20957-3-rentao.bupt@gmail.com>
 <YxaS2mS5vwW4HuqL@lunn.ch>
 <YxalTToannPyLQpI@taoren-fedora-PC23YAB4>
 <Yxc1N1auY5jk3yJI@lunn.ch>
 <45cdae58-632a-7cbb-c9d5-74c126ba6a3e@gmail.com>
 <YxfZOPz/iWVm0G5F@taoren-fedora-PC23YAB4>
 <YxfnkSAVq6FO0vd/@lunn.ch>
Message-ID: <Yxfu9bqIfGOMN0C4@taoren-fedora-PC23YAB4>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Wed, Sep 07, 2022 at 02:36:33AM +0200, Andrew Lunn wrote:
> > Specific to this Elbert platform, we don't have plan to configure
> > BCM53134 via OpenBMC MDIO (dts), because we expect the switch always
> > loads configurations from its EEPROM.
> 
> DSA offers more than configuration. You can also get interface
> statistics, and knowledge of if an interface is up/down. And since the
> PHY of the switch becomes normal Linux PHYs, you can do cable testing,
> if the PHY has support, etc.
> 
> Do you have spanning tree to break L2 network loops? Linux will
> provide that as well.
> 
> However, if you are happy with dumb switch, then what you posted is
> sufficient.
> 
> 	Andrew

Apprently I have very limited knowledge in DSA area, because I didn't
know these features.

I will keep the patch series as is for now, to at least enable ethernet
in Elbert OpenBMC, and will work out new patch series to add BCM53134 in
DSA later.

Thanks again for the review.


Cheers,

Tao

