From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 19 Sep 2024 08:58:13 +0200
Subject: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
In-Reply-To: <OS8PR06MB754148AD165538D3D6B6C3DDF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-3-ryan_chen@aspeedtech.com>
 <b9bf19af-0c3c-4622-9124-a66d9df649b2@kernel.org>
 <OS8PR06MB754148AD165538D3D6B6C3DDF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <195a8bfe-e4d7-4140-9635-b86a6ce3c663@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19/09/2024 08:01, Ryan Chen wrote:
>> Subject: Re: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
>>
>> On 16/09/2024 11:10, Ryan Chen wrote:
>>> Add reset, clock dt bindings for AST2700.
>>>
>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>> ---
>>>  .../dt-bindings/clock/aspeed,ast2700-clk.h    | 163
>> ++++++++++++++++++
>>>  .../dt-bindings/reset/aspeed,ast2700-reset.h  | 124 +++++++++++++
>>>  2 files changed, 287 insertions(+)
>>
>> This is supposed to be part of the commit adding these bindings. You got this
>> comment already, didn't you?
> 
> Sorry, I may mis-understood your point in previous.
> I think you are ask, yaml and dt-binding header to be the same patch, right?

It is one patch adding the binding for the device and headers.

> 
>>
>>>  create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>  create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h
>>>
>>> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>> b/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>> new file mode 100644
>>> index 000000000000..63021af3caf5
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>
>> Use compatible as filename.
> Modify from aspeed,ast2700-clk.h to aspeed, clk-ast2700.h, is it ok?
> How about the aspeed,ast2700-reset.h file name is ok ?

No. For both use the same filename, so the full compatible. FULL.

Best regards,
Krzysztof

