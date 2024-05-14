From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 14 May 2024 10:38:52 -0500
Subject: [PATCH v4 08/17] dt-bindings: fsi: ast2600-fsi-master: Convert to
 json-schema
In-Reply-To: <0a43b522-7c07-43a0-b4b0-155c3cf94177@kernel.org>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-9-eajames@linux.ibm.com>
 <af51132f-e4a3-4f45-b066-24b8c348eb28@kernel.org>
 <a7ca71c0-971c-49ab-b9f3-f6e6b32e9567@linux.ibm.com>
 <0a43b522-7c07-43a0-b4b0-155c3cf94177@kernel.org>
Message-ID: <18011b0e-a479-4d93-947a-a71fe4efdcb5@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/4/24 06:55, Krzysztof Kozlowski wrote:
> On 01/05/2024 18:12, Eddie James wrote:
>> On 4/30/24 02:04, Krzysztof Kozlowski wrote:
>>> On 29/04/2024 23:01, Eddie James wrote:
>>>> Convert to json-schema for the AST2600 FSI master documentation.
>>> Please mention all the changes from pure conversion.
>>
>> Sure.
>>
>>
>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>> ---
>>>> Changes since v3:
>>>>    - Remove quotes around compatible strings
>>>>    - Re-order allOf to below required
>>>>    - Add child node in the example
>>>>    - Change commit message to match similar commits
>>>>
>>>>    .../fsi/aspeed,ast2600-fsi-master.yaml        | 81 +++++++++++++++++++
>>>>    .../bindings/fsi/fsi-master-aspeed.txt        | 36 ---------
>>>>    2 files changed, 81 insertions(+), 36 deletions(-)
>>>>    create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
>>>>    delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
>>>> new file mode 100644
>>>> index 000000000000..fcf7c4b93b78
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
>>>> @@ -0,0 +1,81 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Aspeed FSI master
>>>> +
>>>> +maintainers:
>>>> +  - Eddie James <eajames@linux.ibm.com>
>>>> +
>>>> +description:
>>>> +  The AST2600 and later contain two identical FSI masters. They share a
>>>> +  clock and have a separate interrupt line and output pins.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - aspeed,ast2600-fsi-master
>>>> +      - aspeed,ast2700-fsi-master
>>> There was no such compatible before.
>>>
>>> How does this even validate? Where is fsi-master? You dropped a
>>> compatible without any explanation.
>>
>> I can make it a separate change to add ast2700.
>>
>>
>> I suppose I don't understand having two compatibles... Aspeed master
>> shouldn't use "fsi-master" as that is too generic, right? Why wouldn't
> Not necessarily, depends. Dropping it silently is confusing. What about
> other users? firmware, bootloaders, out-of-tree, other OS? Did you
> investigate all of them?


The old format file actually only used fsi-master in the example, not in 
the actual properties description. So I didn't really drop a compatible. 
Device trees using "fsi-master" are just buggy and should be fixed 
eventually, but I don't think it needs to be part of this series.


Thanks,

Eddie



>
>> it validate? Devicetrees using "fsi-master" also use
>> "aspeed,ast2600-fsi-master" so they should be OK...
> No, because the compatibles do not match. Run validation and you will
> see the errors.
>
> I am fine with dropping such compatible, which is not used by current
> kernel ABI, but first DTS must be fixed and second some explanation and
> justification is needed.
>
> Best regards,
> Krzysztof
>
