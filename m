From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 23 Feb 2023 10:25:56 +0000
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <5c255eb3-ec9e-d66f-4a2b-ccc32edf5672@linaro.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <676c7777-635c-cc1f-b919-d33e84a45442@linaro.org>
 <TYZPR06MB527427ADCCD29DFD77FB0EE3F2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <80d873d4-d813-6c25-8f47-f5ff9af718ec@linaro.org>
 <SEZPR06MB5269502D7CBCD5698B65FF9FF2A59@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <c0ac0ab3-87fc-e74a-b4e2-3cf1b3a8a5e2@linaro.org>
 <SEZPR06MB52698CCA6AE59DDC6C15CBE4F2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <94238c42-1250-4d51-86e5-0a960dea0ffc@linaro.org>
 <SEZPR06MB52696835ED8E2709D6A454DAF2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <b7ca24ea-a265-81cb-3da6-19f938b35878@linaro.org>
 <SEZPR06MB5269052D7ADCD0D0F939E60DF2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <5c255eb3-ec9e-d66f-4a2b-ccc32edf5672@linaro.org>
Message-ID: <SEZPR06MB52697747528490B1A16AF87FF2AB9@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, February 23, 2023 5:29 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
> 
> On 22/02/2023 11:47, Ryan Chen wrote:
> >>>> connector. That slave will keep state to drive clock stretching.
> >>>>> So it is specific enable in i2c bus#1. Others is not needed enable
> timeout.
> >>>>> Does this draw is more clear in scenario?
> >>>>
> >>>> I2C bus #1 works in slave mode? So you always need it for slave work?
> >>>
> >>> Yes, it is both slave/master mode. It is always dual role. Slave
> >>> must always
> >> work.
> >>> Due to another board master will send.
> >>
> >> I meant that you need this property when it works in slave mode? It
> >> would be then redundant to have in DT as it is implied by the mode.
> >
> > But timeout feature is also apply in master. It for avoid suddenly
> > slave miss(un-plug) Master can timeout and release the SDA/SCL, return.
> 
> OK, yet the property should describe the hardware, not the register feature you
> want to program. You need to properly model it in DT binding to represent
> hardware setup, not your desired Linux driver behavior.
> 
> >>>>> The same draw, in this case, i2c bus#1 that is multi-master
> >>>>> transfer
> >>>> architecture.
> >>>>> Both will inactive with trunk data. That cane enable i2c#1 use DMA
> >>>>> transfer
> >>>> to reduce CPU utilized.
> >>>>> Others (bus#2/3) can keep byte/buff mode.
> >>>>
> >>>> Isn't then current bus configuration for I2C#1 known to the driver?
> >>>> Jeremy asked few other questions around here...
> >>>
> >>> No, The driver don't know currently board configuration.
> >>
> >> It knows whether it is working in multi-master/slave mode.
> >
> > But in DT can decide which i2c bus number can use dma or buffer mode
> transfer.
> > If in another i2c bus support master only, also can use dma to transfer trunk
> data to another slave.
> 
> and none of these were explained in commit msg or device description.
> 
Thanks your guidance. I will add all those discussion in next patches cover-letter.
Best regards,
Ryan Chen.
