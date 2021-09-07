From: Oskar Senft <osk@google.com>
Date: Tue, 7 Sep 2021 19:40:41 -0400
Subject: [PATCH] ARM: dts: aspeed: Add TYAN S7106 BMC machine
In-Reply-To: <CACPK8Xd-2FeUh3+yeJ7T87Vz8+A94TqiYO1Am0Tk=5nDLbeVQQ@mail.gmail.com>
References: <20210907194931.1173750-1-osk@google.com>
 <CACPK8Xd-2FeUh3+yeJ7T87Vz8+A94TqiYO1Am0Tk=5nDLbeVQQ@mail.gmail.com>
Message-ID: <CABoTLcTHyfj+bOEyDM1HeZzbB=2AqK2vTqFO5UonDSYKpL0+Bw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey Joel

Thank you so much for the super fast review! So many things have changed a
bit since I worked on this DTS originally (years ago) - thanks for pointing
me to the updates! I'll make the changes as recommended.

> +&gpio {
>
> +       status = "okay";
> > +       gpio-line-names =
> > +       /*A0-A7*/       "","","IDLED_N","","","","","",
> > +       /*B0-B7*/       "","","","","","","","",
> > +       /*C0-C7*/       "","","","","ID_BUTTON","POST_COMPLETE","","",
> > +       /*D0-D7*/       "","","PS_PWROK","PLTRST_N","","","","",
> > +       /*E0-E7*/
>  "POWER_BUTTON","POWER_OUT","RESET_BUTTON","RESET_OUT",
> > +
>  "NMI_BUTTON","NMI_OUT","","HEARTBEAT_LED_N",
>
> We have a document that contains names for common BMC GPIOs:
>
>
> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> Ideally your device tree would use them, but given this is an old
> platform then I understand if you want to maintain compatibility with
> existing userspace.
>
> This is good to know! This is a "new" platform in the sense that we're
finally upstreaming (even if we have been running it for 2 years on an
older internal build). Also, this is going to be the basis for at least one
additional TYAN board, so I'd like to get it "as right as possible" to
avoid bad copy&paste. I was following the "standard" names from
x86-power-control (https://github.com/openbmc/x86-power-control) so I had
already renamed some of TYAN's original net names. With that, I'd be happy
to rename all of the signals to follow the OpenBMC standard.

Some questions on that, given that there are a few signals that don't have
an obvious equivalent in the GPIO naming doc:

   - Some LEDs and outputs are _N-ed, i.e. active low. Is there a good way
   to indicate that? This is important, e.g. for "ALERT".
   - There are some signals that are inputs but are not buttons, e.g.
   "PLTRST_N". Also, this particular example is active low.
   - There are a bunch of output signals that control muxes,
   e.g. BMC_PE_SMB_EN_1_N. Is there a naming convention for those?

Does it make sense for each OpenBMC signal to also indicate the original
net name from the schematics. I realize that not many people have access to
that, but it would be good for those who do. I'd rather document "too much"
than too little.

Thanks
Oskar.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210907/79a77abe/attachment.htm>
