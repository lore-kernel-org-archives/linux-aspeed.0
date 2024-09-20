From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Fri, 20 Sep 2024 07:57:01 +0000
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
In-Reply-To: <63ce2d4b7edc52952a5f1bb97eb4dc8e7305045f.camel@codeconstruct.com.au>
References: <20240910030324.2256698-1-Delphine_CC_Chiu@wiwynn.com>
 <63ce2d4b7edc52952a5f1bb97eb4dc8e7305045f.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB585344D2C4C75DE832F4E9B2D66C2@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Thursday, September 12, 2024 10:19 AM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On Tue, 2024-09-10 at 11:03 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Enable spi-gpio setting for spi flash in yosemite4.
> 
> Is there actually a flash chip on the same bus? You've only described a TPM. If
> there's no flash then this seems misleading.
> 
> Andrew
> 
Hi Andrew,

There is only TPM on the bus.
Modified the commit message in V2.

Thanks.
