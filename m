From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 1 May 2024 11:06:02 -0500
Subject: [PATCH v4 06/17] dt-bindings: fsi: Document the FSI controller
 common properties
In-Reply-To: <3bcc9143-6896-496b-aa30-7ac0fc2d8e51@kernel.org>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-7-eajames@linux.ibm.com>
 <3bcc9143-6896-496b-aa30-7ac0fc2d8e51@kernel.org>
Message-ID: <366b0cb8-1309-4f15-b4f0-077dfaf4250c@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/30/24 02:01, Krzysztof Kozlowski wrote:
> On 29/04/2024 23:01, Eddie James wrote:
>> +
>> +patternProperties:
>> +  "cfam@[0-9a-f],[0-9a-f]":
>> +    type: object
>> +    properties:
>> +      chip-id:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          Processor index
> fsi.txt tells a bit more about it, so extend the description.


Ack.


Thanks,

Eddie


>
>
>> +
>> +      reg:
>> +        maxItems: 1
>> +
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 1
>> +
>> +    required:
>> +      - reg
>> +
>> +    additionalProperties: true
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    fsi {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +
>> +        cfam at 0,0 {
>> +            reg = <0 0>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            chip-id = <0>;
>> +        };
>> +    };
> Drop the example, it's not being validated/used.


Ack.


>
> Best regards,
> Krzysztof
>
