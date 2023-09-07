From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Sep 2023 14:43:51 -0500
Subject: [PATCH v8 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
In-Reply-To: <SG2PR06MB336567E43537C7F4947E342F8BEEA@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-2-billy_tsai@aspeedtech.com>
 <20230905170010.GA3505375-robh@kernel.org>
 <SG2PR06MB336567E43537C7F4947E342F8BEEA@SG2PR06MB3365.apcprd06.prod.outlook.com>
Message-ID: <20230907194351.GA2033402-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 07, 2023 at 07:17:55AM +0000, Billy Tsai wrote:
> On Wed, Aug 30, 2023 at 08:32:00PM +0800, Billy Tsai wrote:
> >> From: Naresh Solanki <naresh.solanki@9elements.com>
> >> 
> >> Add common fan properties bindings to a schema.
> >> 
> >> Bindings for fan controllers can reference the common schema for the
> >> fan


> >> +properties:
> >> +  max-rpm:
> >> +    description:
> >> +      Max RPM supported by fan.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> > Physics will limit this to something much less than 2^32. Add some 
> > constraints. 10000?
> 
> 
> >> +
> >> +  min-rpm:
> >> +    description:
> >> +      Min RPM supported by fan.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> > ditto
> 
> >> +
> >> +  pulses-per-revolution:
> >> +    description:
> >> +      The number of pulse from fan sensor per revolution.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> >Needs constraints. I assume this is never more than 4 (or 2 even)?
> 
> Do you think we should add the contraint in the common binding?
> In my option, the limit of the max/min rpm should be declared by
> the binding if necessary, because the usage of each fan monitor is
> based on the connection of the tach pin.

Yes, I think we should have default limits.

Unless we go as far as a schema for every specific fan model, then there 
is actually no way we can have specific limits unless the fan 
controllers have some limits.

The most I see in tree for pulses-per-revolution is 2. There's no value 
in more. So set the max to 4 and then if anyone needs more they can bump 
the value.

Or maybe there's some electrical/mechanical design reason fans are 1 or 
2 pulses and we'll never see anything else? This document[1] seems to 
indicate that is indeed the case. (First hit googling "fan tach signal 
pulses")

> 
> 
> >> +  div:
> 
> > Too generic of a name.
> 
> >> +    description:
> >> +      Fan clock divisor
> 
> > But what is a fan clock?
> 
> This is the divisor for the tachometer sampling clock, which determines the sensitivity of the tach pin.
> So, if the name of the property changes to 'tach-div,' is it acceptable to you?

That sounds like a property of the controller, not the fan, so it 
belongs in the controller binding. Is this really a common thing?

 
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +
> >> +  target-rpm:
> >> +    description:
> >> +      Target RPM the fan should be configured during driver probe.
> 
> > What driver? By the time the OS driver runs, a bunch of other boot 
> > software has already run on modern systems. So this value would likely 
> > be used much earlier. The point is that when exactly is outside the 
> > scope of DT. This is "what RPM do I use in case of no other information 
> > (e.g. temperature)".
> 
> So, the description should be changed to 'The default desired fan speed in RPM,'
> and we shouldn't mention the timing of the property's operation in the DT, is that correct?

Correct.

> 
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +
> >> +  mode:
> 
> > Too generic.
> 
> >> +    description:
> >> +      Select the operational mode of the fan.
> 
> > What are modes? Spin and don't spin?
> 
> The mode is used to indicate the driving mode of the fan (DC, PWM and so on).
> So, if the name of the property changes to 'fan-driving-mode,' is it acceptable to you?

I tend to think that should be implied from the parent node and/or other 
properties. PWM if "pwms" property is present. DC if the supply is 
variable. We could also use compatible strings in the fan nodes if 
there's a need.

That reminds me, both of these modes probably need a table of 
voltage/duty-cycle to RPMs. I imagine it's not always a linear response.  
Naresh also privately sent me (don't do that) an updated common binding 
which we discussed the need for this. I expect him to comment further 
with details.


> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +
> >> +  pwms:
> >> +    description:
> >> +      PWM provider.
> 
> > maxItems: 1
> 
> > I don't think there are fans with more than 1 PWM input?
> 
> Ok, I will add the constraint for the pwm input.
> 
> >> +
> >> +  tach-ch:
> >> +    description:
> >> +      The tach channel used for the fan.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> > The existing ASpeed version of this property allows more than 1 entry. I 
> > don't understand how a fan would have 2 tach signals, but if so, the 
> > generic property should allow for that.
> 
> Ok, I will modify it to the uint32-array

Perhaps uint8-array to align with existing versions of the property.

> 
> > Perhaps 'reg' should be defined in here with some text saying 'reg' 
> > corresponds to the fan controller specific id which may be the PWM+TACH 
> > channel, PWM channel (deprecated), or TACH channel. I think there are 
> > examples of all 3 of these cases.
> 
> I don't think it's necessary for the 'reg' because the case you mentioned is
> already covered by the property 'tach-ch' and the 'pwms'.

Yes, but when we have N child nodes of the same thing, we usually have 
"reg" and its value corresponds to how the parent identifies each child. 
We already have a mixture using PWM or tach channel. Yes, this can all 
just be in the fan controllers binding, but putting it here would just 
document the options.

Rob


[1] http://www.comairrotron.com/methods-monitoring-fan-performance
