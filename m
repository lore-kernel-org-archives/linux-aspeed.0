From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Feb 2020 05:54:49 +0000
Subject: [PATCH v4 5/7] ARM: dts: aspeed-g5: add vhub port and endpoint
 properties
In-Reply-To: <c1f990ad2fd35deeba9e4e937cb19ee5080ea2a8.camel@kernel.crashing.org>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-6-rentao.bupt@gmail.com>
 <c1f990ad2fd35deeba9e4e937cb19ee5080ea2a8.camel@kernel.crashing.org>
Message-ID: <CACPK8XfALBpAUmvAmBLDGa-oEMaZSqaKsHjs0EEPYP=_riGJVA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2020 at 04:11, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-
> > endpoints"
> > properties to describe supported number of vhub ports and endpoints.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will take this patch through the aspeed tree for 5.7.

Cheers,

Joel


>
> > ---
> >  No change in v2/v3/v4.
> >    - It's given v4 to align with the version of the patch series.
> >
> >  arch/arm/boot/dts/aspeed-g5.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi
> > b/arch/arm/boot/dts/aspeed-g5.dtsi
> > index ebec0fa8baa7..f12ec04d3cbc 100644
> > --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> > @@ -195,6 +195,8 @@
> >                       reg = <0x1e6a0000 0x300>;
> >                       interrupts = <5>;
> >                       clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                     aspeed,vhub-downstream-ports = <5>;
> > +                     aspeed,vhub-generic-endpoints = <15>;
> >                       pinctrl-names = "default";
> >                       pinctrl-0 = <&pinctrl_usb2ad_default>;
> >                       status = "disabled";
>
