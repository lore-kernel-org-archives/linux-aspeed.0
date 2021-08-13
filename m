From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 12 Aug 2021 20:40:17 -0700
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
In-Reply-To: <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
Message-ID: <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 13, 2021 at 01:29:17AM +0000, Joel Stanley wrote:
> On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> > +&mdio1 {
> > +       status = "okay";
> 
> You're enabling this but it looks like it's unused?

Thanks Joel for the careful review. The MDIO controller is not paired
with BMC MAC; instead, it's connected to the MDC/MDIO interface of the
on-board switch (whose ports are connected to BMC, Host and front panel
management port).

In other word, the MDIO controller is used, but we do need some user
space scripts to control the controller. What's your suggestion? For
example, should I add some comments to explain the purpose?


Cheers,

Tao

> 
> > +};
> > +
> > +&mdio3 {
> > +       status = "okay";
> > +
> > +       ethphy1: ethernet-phy at 13 {
> > +               compatible = "ethernet-phy-ieee802.3-c22";
> > +               reg = <0x0d>;
> > +       };
> > +};
> > +
> > +&mac3 {
> > +       status = "okay";
> > +       phy-mode = "rgmii";
> > +       phy-handle = <&ethphy1>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_rgmii4_default>;
> > +};
