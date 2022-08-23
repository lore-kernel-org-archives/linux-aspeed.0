From: karthikeyan P <pkarthikeyan1509@gmail.com>
Date: Tue, 23 Aug 2022 10:41:51 +0530
Subject: [PATCH v1] ARM: dts: aspeed: Update for Facebook Yosemite V2 BMC
In-Reply-To: <CACPK8XfgYma8=qV0kKOKSSpXprC1sBZgKuaGsAhD1ifYG4KgTw@mail.gmail.com>
References: <20220822070204.GA6110@hcl-ThinkPad-T495> <CACPK8XfgYma8=qV0kKOKSSpXprC1sBZgKuaGsAhD1ifYG4KgTw@mail.gmail.com>
Message-ID: <CA+ezb7hkFc9DYUT8JbK7aEOb31NmXfhQzL=3xg6YtjKhr98Edg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Noted.

On Tue, Aug 23, 2022 at 5:31 AM Joel Stanley <joel@jms.id.au> wrote:

> On Mon, 22 Aug 2022 at 07:02, Karthikeyan Pasupathi
> <pkarthikeyan1509@gmail.com> wrote:
> >
> > This patch includes the following updates for Yosemite V2
> > BMC.
> >
> > 1) Updated GPIO configuration for power control.
>
> Please take a look the openbmc naming conventions for the GPIOs. If
> you are not going to follow them, please explain why in your commit
> message.
>
>
> > 2) Added IPMB-13 channel for Debug Card communication.
> > 3) Removed EEPROM driver IPMB-12 channel and keeping it as
> >    "status ok".
>
> If you find yourself writing a commit log that contains 1), 2), 3)
> then there's a fair chance you could have sent three separate patches.
> Consider this for next time.
>
> >
> > Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> > ---
> >  .../dts/aspeed-bmc-facebook-yosemitev2.dts    | 49 +++++++++++++++++--
> >  1 file changed, 44 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > index 8864e9c312a8..4d2ff7eb6740 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > @@ -119,6 +119,40 @@
> >                         &pinctrl_adc15_default>;
> >  };
> >
> > +&gpio {
> > +       status = "okay";
> > +       gpio-line-names =
> > +       /*A0-A7*/   "","","","","","","","",
> > +       /*B0-B7*/   "","","","","","","","",
> > +       /*C0-C7*/   "","","","","","","","",
> > +       /*D0-D7*/
>  "POWER_BUTTON","POWER_OUT1","","POWER_OUT2","","POWER_OUT3","","POWER_OUT4",
> > +       /*E0-E7*/
>  "DEBUG_UART_SEL0","DEBUG_UART_SEL1","DEBUG_UART_SEL2","DEBUG_UART_RX_SEL_N","","","","",
> > +       /*F0-F7*/   "","","","","","","","",
> > +       /*G0-G7*/
>  "LED_POST_CODE_0","LED_POST_CODE_1","LED_POST_CODE_2","LED_POST_CODE_3","","","","",
> > +       /*H0-H7*/   "","","","","","","","",
> > +       /*I0-I7*/
>  "SLOT1_POWER_OK","SLOT2_POWER_OK","SLOT3_POWER_OK","SLOT4_POWER_OK","","","","",
> > +       /*J0-J7*/   "","","","","","","","",
> > +       /*K0-K7*/   "","","","","","","","",
> > +       /*L0-L7*/   "","","","","","","","",
> > +       /*M0-M7*/   "","","","","","","","",
> > +       /*N0-N7*/
>  "","","I2C_SLOT1","I2C_SLOT2","I2C_SLOT3","I2C_SLOT4","","",
> > +       /*O0-O7*/
>  "","","","SELECTOR_BUTTON","SLOT1_POWER","SLOT2_POWER","SLOT3_POWER","SLOT4_POWER",
> > +       /*P0-P7*/
>  "","","","","LED_POST_CODE_4","LED_POST_CODE_5","LED_POST_CODE_6","LED_POST_CODE_7",
> > +       /*Q0-Q7*/   "","","","","","","","",
> > +       /*R0-R7*/   "","","","GPIO_DBG_CARD_PRSNT","","","","",
> > +       /*S0-S7*/
>  "RESET_OUT1","RESET_OUT2","RESET_OUT3","RESET_OUT4","","","","",
> > +       /*T0-T7*/   "","","","","","","","",
> > +       /*U0-U7*/   "","","","","","","","",
> > +       /*V0-V7*/   "","","","","","","","",
> > +       /*W0-W7*/   "","","","","","","","",
> > +       /*X0-X7*/   "","","","","","","","",
> > +       /*Y0-Y7*/   "","","","","","","","",
> > +       /*Z0-Z7*/
>  "POST_COMPLETE","POST_COMPLETE2","POST_COMPLETE3","POST_COMPLETE4","","","","",
> > +       /*AA0-AA7*/
> "","","","","HAND_SW1","HAND_SW2","HAND_SW3","HAND_SW4",
> > +       /*AB0-AB7*/ "RESET_BUTTON","","","","","","","",
> > +               /*AC0-AC7*/ "","","","","","","","";
> > +};
> > +
> >  &i2c1 {
> >         //Host1 IPMB bus
> >         status = "okay";
> > @@ -207,11 +241,16 @@
> >
> >  &i2c12 {
> >         status = "okay";
> > -       //MEZZ_FRU
> > -       eeprom at 51 {
> > -               compatible = "atmel,24c64";
> > -               reg = <0x51>;
> > -               pagesize = <32>;
> > +};
> > +
> > +&i2c13 {
> > +       status = "okay";
> > +       // Debug Card
> > +       multi-master;
> > +       ipmb13 at 10 {
> > +               compatible = "ipmb-dev";
> > +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> > +               i2c-protocol;
> >         };
> >  };
> >
> > --
> > 2.17.1
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220823/9c8206b5/attachment.htm>
