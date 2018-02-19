From: Joel Stanley <joel@jms.id.au>
Date: Mon, 19 Feb 2018 22:30:54 +1030
Subject: [PATCH 1/3] dt-bindings: aspeed-lpc: Add reset controller
In-Reply-To: <1519040775.3408.6.camel@pengutronix.de>
References: <20180219065438.19933-1-joel@jms.id.au>
 <20180219065438.19933-2-joel@jms.id.au>
 <1519040775.3408.6.camel@pengutronix.de>
Message-ID: <CACPK8Xd1R3dmUfoz4d3b6nG49=ue31d0URRFN9LTpb0QEn5Rcw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 19, 2018 at 10:16 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2018-02-19 at 17:24 +1030, Joel Stanley wrote:
>> This describes the reset controller present in the LPC address space.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  .../devicetree/bindings/mfd/aspeed-lpc.txt          | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
>> index 514d82ced95b..721a2b1eb40f 100644
>> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
>> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
>> @@ -135,3 +135,24 @@ lhc: lhc at 20 {
>>       compatible = "aspeed,ast2500-lhc";
>>       reg = <0x20 0x24 0x48 0x8>;
>>  };
>> +
>> +LPC reset control
>> +-----------------
>> +
>> +The UARTs present in the ASPEED SoC can have their resets tied to the reset
>> +state of the LPC bus. Some systems may chose to modify this configuration.
>> +
>> +Required properties:
>> +
>> + - comaptible:               "aspeed,ast2500-lpc-reset" or
>
> "compatible"
>
>> +                     "aspeed,ast2400-lpc-reset"
>> + - reg:                      offset and length of the IP in the LHC memory region
>> + - #reset-controller indacates the number of reset cells excepted
>
> "indicates", "expected"

Oops, thanks.
>
>> +
>> +Example:
>> +
>> +lpc_reset: reset-controller at 18 {
>> +        compatible = "aspeed,ast2500-lpc-reset";
>> +        reg = <0x18 0x4>;
>> +        #reset-cells = <1>;
>> +};
>
> Should this mention or indicate in the example that the reset-controller
> node must be child of (a subnode of) the lpc node?

This is indicated by the layout of the binding document. The "LPC
reset control" heading is below a "Host Node Children" heading.

>
> regards
> Philipp
