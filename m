From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Nov 2020 06:01:03 +0000
Subject: [PATCH] arm: dts: aspeed-bmc-tiogapass: enable second MAC
In-Reply-To: <21F4D101-0402-4401-AD11-2EB12406F86A@fb.com>
References: <20200930192507.27847-1-fercerpav@gmail.com>
 <CACPK8XdMXBUYZxYnvLeZ1V=mT6=uMhy6rNZ9dsksw0_yf6obeA@mail.gmail.com>
 <21F4D101-0402-4401-AD11-2EB12406F86A@fb.com>
Message-ID: <CACPK8XemKa2q8Yon8oe1mSP_WsDkogLaM9ARwQCBUUhaya_hBQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2020 at 19:14, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
>
>
> ?On 10/27/20, 10:51 PM, "Joel Stanley" <joel@jms.id.au> wrote:
>
>     On Wed, 30 Sep 2020 at 19:27, Paul Fertser <fercerpav@gmail.com> wrote:
>     >
>     > Tioga Pass reference design includes Intel I210 Ethernet controller
>     > connected to the BMC with NC/SI.
>     >
>     > MAC readout is not supported.
>     >
>     > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> Reviewed-by: Vijay Khemka<vijaykhemkalinux@gmail.com>
> Tested-by: Vijay Khemka<vijaykhemkalinux@gmail.com>
>
>
>     Vijay, can I get a review from you on this one please?
>
> Sorry Joel, for late response, I have tested and verified this yesterday

Thanks for taking a look.

Paul, in the future please use scripts/get_maintainers.pl in the
kernel tree to send this patch to the correct location. Importantly,
you should cc linux-arm-kernel and myself (as the maintainer).

I've merged this for 5.11.

Cheers,

Joel
>
>     > ---
>     >  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 8 ++++++++
>     >  1 file changed, 8 insertions(+)
>     >
>     > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>     > index 2d44d9ad4e40..b2ba798bf3c4 100644
>     > --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>     > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>     > @@ -196,6 +196,14 @@
>     >         use-ncsi;
>     >  };
>     >
>     > +&mac1 {
>     > +       status = "okay";
>     > +
>     > +       pinctrl-names = "default";
>     > +       pinctrl-0 = <&pinctrl_rmii2_default>;
>     > +       use-ncsi;
>     > +};
>     > +
>     >  &adc {
>     >         status = "okay";
>     >  };
>     > --
>     > 2.17.1
>     >
>
