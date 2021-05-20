From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 20 May 2021 01:06:43 +0000
Subject: [v6 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
In-Reply-To: <20210519202004.GA3566127@robh.at.kernel.org>
References: <20210518005517.9036-1-billy_tsai@aspeedtech.com>
 <20210518005517.9036-2-billy_tsai@aspeedtech.com>
 <20210519202004.GA3566127@robh.at.kernel.org>
Message-ID: <37458AA4-17E4-4329-88A1-C18C0AFC47D5@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On 2021/5/20, 4:20 AM,Rob Herringwrote:

    On Tue, May 18, 2021 at 08:55:16AM +0800, Billy Tsai wrote:
    >   > +        };
    >   > +      };
    >   > +
    >   > +      tach: tach {
    >   > +        compatible = "aspeed,ast2600-tach";

    > Are pwm and tach separate h/w blocks? 

Yes, they are the separate h/w blocks.

    >   > +        #address-cells = <1>;
    >   > +        #size-cells = <0>;
    >   > +        pinctrl-names = "default";
    >   > +        pinctrl-0 = <&pinctrl_tach0_default>;
    >   > +        fan at 0 {
    >   > +          reg = <0>;

    > How does one configure which PWM is connected to each fan?
    > Existing bindings use 'reg' for PWM channel and another property for 
    > tach channel. Please don't do something different.

The fan node in this place specifically refers tach pin, maybe I need to change the naming to avoid confusion.
We just focus on the fan properties on this tach channel has nothing to do with pwm.

    > +          aspeed,min-rpm = <1000>;
    > +          aspeed,pulse-pr = <2>;
    > +          aspeed,tach-div = <5>;
    > +        };
    > +      };
    > +    };
    

