From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 12 Nov 2020 19:14:33 +0000
Subject: [PATCH] arm: dts: aspeed-bmc-tiogapass: enable second MAC
In-Reply-To: <CACPK8XdMXBUYZxYnvLeZ1V=mT6=uMhy6rNZ9dsksw0_yf6obeA@mail.gmail.com>
References: <20200930192507.27847-1-fercerpav@gmail.com>
 <CACPK8XdMXBUYZxYnvLeZ1V=mT6=uMhy6rNZ9dsksw0_yf6obeA@mail.gmail.com>
Message-ID: <21F4D101-0402-4401-AD11-2EB12406F86A@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/27/20, 10:51 PM, "Joel Stanley" <joel@jms.id.au> wrote:

    On Wed, 30 Sep 2020 at 19:27, Paul Fertser <fercerpav@gmail.com> wrote:
    >
    > Tioga Pass reference design includes Intel I210 Ethernet controller
    > connected to the BMC with NC/SI.
    >
    > MAC readout is not supported.
    >
    > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Reviewed-by: Vijay Khemka<vijaykhemkalinux@gmail.com>
Tested-by: Vijay Khemka<vijaykhemkalinux@gmail.com>


    Vijay, can I get a review from you on this one please?

Sorry Joel, for late response, I have tested and verified this yesterday

    > ---
    >  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 8 ++++++++
    >  1 file changed, 8 insertions(+)
    >
    > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > index 2d44d9ad4e40..b2ba798bf3c4 100644
    > --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > @@ -196,6 +196,14 @@
    >         use-ncsi;
    >  };
    >
    > +&mac1 {
    > +       status = "okay";
    > +
    > +       pinctrl-names = "default";
    > +       pinctrl-0 = <&pinctrl_rmii2_default>;
    > +       use-ncsi;
    > +};
    > +
    >  &adc {
    >         status = "okay";
    >  };
    > --
    > 2.17.1
    >

