From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 2 May 2024 14:58:39 +0200
Subject: [PATCH v4 10/17] dt-bindings: i2c: i2c-fsi: Convert to
 json-schema
In-Reply-To: <1ebaaa48-9812-467e-9189-c1cd3369b6cb@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-11-eajames@linux.ibm.com>
 <bbf12675-e0f5-4150-96d1-097eb7abd81a@kernel.org>
 <1ebaaa48-9812-467e-9189-c1cd3369b6cb@linux.ibm.com>
Message-ID: <59cdb557-cffd-41f3-b487-2f1890e7cac3@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/05/2024 18:16, Eddie James wrote:
> 
> On 4/30/24 02:35, Krzysztof Kozlowski wrote:
>> On 29/04/2024 23:01, Eddie James wrote:
>>> Convert to json-schema for the FSI-attached I2C controller.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>> Changes since v3:
>>>   - Update MAINTAINERS
>>>   - Change commit message to match similar commits
>>>
>>>   .../devicetree/bindings/i2c/i2c-fsi.txt       | 40 -------------
>>>   .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml  | 58 +++++++++++++++++++
>>
>> Please split independent patches to separate patchsets, so they can be
>> reviewed and picked up by respective maintainers.
>>
>> I don't see any dependency here. Neither in 1st patch.
> 
> 
> OK, I guess that makes it complicated for Andrew to pull together with 
> the device tree changes in a way that avoids warnings, but I agree there 
> is no direct dependency.

SoC tree should not pull subsystem patches. Plus DTS must be separate
from drivers...


>>> +
>>> +examples:
>>> +  - |
>>> +    i2c at 1800 {
>>> +        compatible = "ibm,i2c-fsi";
>>> +        reg = <0x1800 0x400>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        i2c-bus at 0 {
>>> +            reg = <0>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>> This does not look right. Why do you have multiple i2c-bus children? I
>> do not think i2c-controller.yaml schema allows this.
> 
> 
> It does seem to allow it, as this validates here and in the device tree. 

Only because children are treated as I2C devices.

> It is this way because the I2C controller provides multiple busses. 

It does not look like I2C controller anymore. I think I2C controller
sits on the bus, not on multiple busses. How are SDA/SCL lines connected?

This looks like you are describing something which is not I2C bus
controller as I2C bus controller...

I'll let I2C maintainer comment on that - is this real I2C bus which
consists of multiple buses.


> Should I change it so to add "bus" pattern properties that reference 
> i2c-controller.yaml?

Not sure if I get it right... whatever is the I2C bus controller, should
reference i2c-controller.yaml. Not some other entity.

Best regards,
Krzysztof

