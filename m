From: Andi Shyti <andi.shyti@kernel.org>
Date: Sun, 12 Mar 2023 13:33:16 +0100
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <fc20a2d1-e2f9-c22b-dcdf-153cb527eea8@linaro.org>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
 <53090449-58c9-bc03-56df-aa8ae93c0c26@linaro.org>
 <SEZPR06MB52699DEB2255EB54F35C2A59F2AD9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <fc20a2d1-e2f9-c22b-dcdf-153cb527eea8@linaro.org>
Message-ID: <20230312123316.rn2qm3jnw7iy5yts@intel.intel>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof and Ryan,

> >>> +  aspeed,timeout:
> >>> +    type: boolean
> >>> +    description: I2C bus timeout enable for master/slave mode
> >>
> >> Nothing improved here in regards to my last comment.
> > 
> > Yes, as I know your require is about " DT binding to represent hardware setup"
> > So I add more description about aspeed,timeout as blow.
> > 
> > ASPEED SOC chip is server product, i2c bus may have fingerprint connect to another board. And also support hotplug.
> > The following is board-specific design example.
> > Board A                                         Board B
> > -------------------------                       ------------------------
> > |i2c bus#1(master/slave)  <===fingerprint ===> i2c bus#x (master/slave)|
> > |i2c bus#2(master)-> tmp i2c device |          |                       |
> > |i2c bus#3(master)-> adc i2c device |          |                       |
> > -------------------------                       ------------------------
> > 
> > aspeed,timout properites:
> > For example I2C controller as slave mode, and suddenly disconnected.
> > Slave state machine will keep waiting for master clock in for rx/tx transmit.
> > So it need timeout setting to enable timeout unlock controller state.
> > And in another side. In Master side also need avoid suddenly slave miss(un-plug), Master will timeout and release the SDA/SCL.
> > 
> > Do you mean add those description into ore aspeed,timout properites description?
> 
> You are describing here one particular feature you want to enable in the
> driver which looks non-scalable and more difficult to configure/use.
> What I was looking for is to describe the actual configuration you have
> (e.g. multi-master) which leads to enable or disable such feature in
> your hardware. Especially that bool value does not scale later to actual
> timeout values in time (ms)...
> 
> I don't know I2C that much, but I wonder - why this should be specific
> to Aspeed I2C and no other I2C controllers implement it? IOW, this looks
> quite generic and every I2C controller should have it. Adding it
> specific to Aspeed suggests that either we miss a generic property or
> this should not be in DT at all (because no one else has it...).

this property is missing in the i2c devicetree property and
because this is the second driver needing it, I think it should
be added.

To be clear, this timeout means that the SCL is kept low for some
number of milliseconds in order to force the slave to enter a
wait state. This is done when the master has some particular
needs as Ryan is describing.

It's defined in the i2c specification, while smbus defines it in
a range from 25 to 35 ms.

In any case it's not a boolean value unless the controller has it
defined internally by the firmware.

So... nack! Please, hold a bit, I'm sending a patch. 

Andi
