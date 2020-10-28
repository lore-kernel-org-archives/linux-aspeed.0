From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 09:50:26 +0000
Subject: [PATCH 1/3] ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to
 use v2 binding
In-Reply-To: <f35152af-34ad-178b-61db-0e57c8d19f3f@amd.com>
References: <20201027123722.2935-1-aladyshev22@gmail.com>
 <f35152af-34ad-178b-61db-0e57c8d19f3f@amd.com>
Message-ID: <CACPK8Xfr=Gd+oowhzZrLfAyVA7_J9=WhZGXUvfqXeu2XtP2A7Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2020 at 09:00, Supreeth Venkatesh
<supreeth.venkatesh@amd.com> wrote:
>
> These changes are already merged in https://github.com/openbmc/linux/blob/dev-5.8/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts by Joel.
> Please abandon these changes.

That is the openbmc kernel tree, where we stage patches on their way
to mainline. This submission is for mainline, where this patch has not
been merged.

Cheers,

Joel

>
> Thanks,
> Supreeth
>
> On 10/27/20 7:37 AM, Konstantin Aladyshev wrote:
> > [CAUTION: External Email]
> >
> > KCS nodes compatible property in the 'aspeed-g5.dtsi' file was
> > changed to use v2 binding in the commit fa4c8ec6feaa
> > ("ARM: dts: aspeed: Change KCS nodes to v2 binding").
> > For the proper initialization of /dev/ipmi-kcs* devices
> > KCS node variables also need to be changed to use v2 binding.
> >
> > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > index 60ba86f3e5bc..89ddc3847222 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > @@ -139,17 +139,17 @@
> >
> >  &kcs1 {
> >         status = "okay";
> > -       kcs_addr = <0x60>;
> > +       aspeed,lpc-io-reg = <0x60>;
> >  };
> >
> >  &kcs2 {
> >         status = "okay";
> > -       kcs_addr = <0x62>;
> > +       aspeed,lpc-io-reg = <0x62>;
> >  };
> >
> >  &kcs4 {
> >         status = "okay";
> > -       kcs_addr = <0x97DE>;
> > +       aspeed,lpc-io-reg = <0x97DE>;
> >  };
> >
> >  &lpc_snoop {
> > --
> > 2.17.1
> >
