From: Joel Stanley <joel@jms.id.au>
Date: Wed, 23 Jun 2021 01:28:29 +0000
Subject: [PATCH] ARM: dts: aspeed: Everest PSU #3 address change
In-Reply-To: <d0e66d10765ae85b1bd939ddacc7f7d861190196.camel@linux.ibm.com>
References: <20210610202940.3650554-1-bjwyman@gmail.com>
 <d0e66d10765ae85b1bd939ddacc7f7d861190196.camel@linux.ibm.com>
Message-ID: <CACPK8XcvJZYex4crPDz-uSpqLymA2=SseyO+fK1_qCnopRffFA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 21 Jun 2021 at 19:09, Eddie James <eajames@linux.ibm.com> wrote:
>
> On Thu, 2021-06-10 at 20:29 +0000, Brandon Wyman wrote:
> > From: "B. J. Wyman" <bjwyman@gmail.com>
> >
> > The third power supply had an I2C address conflict with another
> > device
> > in the system. The device will have the address changed from 6Ah to
> > 6Dh.
>
> Thanks Brandon.
>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

I've applied this to dev-5.10.

I'll try to remember to get the change upstream too.

>
> >
> > Signed-off-by: B. J. Wyman <bjwyman@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> > b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> > index 3295c8c7c05c..480cb6604c7d 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> > @@ -536,9 +536,9 @@ power-supply at 69 {
> >               reg = <0x69>;
> >       };
> >
> > -     power-supply at 6a {
> > +     power-supply at 6d {
> >               compatible = "ibm,cffps";
> > -             reg = <0x6a>;
> > +             reg = <0x6d>;
> >       };
> >
> >       power-supply at 6b {
>
