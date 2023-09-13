From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 13 Sep 2023 17:41:57 +0200
Subject: [PATCH 2/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC
 board
In-Reply-To: <CALFa7M_GvCgmEZxvo_ZSYoCPOe+9-tQt3KHn=_cu3n7psP+PTA@mail.gmail.com>
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-3-yangchen.openbmc@gmail.com>
 <1bfdc230-e358-6aa4-7d60-03b5477a6be9@linaro.org>
 <CALFa7M_GvCgmEZxvo_ZSYoCPOe+9-tQt3KHn=_cu3n7psP+PTA@mail.gmail.com>
Message-ID: <11c822f3-96f1-17d6-6c2a-feaa950aeea1@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/09/2023 15:57, Yang Chen wrote:
> Hi Krzysztof,
> 
>> +
>> +&i2c15 {
>> +     status = "okay";
>> +
>> +     eeprom at 50 {
>> +             compatible = "atmel,24c128";
>> +             reg = <0x50>;
>> +     };
>> +};
>> +
>> +&adc0 {
>> +     ref_voltage = <2500>;
> 
> There is no such property in the bindings.

Fix your email setup. This is my response, not yours.

> 
>> +     status = "okay";
>> +     pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
>> +             &pinctrl_adc2_default &pinctrl_adc3_default
>> +             &pinctrl_adc4_default &pinctrl_adc5_default
>> +             &pinctrl_adc6_default &pinctrl_adc7_default>;
>> +};
>> +
>> +&adc1 {
>> +     ref_voltage = <2500>;
> 
> NAK, there is no such property.
> 

So who says what?

> Thanks for your advice, I will change this property to
> "aspeed,int-vref-microvolt" which is defined in the binding in the v2 patch.

No, why? Drop it. There is no user.

Also, do not top post.



Best regards,
Krzysztof

