From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 11 Sep 2020 12:53:35 +0300
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <CAJKOXPe6Tf0B5W27XaD5zLk77OBzGCHpirhTdZjFH0oh8GvWgg@mail.gmail.com>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
 <CACPK8XdocAX5mOXf3VP29cNXH+6unYunB9NiT3qFVKyzR6WXPg@mail.gmail.com>
 <CAJKOXPe6Tf0B5W27XaD5zLk77OBzGCHpirhTdZjFH0oh8GvWgg@mail.gmail.com>
Message-ID: <c162b6ad-57f1-a75a-11e3-9c80c60bd845@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 11/09/2020 09:52, Krzysztof Kozlowski wrote:
> On Fri, 11 Sep 2020 at 08:24, Joel Stanley <joel@jms.id.au> wrote:
>>
>> On Thu, 10 Sep 2020 at 17:57, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> Convert the NXP PCA953x family of GPIO expanders bindings to device tree
>>> schema.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>>> +patternProperties:
>>> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
>>> +    type: object
>>> +    properties:
>>> +      gpio-hog: true
>>> +      gpios: true
>>> +      input: true
>>> +      output-high: true
>>> +      output-low: true
>>> +      line-name: true
>>> +
>>> +    required:
>>> +      - gpio-hog
>>> +      - gpios
>>> +
>>
>>> +            usb3-sata-sel-hog {
>>> +                gpio-hog;
>>> +                gpios = <4 GPIO_ACTIVE_HIGH>;
>>> +                output-low;
>>> +                line-name = "usb3_sata_sel";
>>
>> I would prefer we didn't require the addition of hte -hog prefix. It's
>> mostly just a matter of taste, but I can think of a few more concrete
>> reasons:
>>
>> We don't require -high or -low prefixes, so the node name doesn't need
>> to describe the properties that will be found below.
> 
> Thanks for the comments.
> 
> It is not about properties (high or low) but the role of a device
> node. The node names should represent a generic class of device (ePAPR
> and device tree spec) and "hog" is such class.
> 
> The Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml already
> uses such naming so the best would be to unify.

In my opinion, It's not right to define this on per gpio-controller and introduce such
per gpio-controller restrictions.

More over, there is already generic schema for gpio hogs: gpio-hog.yaml
Originally, gpio bindings were defined without restricting gpio hog node names and,
generic schema follows this.

I think, the generic "gpio-hogs" sub-node may be introduced to place gpio hogs child nodes,
if gpio hogs node names restriction need to be introduces (*which i'm not sure is reasonable*).

gpio at 20 {
	gpio-hogs {
		yyy-hog {
                         gpio-hog;
                         gpios
		}
	}

But this require as gpio code as generic gpio schema update (with backward compatibility in mind).


> 
>>
>> Changing around node names for existing boards carries with it the
>> chance of userspace breakage (as sysfs paths change). I would prefer
>> we avoid that if possible.
> 
> The impact on userspace is indeed important, but are you sure that
> hogs are visible to user-space via sysfs and configurable? I guess you
> think of deprecated CONFIG_GPIO_SYSFS?
> 
> Rob,
> Any hints from you about hog-naming?
> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,
grygorii
