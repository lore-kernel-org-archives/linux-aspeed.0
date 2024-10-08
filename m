From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Tue, 8 Oct 2024 03:13:12 +0000
Subject: [PATCH v2 7/9] arm64: defconfig: Add ASPEED AST2700 family
 support
In-Reply-To: <9795437d-b409-4105-9583-4dcb24b5a06c@app.fastmail.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-9-kevin_chen@aspeedtech.com>
 <CAA8EJprcmQvE3PjySxBKq7Qv3JHJHhic2aQ5MDnwZaf-D=K2Rw@mail.gmail.com>
 <9795437d-b409-4105-9583-4dcb24b5a06c@app.fastmail.com>
Message-ID: <PSAPR06MB494936C8FB5CAF373264F384897E2@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> >>
> >> Enable CONFIG_ARCH_ASPEED in arm64 defconfig.
> >
> > Why? Usually the defconfig changes have "Enable CONFIG_FOO as it is
> > used on the Bar Baz platform" commit message.
> 
> I would also expect to see aspeed specific device drivers to get enabled in the
> same commit. On arm32, I see
For different device drivers, ASPEED would submit code by its owner with CONFIG enabled.

> 
> CONFIG_ASPEED_KCS_IPMI_BMC=m
> CONFIG_ASPEED_BT_IPMI_BMC=m
> CONFIG_I2C_ASPEED=m
> CONFIG_SPI_ASPEED_SMC=m
> CONFIG_GPIO_ASPEED_SGPIO=y
> CONFIG_SENSORS_ASPEED=m
> CONFIG_VIDEO_ASPEED=m
> CONFIG_DRM_ASPEED_GFX=m
> CONFIG_USB_ASPEED_VHUB=m
> CONFIG_RTC_DRV_ASPEED=m
> CONFIG_ASPEED_LPC_CTRL=m
> CONFIG_ASPEED_LPC_SNOOP=m
> CONFIG_ASPEED_P2A_CTRL=m
> CONFIG_ASPEED_ADC=m
> CONFIG_FSI_MASTER_ASPEED=m
> 
> Presumably not all but a lot of these are also used on AST2700.
> 
>      Arnd
