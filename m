From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 15 Apr 2024 10:03:14 -0500
Subject: [PATCH 1/3] dt-bindings: fsi: Document the IBM SBEFIFO engine
In-Reply-To: <95510c550a31305ae192640ce54ed86544e79f12.camel@codeconstruct.com.au>
References: <20240412144358.204129-1-eajames@linux.ibm.com>
 <20240412144358.204129-2-eajames@linux.ibm.com>
 <95510c550a31305ae192640ce54ed86544e79f12.camel@codeconstruct.com.au>
Message-ID: <0752bfea-af49-4483-81a2-0b6fba2feb91@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/14/24 19:50, Andrew Jeffery wrote:
> On Fri, 2024-04-12 at 09:43 -0500, Eddie James wrote:
>> The SBEFIFO engine provides an interface to the POWER processor
>> Self Boto Engine (SBE).
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/fsi/ibm,sbefifo.yaml  | 39 +++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml b/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml
>> new file mode 100644
>> index 000000000000..d70012e42d79
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml
>> @@ -0,0 +1,39 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fsi/ibm,sbefifo.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IBM FSI-attached SBEFIFO engine
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description: |
>> +  This binding describes an FSI CFAM engine called the SBEFIFO. Therefore this
>> +  node will always be a child of an FSI CFAM node; see fsi.txt for details on
>> +  FSI slave and CFAM nodes. This SBEFIFO engine provides an interface to the
>> +  POWER processor Self Boot Engine (SBE).
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,p9-sbefifo
>> +      - ibm,ody-sbefifo
> Bit of a nitpick, but: Is there any argument against using
> `ibm,odyssey-sbefifo`? Feels less cryptic.


True, that might be better.


>
> Andrew
