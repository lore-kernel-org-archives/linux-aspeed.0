From: Joel Stanley <joel@jms.id.au>
Date: Fri, 13 Aug 2021 04:13:23 +0000
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
In-Reply-To: <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
 <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
Message-ID: <CACPK8XeoV8DqDNYFgK97r-Q0DebNjrmgUTydKSYmGt+3x=-vOQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 13 Aug 2021 at 03:40, Tao Ren <rentao.bupt@gmail.com> wrote:
>
> On Fri, Aug 13, 2021 at 01:29:17AM +0000, Joel Stanley wrote:
> > On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> > > +&mdio1 {
> > > +       status = "okay";
> >
> > You're enabling this but it looks like it's unused?
>
> Thanks Joel for the careful review. The MDIO controller is not paired
> with BMC MAC; instead, it's connected to the MDC/MDIO interface of the
> on-board switch (whose ports are connected to BMC, Host and front panel
> management port).

I see!

>
> In other word, the MDIO controller is used, but we do need some user
> space scripts to control the controller. What's your suggestion? For
> example, should I add some comments to explain the purpose?

Yes, that would make sense.

I've applied your patch, so if you want to add comments please send a
diff against this tree:

https://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git/log/?h=dt-for-v5.15
