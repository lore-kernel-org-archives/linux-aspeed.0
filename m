From: Tao Ren <rentao.bupt@gmail.com>
Date: Fri, 1 Nov 2019 10:42:57 -0700
Subject: [PATCH 1/4] ARM: dts: aspeed: add dtsi for Facebook AST2500
 Network BMCs
In-Reply-To: <CACPK8XfebA9PcpyWkofCJ5fAZ9ddUjQ4ZeCf73KXb51+k_+N1Q@mail.gmail.com>
References: <20191021194820.293556-1-taoren@fb.com>
 <20191021194820.293556-2-taoren@fb.com>
 <CACPK8XfebA9PcpyWkofCJ5fAZ9ddUjQ4ZeCf73KXb51+k_+N1Q@mail.gmail.com>
Message-ID: <20191101174257.GB13557@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 01, 2019 at 10:12:10AM +0000, Joel Stanley wrote:
> On Mon, 21 Oct 2019 at 19:49, Tao Ren <taoren@fb.com> wrote:
> >
> > Introduce "facebook-netbmc-ast2500-common.dtsi" which is included by all
> > Facebook AST2500 Network BMC platforms. The major purpose is to minimize
> > duplicated device entries cross Facebook Network BMC dts files.
> >
> 
> > +
> > +&mac1 {
> > +       status = "okay";
> > +       no-hw-checksum;
> 
> Was this included to work around the IPv6 issue that Benh recently fixed?
> 
> If you can test your platform with
> 88824e3bf29a2fcacfd9ebbfe03063649f0f3254 applied and the
> no-hw-checksum property removed, please send a follow up to remove
> this property.
> 
> It's not doing any harm, but by cleaning it up there's less chance
> others blindly copy the same thing.
> 
> Thanks,
> 
> Joel

Yes. I'm planning to try the patch. Will send out a followup patch to
remove the line if everything goes fine.

Cheers,

Tao

> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> > +};
