From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 30 Sep 2024 01:56:51 +0000
Subject: [PATCH v1 2/5] ARM: dts: aspeed: yosemite4: remove led gpio
 pca9552 on fan boards
In-Reply-To: <0e9483a19f916982ba6996b81c2f1254da3801f3.camel@codeconstruct.com.au>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240926032821.4171466-3-Delphine_CC_Chiu@wiwynn.com>
 <0e9483a19f916982ba6996b81c2f1254da3801f3.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB585383DB1DD37DF3776BE945D6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Friday, September 27, 2024 1:43 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1 2/5] ARM: dts: aspeed: yosemite4: remove led gpio
> pca9552 on fan boards
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On Thu, 2024-09-26 at 11:28 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Remove led gpio contorller: pca9552 on fan boards since there is no
> > binding document for pca9552 currently.
> 
> That's not true, there is, just it's not converted to dt-schema:
> 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/t
> orvalds/linux.git/tree/Documentation/devicetree/bindings/leds/leds-pca955x.t
> xt?h=v6.11__;!!J63qqgXj!KJlZXg_GnpgYEsfLwrxkUEqwfsHkt_41jTnC09yd5VPAqT
> raqktY5p-KwUNQ3xPEbdockSD-knzTeOrQ8ijruq3-Q4c$
> 
> So the nodes can stay, though they probably generate warnings. The right way
> to fix this is to convert the binding document.
> 
> Andrew
> 
Hi Andrew,
Thanks for your suggestions.
I'll remain the nodes and provide the binding document in another patch.

Regards,
Ricky
