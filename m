From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 2 Sep 2024 08:57:30 +0200
Subject: [PATCH v6 1/2] dt-bindings: media: convert aspeed-video.txt to
 dt-schema
In-Reply-To: <TYZPR06MB65685EF88A548AEC26A54EC8F1922@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20240829064508.3706672-1-jammy_huang@aspeedtech.com>
 <20240829064508.3706672-2-jammy_huang@aspeedtech.com>
 <8ce757a9-ea4c-4dd2-8aaa-e04f21eb3f63@kernel.org>
 <TYZPR06MB65685EF88A548AEC26A54EC8F1922@TYZPR06MB6568.apcprd06.prod.outlook.com>
Message-ID: <3afc4f40-83ac-4ad1-be58-af33168273ac@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/09/2024 03:44, Jammy Huang wrote:
> Hi Krzysztof,
> 
> 
> On 2024/8/29 ?? 03:56, Krzysztof Kozlowski wrote:
>>
>> On 29/08/2024 08:45, Jammy Huang wrote:
>>> Convert the ASPEED SoCs video txt bindings to dt-schema.
>>>
>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>> ---
>>>  .../bindings/media/aspeed,video-engine.yaml   | 78
>> +++++++++++++++++++
>>>  .../bindings/media/aspeed-video.txt           | 33 --------
>>>  2 files changed, 78 insertions(+), 33 deletions(-)  create mode
>>> 100644
>>> Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
>>>  delete mode 100644
>>> Documentation/devicetree/bindings/media/aspeed-video.txt
>>
>> Fix the paths in kernel (git grep).
> Sorry, I don't know exactly how to fix that.
> Do you mean I need to change the file name from 'drivers/media/platform/aspeed/aspeed-video.c'
> to ' drivers/media/platform/aspeed/aspeed-video-engine.c'???

No. You have warnings for stale paths.

Best regards,
Krzysztof

