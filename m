From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 9 Sep 2024 01:34:24 +0000
Subject: [PATCH v16 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
In-Reply-To: <e89bf774-12e3-4360-919e-f93148ce3456@kernel.org>
References: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906092438.1047225-2-Delphine_CC_Chiu@wiwynn.com>
 <e89bf774-12e3-4360-919e-f93148ce3456@kernel.org>
Message-ID: <TYZPR04MB5853405445CB5CC1B7E95A09D6992@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Friday, September 6, 2024 6:04 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v16 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux
> devices
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On 06/09/2024 11:24, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Revise Yosemite 4 devicetree for devices behind i2c-mux
> > - Add gpio and eeprom behind i2c-mux
> > - Remove redundant idle-state setting for i2c-mux
> > - Revise address of max31790 devices after i2c-mux.
> >
> > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Missing SoB. On all your patchsets.
> 
> Best regards,
> Krzysztof
Hi Krzysztof,
Sorry to bother you with the previous version of the patches.
We are reorganizing the patches and will run dts check before sending
the patches to kernel org.

I will update the SoB in the commits in v17 patches. Thanks.
