From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 7 Sep 2022 02:36:33 +0200
Subject: [PATCH net-next 2/2] ARM: dts: aspeed: elbert: Enable mac3
 controller
In-Reply-To: <YxfZOPz/iWVm0G5F@taoren-fedora-PC23YAB4>
References: <20220905235634.20957-1-rentao.bupt@gmail.com>
 <20220905235634.20957-3-rentao.bupt@gmail.com>
 <YxaS2mS5vwW4HuqL@lunn.ch>
 <YxalTToannPyLQpI@taoren-fedora-PC23YAB4>
 <Yxc1N1auY5jk3yJI@lunn.ch>
 <45cdae58-632a-7cbb-c9d5-74c126ba6a3e@gmail.com>
 <YxfZOPz/iWVm0G5F@taoren-fedora-PC23YAB4>
Message-ID: <YxfnkSAVq6FO0vd/@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Specific to this Elbert platform, we don't have plan to configure
> BCM53134 via OpenBMC MDIO (dts), because we expect the switch always
> loads configurations from its EEPROM.

DSA offers more than configuration. You can also get interface
statistics, and knowledge of if an interface is up/down. And since the
PHY of the switch becomes normal Linux PHYs, you can do cable testing,
if the PHY has support, etc.

Do you have spanning tree to break L2 network loops? Linux will
provide that as well.

However, if you are happy with dumb switch, then what you posted is
sufficient.

	Andrew
