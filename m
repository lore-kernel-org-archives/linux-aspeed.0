From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Wed, 18 Sep 2024 03:12:50 +0000
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
In-Reply-To: <10de03e4-db98-4b5c-9cf6-3f98a5cc0537@kernel.org>
References: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
 <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
 <TYZPR04MB5853795FDC6497F7E0114E43D69A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <10de03e4-db98-4b5c-9cf6-3f98a5cc0537@kernel.org>
Message-ID: <TYZPR04MB58538354F2C7B6C767679308D6622@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Monday, September 16, 2024 4:51 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
> for pca9555
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On 10/09/2024 10:20, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> > I will revise in v2. Thanks!
> >>> +             interrupt-parent = <&gpio0>;
> >>> +             interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
> >>> +             gpio-line-names =
> >>> +             "P48V_OCP_GPIO1","P48V_OCP_GPIO2",
> >>
> >> Nothing improved here. I already commented about above and this.
> >> Implement feedback for all your patches, not only one.
> >>
> >> Best regards,
> >> Krzysztof
> > Sorry about that.
> > I saw you say "Broken alignment" in v15 patch.
> > Would like to ask if the following format meets your expectations?
> > +                     gpio-line-names =
> > +                             "P48V_OCP_GPIO1",
> "P48V_OCP_GPIO2",
> > +                             "P48V_OCP_GPIO3",
> > + "FAN_BOARD_0_REVISION_0_R",
> 
> Please read DTS coding style before posting next version of the patch (or any
> patch for DTS). This is still not aligned. There is (almost) never a blank line
> after '='.
> 
> Best regards,
> Krzysztof
Hi Krzysztof,
After checking the DTS coding style, I found the "Indentation" section mentioned that:
"For arrays spanning across lines, it is preferred to align the continued entries with opening < from the first line."

Should I align the code with following format? (No blank line after = and use two space to align the ")
Or would like to ask could you help to provide the dts file that I can follow?

gpio-line-names = "HSC1_ALERT1_R_N", "HSC2_ALERT1_R_N",
				  "HSC3_ALERT1_R_N", "HSC4_ALERT1_R_N",
				  "HSC5_ALERT1_R_N", "HSC6_ALERT1_R_N",
				  "HSC7_ALERT1_R_N", "HSC8_ALERT1_R_N",
				  "HSC1_ALERT2_R_N", "HSC2_ALERT2_R_N",
				  "HSC3_ALERT2_R_N", "HSC4_ALERT2_R_N",
				  "HSC5_ALERT2_R_N", "HSC6_ALERT2_R_N",
				  "HSC7_ALERT2_R_N", "HSC8_ALERT2_R_N";
Thanks.
