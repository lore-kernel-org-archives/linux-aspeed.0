From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 3 Nov 2022 07:39:27 +0000
Subject: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
In-Reply-To: <CAL_Jsq+eiFO9JyJW=2SB-HLHJLrXggO+7kwG8G-6Zt=K2QnFUA@mail.gmail.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-2-billy_tsai@aspeedtech.com>
 <20221101184033.GA1879756-robh@kernel.org>
 <C4090559-71D3-4DC4-A994-474D375DC4EF@aspeedtech.com>
 <CAL_Jsq+eiFO9JyJW=2SB-HLHJLrXggO+7kwG8G-6Zt=K2QnFUA@mail.gmail.com>
Message-ID: <294877DF-1EFB-4E62-9603-3586A13BE471@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2022/11/3, 2:19 AM, "Rob Herring" <robh@kernel.org> wrote:

    On Tue, Nov 1, 2022 at 10:21 PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
    
    > That all sounds like requirements that you have which you should
    > ensure the fan binding can support.

    > I've already said to use the PWM binding in the fan binding exactly
    > for the purpose of hooking up the PWMs to other things. Whether the
    > tach controller is useful for something other than fans, I don't know.
    > Seems less likely. The max6639 also has a tach controller. So if other
    > uses are possible for you, then it could be possible for any other h/w
    > like the max6639.

The linux kernel already have the similar binding:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/hwmon/pwm-fan.txt 
Therefore, I want to reuse it and the pwm-fan.c instead of creating another similar fan binding and driver.
I am referring to the following files:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/mfd/kontron%2Csl28cpld.yaml 
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/pwm/kontron%2Csl28cpld-pwm.yaml 
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/hwmon/kontron%2Csl28cpld-hwmon.yaml 
It will also reuse the pwm-fan instead creating it own pwm-fan binding for their hwmon(tach).
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts#L20 

Thanks

Best Regards,
Billy Tsai


