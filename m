From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2019 10:00:28 -0500
Subject: [PATCH 0/5] Aspeed: Enable video engine
In-Reply-To: <b524e352-2e9d-6360-5517-18eee2e02c2c@xs4all.nl>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <b524e352-2e9d-6360-5517-18eee2e02c2c@xs4all.nl>
Message-ID: <f3cacd11-c68d-9097-4a86-3ebeab046b93@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/24/19 5:50 AM, Hans Verkuil wrote:
> Hi Eddie,
>
> On 4/2/19 8:24 PM, Eddie James wrote:
>> This series enables the video engine on Aspeed BMC platforms. The video engine
>> clocking is added to the Aspeed clock driver. The use of the video engine reset
>> line, originally planned to be made externally available in the clock driver,
>> is removed from the video engine driver. Finally a node for the video engine is
>> added to the AST2500 devicetree.
>> The series also includes a missing property for reserved memory in the
>> devicetree documentation, and a small change to make the video engine driver
>> start without reserved memory.
> I assume you'll post a v3 since there were some comments?


Sure... The only change would be a missing semi-colon in the devicetree 
doc. And we're only on v2 :)


>
> If you want to get it in for 5.2, then be aware that you should post it tomorrow
> at the latest.
>
> Regards,
>
> 	Hans
>
>> Eddie James (5):
>>    media: platform: Aspeed: Remove use of reset line
>>    media: platform: Aspeed: Make reserved memory optional
>>    media: dt-bindings: aspeed-video: Add missing memory-region property
>>    clk: Aspeed: Setup video engine clocking
>>    ARM: dts: aspeed-g5: Add video engine
>>
>>   .../devicetree/bindings/media/aspeed-video.txt     |  6 ++++
>>   arch/arm/boot/dts/aspeed-g5.dtsi                   | 10 ++++++
>>   drivers/clk/clk-aspeed.c                           | 42 ++++++++++++++++++++--
>>   drivers/media/platform/aspeed-video.c              | 33 ++++-------------
>>   4 files changed, 61 insertions(+), 30 deletions(-)
>>

