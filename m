From: Tao Ren <rentao.bupt@gmail.com>
Date: Mon, 16 Aug 2021 17:01:49 -0700
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
In-Reply-To: <YRfgv5OknMluW7jj@lunn.ch>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
 <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
 <YRaFpq1LvRzMYr/A@lunn.ch>
 <20210814052228.GA1298@taoren-ubuntu-R90MNF91>
 <YRfgv5OknMluW7jj@lunn.ch>
Message-ID: <20210817000148.GA7547@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Aug 14, 2021 at 05:26:55PM +0200, Andrew Lunn wrote:
> > Thanks for jumping in. We are using BCM5389 and the MDIO bus is used to
> > access BCM5389 MDC/MDIO interface in Pseudo-PHY mode.
> > 
> > I didn't know drivers/net/dsa, but let me check out the drivers and see
> > if it works in the Cloudripper environment.
> 
> The b53 driver knows about this switch, so please make use of that
> driver. See Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> for how you describe it in DT.
> 
>     Andrew

Thank you Andrew for looking into it. I will update dts and send out
followup patch after validation (perhaps after v5.15 merge window).


Thanks,

Tao
