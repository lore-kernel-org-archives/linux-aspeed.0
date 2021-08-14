From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 14 Aug 2021 17:26:55 +0200
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
In-Reply-To: <20210814052228.GA1298@taoren-ubuntu-R90MNF91>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
 <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
 <YRaFpq1LvRzMYr/A@lunn.ch>
 <20210814052228.GA1298@taoren-ubuntu-R90MNF91>
Message-ID: <YRfgv5OknMluW7jj@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Thanks for jumping in. We are using BCM5389 and the MDIO bus is used to
> access BCM5389 MDC/MDIO interface in Pseudo-PHY mode.
> 
> I didn't know drivers/net/dsa, but let me check out the drivers and see
> if it works in the Cloudripper environment.

The b53 driver knows about this switch, so please make use of that
driver. See Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
for how you describe it in DT.

    Andrew
