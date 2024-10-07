From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 7 Oct 2024 13:03:11 +0200
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW1BBVENIIHYxIDAxLzEwXSBkdC1iaW5kaW5nOiBt?=
 =?UTF-8?Q?fd=3A_aspeed=2Cast2x00-scu=3A_Add_binding_for_ASPEED_AST2700_SCU?=
In-Reply-To: <PSAPR06MB494964BEE33B160EE5E2159289802@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-2-kevin_chen@aspeedtech.com>
 <e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org>
 <PSAPR06MB494964BEE33B160EE5E2159289802@PSAPR06MB4949.apcprd06.prod.outlook.com>
Message-ID: <8b3b81eb-a0d2-4beb-a2e1-3064ae985f04@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 15/08/2024 07:50, Kevin Chen wrote:
> Hi Krzk,
> 
> I will speperate clock part in the v3 patch into Ryan's clock series.
> 
>> Missing commit msg.
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>>
>> A nit, subject: drop second/last, redundant "bindings for". The
>> "dt-bindings" prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> Agree, already fixed in another commit in Ryan's series.
> [1/4] dt-bindings: mfd: aspeed: support fo

Just to make it clear: you responded after 2.5 months. This patchset is
neither in my mailbox nor in my brain.

Best regards,
Krzysztof

